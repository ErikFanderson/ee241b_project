#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# Author: Erik Anderson
# Email: erik.francis.anderson@gmail.com
# Date: 03/02/2020
"""Docstring for module jinja tool """

# Imports - standard library
import os
from abc import ABC, abstractmethod
from typing import List, Callable, Any, Optional
from pathlib import Path
import getpass
from datetime import datetime
import shutil

# Imports - 3rd party packages
from jinja2 import StrictUndefined, FileSystemLoader, Environment
from toolbox.database import Database
from toolbox.logger import LogLevel, HasLogFunction
from toolbox.tool import Tool, ToolError
from toolbox.utils import Validator

# Imports - local source
from prga.api.context import *
from prga.api.config import *
from prga.api.flow import *

# NOTES
"""
This FPGA architecture assumes that there is only 1 global
clock that is input from a single IO block input (there are
a configurable number of IOBs in each IO tile, but the global
clock will be attached to just 1 of these IOB inputs from a specific
tile). 

The CLBs have 0 connections on the north and west sides. This is
to stay consistent with prior work where the generated tile is simply
two CBs, one on the east and the other on the south, and a SB in the 
SE corner.
"""


class FPGAGenTool(Tool):
    """Base jinja Tool w/ render function. Still Abstract"""
    def __init__(self, db: Database, log: Callable[[str, LogLevel], None]):
        """Creates an island-style FPGA using PRGA flow"""
        super(FPGAGenTool, self).__init__(db, log)
        self.context = None
        self.clock = None
        self.clbtile = None
        self.iotiles = None
        self.ns = self.get_db(self.get_namespace("FPGAGenTool"))

    def steps(self):
        return [
            self.build_context, self.build_routing_resources,
            self.build_io_blocks, self.build_clbs, self.build_custom_tiles,
            self.array_tiles, self.render_fpga
        ]

    def build_context(self):
        """Make basic arch context"""
        self.context = ArchitectureContext('top', self.ns["num_rows"],
                                           self.ns["num_columns"],
                                           BitchainConfigCircuitryDelegate)

    def build_routing_resources(self):
        """PRGA only supports uni-directional straight wires"""
        # Global routing
        r = self.ns["global_clock_row"]
        c = self.ns["global_clock_column"]
        self.clock = self.context.create_global('clk',
                                                is_clock=True,
                                                bind_to_position=(c, r))
        # Segment routing (name, width, length)
        for seg in self.ns["segments"]:
            self.context.create_segment(seg["name"], seg["width"],
                                        seg["length"])

    def build_io_blocks(self):
        """Builds all of the IO blocks at the periphery of the FPGA"""
        # Create block - block name, capacity (#blocks per tile)
        iob = self.context.create_io_block(
            'iob', self.ns["num_io_blocks_per_io_tile"])

        # Create ports
        clkport = iob.create_global(self.clock)
        outpad = iob.create_input('outpad', 1)
        inpad = iob.create_output('inpad', 1)

        # Instantiate modules inside IOB
        iff = iob.instantiate(self.context.primitives['flipflop'], 'iff')
        off = iob.instantiate(self.context.primitives['flipflop'], 'off')

        # Connect IOB ports to internal modules
        ioinst = iob.instances['io']  # Built-in sub-instance io??
        iob.connect(clkport, iff.pins['clk'])
        iob.connect(ioinst.pins['inpad'], iff.pins['D'])
        iob.connect(iff.pins['Q'], inpad)
        iob.connect(ioinst.pins['inpad'], inpad)
        iob.connect(clkport, off.pins['clk'])
        iob.connect(off.pins['Q'], ioinst.pins['outpad'])
        iob.connect(outpad, ioinst.pins['outpad'])
        iob.connect(outpad, off.pins['D'])

        # Create IO tiles (N, E, S, W)
        self.iotiles = {}
        for orient in iter(Orientation):
            if orient.is_auto:
                continue
            self.iotiles[orient] = self.context.create_tile(
                f"io_tile_{orient.name}", iob, orient)

    def build_clbs(self):
        """Builds and assembles CLB tiles"""
        # Create clb
        clb = self.context.create_logic_block('clb')

        # Create inputs to CLB
        clkport = clb.create_global(self.clock, Orientation.south)
        ceport = clb.create_input('ce', 1, Orientation.south)
        srport = clb.create_input('sr', 1, Orientation.south)
        cin = clb.create_input('cin', 1, Orientation.north)

        # Create outputs to CLB
        cout = clb.create_output('cout', 1, Orientation.south)

        # Create internal LUTs for CLB
        for i in range(self.ns["num_bles_per_clb"]):
            # "fraclut6sffc" is a multi-modal primitive specific to the
            # 'bitchain'-type configuration circuitry. It consists of a fractuable
            # 6-input LUT that can be used as two 5-input LUTs, two D-flipflops, and
            # a look-ahead carry chain
            inst = clb.instantiate(self.context.primitives['fraclut6sffc'],
                                   'cluster{}'.format(i))
            # Create ports for clb
            ia = clb.create_input('ia' + str(i), 6, Orientation.west)
            ib = clb.create_input('ib' + str(i), 1, Orientation.west)
            oa = clb.create_output('oa' + str(i), 1, Orientation.east)
            ob = clb.create_output('ob' + str(i), 1, Orientation.east)
            q = clb.create_output('q' + str(i), 1, Orientation.east)
            # Connect basic IO
            clb.connect(clkport, inst.pins['clk'])
            clb.connect(ceport, inst.pins['ce'])
            clb.connect(srport, inst.pins['sr'])
            clb.connect(ia, inst.pins['ia'])
            clb.connect(ib, inst.pins['ib'])
            clb.connect(inst.pins['oa'], oa)
            clb.connect(inst.pins['ob'], ob)
            clb.connect(inst.pins['q'], q)
            # Connect carry chain through BLEs
            clb.connect(cin, inst.pins['cin'], pack_pattern='carrychain')
            cin = inst.pins['cout']
        clb.connect(cin, cout, pack_pattern='carrychain')

        # Create tile
        self.clbtile = self.context.create_tile('clb_tile', clb)

    def build_custom_tiles(self):
        self.log("Custom tile step not yet implemented", LogLevel.WARNING)

    def array_tiles(self):
        """All bottom IO tiles are south. All top IO tiles are north.
        I.e. the corner tiles all point north or south
        """
        for x in range(self.ns["num_columns"]):
            for y in range(self.ns["num_rows"]):
                if x == 0 and y > 0 and y < self.ns["num_rows"] - 1:
                    self.context.top.instantiate_element(
                        self.iotiles[Orientation.west], (x, y))
                elif x == self.ns["num_columns"] - 1 and y > 0 and y < self.ns[
                        "num_rows"] - 1:
                    self.context.top.instantiate_element(
                        self.iotiles[Orientation.east], (x, y))
                elif y == 0:
                    self.context.top.instantiate_element(
                        self.iotiles[Orientation.south], (x, y))
                elif y == self.ns["num_rows"] - 1:
                    self.context.top.instantiate_element(
                        self.iotiles[Orientation.north], (x, y))
                else:
                    self.context.top.instantiate_element(self.clbtile, (x, y))

    def render_fpga(self):
        flow = Flow((
            # this pass automatically creates, places and populates connection/switch boxes
            # First value is f_cbox_in, second value is f_cbox_out
            CompleteRoutingBox(
                BlockFCValue(BlockPortFCValue(self.ns["fc_in"]),
                             BlockPortFCValue(self.ns["fc_out"]))),

            # this pass implements the configurable connections with switches
            CompleteSwitch(),

            # this pass automatically connects the pins/ports of blocks, routing
            # boxes, tiles and arrays
            CompleteConnection(),

            # this pass generates the RTL
            GenerateVerilog('rtl'),

            # this pass injects bitchain-style configuration circuitry into the
            # architecture
            InjectBitchainConfigCircuitry(),

            ## this pass generates all the files needed to run VPR
            #GenerateVPRXML('vpr'),

            # this pass materializes all the modules, connections into physical stuff
            CompletePhysical(),

            ## this pass is an optional pass but highly recommended. It makes sure the
            ## write-enable is deactivated when a BRAM is not used
            #ZeroingBRAMWriteEnable(),

            # this pass is an optional pass but highly recommended, especially if
            # support for post-implementation simulation is needed. It makes sure
            # all block pins are connected to constant-zero when not used,
            # preventing combinational loops during simulation
            ZeroingBlockPins(),

            # this pass generates all the files needed to run Yosys
            GenerateYosysResources('syn'),
        ))
        flow.run(self.context)
        # Move files into build directory
        dirs = ["rtl", "vpr", "syn"]
        for d in dirs:
            if Path(d).is_dir():
                shutil.move(
                    d,
                    os.path.join(self.get_db("internal.job_dir"), f"prga/{d}"))
