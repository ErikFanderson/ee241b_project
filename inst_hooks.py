#!/usr/bin/env python3
# -*- coding: utf-8 -*-
#
#  inst-hooks.py
#

import argparse
import json
import os
import subprocess
import sys

import hammer_vlsi

from typing import List, Dict, Tuple, Any, Iterable, Callable, Optional


def inst_place_tap_cells(x: hammer_vlsi.HammerTool) ->  bool:
    x.append('''set WT_INT 100 
add_well_taps -cell_interval $WT_INT''')
    return True

def inst_innovus_settings(x: hammer_vlsi.HammerTool) -> bool:
    x.append('''
# Well Taps Cell Definition for Powerstraps (Using DCAP because SAED32 has integrated well taps)
set_db add_well_taps_cell DCAP_HVT

# Filler Attributes [get_db -category add_fillers]
# ------------------------------------------------------------------------------------------------
set_db add_fillers_cells \"SHFILL128_HVT SHFILL64_HVT SHFILL3_HVT SHFILL2_HVT SHFILL1_HVT\"

# Routing Attributes [get_db -category route]
# ------------------------------------------------------------------------------------------------
set_db route_design_via_weight \"VIA12SQ_CR 5 VIA12SQ_C 4 VIA12BAR2_C -1 VIA12LG_C -1 VIA12SQ -1 VIA12BAR1 -1 VIA12BAR2 -1 VIA12LG -1\"
set_db route_design_detail_on_grid_only false
set_db route_design_with_via_in_pin {1:1}
set_db route_design_with_via_only_for_lib_cell_pin true
set_db route_design_bottom_routing_layer 2
set_db route_design_detail_post_route_spread_wire false

set_db route_design_concurrent_minimize_via_count_effort high
set_db route_design_detail_post_route_swap_via true
set_db opt_consider_routing_congestion true
    ''')
    return True

def inst_define_pins(x: hammer_vlsi.HammerTool) -> bool:
    # x.verbose_append("edit_pin -pin clk -spread_type SIDE -side LEFT -layer M5 -fixed_pin".format(top=x.top_module))
    x.append('''
edit_pin -pin clk -side LEFT -layer 3 -fix_overlap 1 -assign 0.0 0.0 -use clock
edit_pin -side LEFT -layer 3 -pin [get_db [get_db ports -if {.name == operands_bits_A*}] .name] -spread_type start -unit track -spread_direction clockwise -spacing 15 -start {0 2}
edit_pin -side TOP -layer 2 -pin [get_db [get_db ports -if {.name == operands_bits_B*}] .name] -spread_type start -unit track -spread_direction clockwise -spacing 15 -start {2 35}
edit_pin -side BOTTOM -layer 2 -pin {{operands_rdy} {operands_val} {reset}} -spread_type start -unit track -spread_direction counterclockwise -spacing 10 -start {2 0}
edit_pin -side BOTTOM -layer 2 -pin {{result_rdy} {result_val}} -spread_type start -unit track -spread_direction clockwise -spacing 10 -start {28 0}
edit_pin -side RIGHT -layer 3 -pin [get_db [get_db ports -if {.name == result_bits_data*}] .name] -spread_type start -unit track -spread_direction clockwise -spacing 15 -start {28 35}
    ''')
    return True

def inst_legalize_placement(x: hammer_vlsi.HammerTool) -> bool:
    x.verbose_append("legalize_floorplan -check_site".format(top=x.top_module))
    return True

def inst_place_filler(x: hammer_vlsi.HammerTool) -> bool:
    # x.append("set_db add_fillers_cells \"SHFILL128_HVT SHFILL64_HVT SHFILL3_HVT SHFILL2_HVT SHFILL1_HVT\"")
    x.append("add_fillers")
    return True

def inst_weigh_vias(x: hammer_vlsi.HammerTool) -> bool:
    # x.append("set_db route_design_via_weight \"VIA12SQ_CR 5 VIA12SQ_C 5\"")
    return True

def inst_route_design(x: hammer_vlsi.HammerTool) -> bool:
    # x.append("check_design -type route")
    # x.append("set_db route_design_with_via_in_pin TRUE")
    x.append("route_design")
    return True
