#!/usr/bin/env python3
# -*- coding: utf-8 -*-
#
#  hammer-vlsi plugin for Cadence Innovus.
#
#  See LICENSE for licence details.

import shutil
from typing import List, Dict, Optional, Callable, Tuple, Set, Any, cast
from itertools import product

import os
import errno
import json

from hammer_utils import get_or_else, optional_map, coerce_to_grid, check_on_grid, lcm_grid
from hammer_vlsi import HammerTool, HammerPlaceAndRouteTool, CadenceTool, HammerToolStep, HammerToolHookAction, \
    PlacementConstraintType, HierarchicalMode, ILMStruct, ObstructionType, Margins, Supply, PlacementConstraint
from hammer_logging import HammerVLSILogging
import hammer_tech
from hammer_tech import RoutingDirection, Metal
import specialcells
from specialcells import CellType, SpecialCell
from decimal import Decimal

# Notes: camelCase commands are the old syntax (deprecated)
# snake_case commands are the new/common UI syntax.
# This plugin should only use snake_case commands.

class Innovus(HammerPlaceAndRouteTool, CadenceTool):

    def export_config_outputs(self) -> Dict[str, Any]:
        outputs = dict(super().export_config_outputs())
        # TODO(edwardw): find a "safer" way of passing around these settings keys.
        outputs["par.outputs.seq_cells"] = self.output_seq_cells
        outputs["par.outputs.all_regs"] = self.output_all_regs
        outputs["par.outputs.sdf_file"] = self.output_sdf_path
        return outputs

    def fill_outputs(self) -> bool:
        if self.ran_write_ilm:
            # Check that the ILMs got written.

            ilm_data_dir = "{ilm_dir_name}/mmmc/ilm_data/{top}".format(ilm_dir_name=self.ilm_dir_name,
                                                                       top=self.top_module)
            postRoute_v_gz = os.path.join(ilm_data_dir, "{top}_postRoute.v.gz".format(top=self.top_module))

            if not os.path.isfile(postRoute_v_gz):
                raise ValueError("ILM output postRoute.v.gz %s not found" % (postRoute_v_gz))

            # Copy postRoute.v.gz to postRoute.ilm.v.gz since that's what Genus seems to expect.
            postRoute_ilm_v_gz = os.path.join(ilm_data_dir, "{top}_postRoute.ilm.v.gz".format(top=self.top_module))
            shutil.copyfile(postRoute_v_gz, postRoute_ilm_v_gz)

            # Write output_ilms.
            self.output_ilms = [
                ILMStruct(dir=self.ilm_dir_name, data_dir=ilm_data_dir, module=self.top_module,
                          lef=os.path.join(self.run_dir, "{top}ILM.lef".format(top=self.top_module)),
                          gds=self.output_gds_filename,
                          netlist=self.output_netlist_filename)
            ]
        else:
            self.output_ilms = []

        self.output_gds = self.output_gds_filename
        self.output_netlist = self.output_netlist_filename
        self.output_sim_netlist = self.output_sim_netlist_filename
        self.hcells_list = []

        if not os.path.isfile(self.all_regs_path):
            raise ValueError("Output find_regs.json %s not found" % (self.all_regs_path))

        with open(self.all_regs_path, "r") as f:
            j = json.load(f)
            self.output_seq_cells = j["seq_cells"]
            reg_paths = j["reg_paths"]
            for i in range(len(reg_paths)):
                split = reg_paths[i].split("/")
                if split[-2][-1] == "]":
                    split[-2] = "\\" + split[-2]
                    reg_paths[i] = {"path" : '/'.join(split[0:len(split)-1]), "pin" : split[-1]}
                else:
                    reg_paths[i] = {"path" : '/'.join(split[0:len(split)-1]), "pin" : split[-1]}
            self.output_all_regs = reg_paths

        if not os.path.isfile(self.output_sdf_path):
            raise ValueError("Output SDF %s not found" % (self.output_sdf_path))
        self.sdf_file = self.output_sdf_path
        return True

    @property
    def output_gds_filename(self) -> str:
        return os.path.join(self.run_dir, "{top}.gds".format(top=self.top_module))

    @property
    def output_netlist_filename(self) -> str:
        return os.path.join(self.run_dir, "{top}.lvs.v".format(top=self.top_module))

    @property
    def output_sim_netlist_filename(self) -> str:
        return os.path.join(self.run_dir, "{top}.sim.v".format(top=self.top_module))

    @property
    def all_regs_path(self) -> str:
        return os.path.join(self.run_dir, "find_regs.json")

    @property
    def output_sdf_path(self) -> str:
        return os.path.join(self.run_dir, "{top}.par.sdf".format(top=self.top_module))

    @property
    def env_vars(self) -> Dict[str, str]:
        v = dict(super().env_vars)
        v["INNOVUS_BIN"] = self.get_setting("par.innovus.innovus_bin")
        return v

    @property
    def _step_transitions(self) -> List[Tuple[str, str]]:
        """
        Private helper property to keep track of which steps we ran so that we
        can create symlinks.
        This is a list of (pre, post) steps
        """
        return self.attr_getter("__step_transitions", [])

    @_step_transitions.setter
    def _step_transitions(self, value: List[Tuple[str, str]]) -> None:
        self.attr_setter("__step_transitions", value)

    def do_pre_steps(self, first_step: HammerToolStep) -> bool:
        assert super().do_pre_steps(first_step)
        # Restore from the last checkpoint if we're not starting over.
        if first_step.name != "init_design":
            self.verbose_append("read_db pre_{step}".format(step=first_step.name))
        return True

    def do_between_steps(self, prev: HammerToolStep, next: HammerToolStep) -> bool:
        assert super().do_between_steps(prev, next)
        # Write a checkpoint to disk.
        self.verbose_append("write_db pre_{step}".format(step=next.name))
        # Symlink the database to latest for open_chip script later.
        self.verbose_append("ln -sfn pre_{step} latest".format(step=next.name))
        self._step_transitions = self._step_transitions + [(prev.name, next.name)]
        return True

    def do_post_steps(self) -> bool:
        assert super().do_post_steps()
        # Create symlinks for post_<step> to pre_<step+1> to improve usability.
        try:
            for prev, next in self._step_transitions:
                os.symlink(
                    os.path.join(self.run_dir, "pre_{next}".format(next=next)), # src
                    os.path.join(self.run_dir, "post_{prev}".format(prev=prev)) # dst
                )
        except OSError as e:
            if e.errno != errno.EEXIST:
                self.logger.warning("Failed to create post_* symlinks: " + str(e))

        # Create db post_<last step>
        # TODO: this doesn't work if you're only running the very last step
        if len(self._step_transitions) > 0:
            last = "post_{step}".format(step=self._step_transitions[-1][1])
            self.verbose_append("write_db {last}".format(last=last))
            # Symlink the database to latest for open_chip script later.
            self.verbose_append("ln -sfn {last} latest".format(last=last))

        # Create open_chip script pointing to post_<last step>.
        with open(self.open_chip_tcl, "w") as f:
            f.write("read_db latest")

        with open(self.open_chip_script, "w") as f:
            f.write("""#!/bin/bash
        cd {run_dir}
        source enter
        $INNOVUS_BIN -common_ui -win -files {open_chip_tcl}
                """.format(run_dir=self.run_dir, open_chip_tcl=self.open_chip_tcl))
        os.chmod(self.open_chip_script, 0o755)

        return self.run_innovus()

    def get_tool_hooks(self) -> List[HammerToolHookAction]:
        return [self.make_persistent_hook(innovus_global_settings)]

    @property
    def steps(self) -> List[HammerToolStep]:
        steps = [
            self.init_design,
            self.floorplan_design,
            self.place_bumps,
            self.place_tap_cells,
            self.power_straps,
            self.place_pins,
            self.place_opt_design,
            self.clock_tree,
            self.add_fillers,
            self.route_design,
            self.opt_design
        ]
        write_design_step = [
            self.write_regs,
            self.write_design
        ]  # type: List[Callable[[], bool]]
        if self.hierarchical_mode == HierarchicalMode.Flat:
            # Nothing to do
            pass
        elif self.hierarchical_mode == HierarchicalMode.Leaf:
            # All modules in hierarchical must write an ILM
            write_design_step += [self.write_ilm]
        elif self.hierarchical_mode == HierarchicalMode.Hierarchical:
            # All modules in hierarchical must write an ILM
            write_design_step += [self.write_ilm]
        elif self.hierarchical_mode == HierarchicalMode.Top:
            # No need to write ILM at the top.
            # Top needs assemble_design instead.
            steps += [self.assemble_design]
            pass
        else:
            raise NotImplementedError("HierarchicalMode not implemented: " + str(self.hierarchical_mode))
        return self.make_steps_from_methods(steps + write_design_step)

    def tool_config_prefix(self) -> str:
        return "par.innovus"

    def init_design(self) -> bool:
        """Initialize the design."""
        verbose_append = self.verbose_append

        # Perform common path pessimism removal in setup and hold mode
        verbose_append("set_db timing_analysis_cppr both")
        # Use OCV mode for timing analysis by default
        verbose_append("set_db timing_analysis_type ocv")
        # Match SDC time units to timing libraries
        verbose_append("set_library_unit -time 1{}".format(self.get_time_unit().value_prefix + self.get_time_unit().unit))

        # Read LEF layouts.
        lef_files = self.technology.read_libs([
            hammer_tech.filters.lef_filter
        ], hammer_tech.HammerTechnologyUtils.to_plain_item)
        if self.hierarchical_mode.is_nonleaf_hierarchical():
            ilm_lefs = list(map(lambda ilm: ilm.lef, self.get_input_ilms()))
            lef_files.extend(ilm_lefs)
        verbose_append("read_physical -lef {{ {files} }}".format(
            files=" ".join(lef_files)
        ))

        # Read timing libraries.
        mmmc_path = os.path.join(self.run_dir, "mmmc.tcl")
        with open(mmmc_path, "w") as f:
            f.write(self.generate_mmmc_script())
        verbose_append("read_mmmc {mmmc_path}".format(mmmc_path=mmmc_path))

        # Read netlist.
        # Innovus only supports structural Verilog for the netlist; the Verilog can be optionally compressed.
        if not self.check_input_files([".v", ".v.gz"]):
            return False

        # We are switching working directories and we still need to find paths.
        abspath_input_files = list(map(lambda name: os.path.join(os.getcwd(), name), self.input_files))
        verbose_append("read_netlist {{ {files} }} -top {top}".format(
            files=" ".join(abspath_input_files),
            top=self.top_module
        ))

        if self.hierarchical_mode.is_nonleaf_hierarchical():
            # Read ILMs.
            for ilm in self.get_input_ilms():
                # Assumes that the ILM was created by Innovus (or at least the file/folder structure).
                verbose_append("read_ilm -cell {module} -directory {dir}".format(dir=ilm.dir, module=ilm.module))

        # Emit init_power_nets and init_ground_nets in case CPF/UPF is not used
        # commit_power_intent does not override power nets defined in "init_power_nets"
        spec_mode = self.get_setting("vlsi.inputs.power_spec_mode")  # type: str
        if spec_mode == "empty":
            power_supplies = self.get_independent_power_nets()  # type: List[Supply]
            power_nets = " ".join(map(lambda s: s.name, power_supplies))
            ground_supplies = self.get_independent_ground_nets()  # type: List[Supply]
            ground_nets = " ".join(map(lambda s: s.name, ground_supplies))
            verbose_append("set_db init_power_nets {{{n}}}".format(n=power_nets))
            verbose_append("set_db init_ground_nets {{{n}}}".format(n=ground_nets))

        # Run init_design to validate data and start the Cadence place-and-route workflow.
        verbose_append("init_design")

        # Setup power settings from cpf/upf
        for l in self.generate_power_spec_commands():
            verbose_append(l)

        # Set design effort.
        verbose_append("set_db design_flow_effort {}".format(self.get_setting("par.innovus.design_flow_effort")))

        # Set "don't use" cells.
        for l in self.generate_dont_use_commands():
            self.append(l)

        return True

    def floorplan_design(self) -> bool:
        floorplan_tcl = os.path.join(self.run_dir, "floorplan.tcl")
        with open(floorplan_tcl, "w") as f:
            f.write("\n".join(self.create_floorplan_tcl()))
        self.verbose_append("source -echo -verbose {}".format(floorplan_tcl))
        return True

    def place_bumps(self) -> bool:
        bumps = self.get_bumps()
        if bumps is not None:
            bump_array_width = Decimal(str((bumps.x - 1) * bumps.pitch))
            bump_array_height = Decimal(str((bumps.y - 1) * bumps.pitch))
            fp_consts = self.get_placement_constraints()
            fp_width = Decimal(0)
            fp_height = Decimal(0)
            for const in fp_consts:
                if const.type == PlacementConstraintType.TopLevel:
                    fp_width = const.width
                    fp_height = const.height
            if fp_width == 0 or fp_height == 0:
                raise ValueError("Floorplan does not specify a TopLevel constraint or it has no dimensions")
            # Center bump array in the middle of floorplan
            bump_offset_x = (Decimal(str(fp_width)) - bump_array_width) / 2
            bump_offset_y = (Decimal(str(fp_height)) - bump_array_height) / 2
            power_ground_nets = list(map(lambda x: x.name, self.get_independent_power_nets() + self.get_independent_ground_nets()))
            # TODO: Fix this once the stackup supports vias ucb-bar/hammer#354
            block_layer = self.get_setting("vlsi.technology.bump_block_cut_layer")  # type: str
            for bump in bumps.assignments:
                self.append("create_bump -cell {cell} -location_type cell_center -name_format \"Bump_{c}.{r}\" -orient r0 -location \"{x} {y}\"".format(
                    cell = bump.custom_cell if bump.custom_cell is not None else bumps.cell,
                    c = bump.x,
                    r = bump.y,
                    x = bump_offset_x + Decimal(str(bump.x - 1)) * Decimal(str(bumps.pitch)),
                    y = bump_offset_y + Decimal(str(bump.y - 1)) * Decimal(str(bumps.pitch))))
                if not bump.no_connect:
                    if bump.name in power_ground_nets:
                        self.append("select_bumps -bumps \"Bump_{x}.{y}\"".format(x=bump.x, y=bump.y))
                        self.append("assign_pg_bumps -selected -nets {n}".format(n=bump.name))
                        self.append("deselect_bumps")
                    else:
                        self.append("assign_signal_to_bump -bumps \"Bump_{x}.{y}\" -net {n}".format(x=bump.x, y=bump.y, n=bump.name))
                self.append("create_route_blockage {layer_options} \"{llx} {lly} {urx} {ury}\"".format(
                    layer_options="-layers {{{l}}} -rects".format(l=block_layer) if(self.version() >= self.version_number("181")) else "-cut_layers {{{l}}} -area".format(l=block_layer),
                    llx = "[get_db bump:Bump_{x}.{y} .bbox.ll.x]".format(x=bump.x, y=bump.y),
                    lly = "[get_db bump:Bump_{x}.{y} .bbox.ll.y]".format(x=bump.x, y=bump.y),
                    urx = "[get_db bump:Bump_{x}.{y} .bbox.ur.x]".format(x=bump.x, y=bump.y),
                    ury = "[get_db bump:Bump_{x}.{y} .bbox.ur.y]".format(x=bump.x, y=bump.y)))
        return True

    def place_tap_cells(self) -> bool:
        tap_cell = self.technology.get_special_cell_by_type(CellType.TapCell)

        if len(tap_cell) == 0:
            self.logger.warning("Tap cells are improperly defined in the tech plugin and will not be added. This step should be overridden with a user hook.")
            return True

        tap_cell = tap_cell[0].name[0]

        try:
            interval = self.get_setting("vlsi.technology.tap_cell_interval")
            offset = self.get_setting("vlsi.technology.tap_cell_offset")
            self.append("set_db add_well_taps_cell {TAP_CELL}".format(TAP_CELL=tap_cell))
            self.append("add_well_taps -cell_interval {INTERVAL} -in_row_offset {OFFSET}".format(INTERVAL=interval, OFFSET=offset))
        except KeyError:
            pass
        finally:
            self.logger.warning(
                "You have not overridden place_tap_cells. By default this step adds a simple set of tapcells or does nothing; you will have trouble with power strap creation later.")
        return True

    def place_pins(self) -> bool:
        fp_consts = self.get_placement_constraints()
        topconst = None  # type: Optional[PlacementConstraint]
        for const in fp_consts:
            if const.type == PlacementConstraintType.TopLevel:
                topconst = const
        if topconst is None:
            self.logger.fatal("Cannot find top-level constraints to place pins")
            return False

        const = cast(PlacementConstraint, topconst)
        assert isinstance(const.margins, Margins), "Margins must be defined for the top level"
        fp_llx = const.margins.left
        fp_lly = const.margins.bottom
        fp_urx = const.width - const.margins.right
        fp_ury = const.height - const.margins.top

        pin_assignments = self.get_pin_assignments()
        self.verbose_append("set_db assign_pins_edit_in_batch true")
        for pin in pin_assignments:
            if pin.preplaced:
                # First set promoted pins
                self.verbose_append("set_promoted_macro_pin -pins {{ {p} }}".format(p=pin.pins))
            else:
                # TODO: Do we need pin blockages for our layers?
                # Seems like we will only need special pin blockages if the vias are larger than the straps

                cadence_side = None  # type: Optional[str]
                if pin.side is not None:
                    if pin.side == "internal":
                        cadence_side = "inside"
                    else:
                        cadence_side = pin.side
                side_arg = get_or_else(optional_map(cadence_side, lambda s: "-side " + s), "")

                start_arg = ""
                end_arg = ""
                assign_arg = ""
                pattern_arg = ""

                if pin.location is None:
                    start_arg = "-{start} {{ {sx} {sy} }}".format(
                        start="start" if pin.side == "bottom" or pin.side == "right" else "end",
                        sx=fp_urx if pin.side != "left" else fp_llx,
                        sy=fp_ury if pin.side != "bottom" else fp_lly)

                    end_arg = "-{end} {{ {ex} {ey} }}".format(
                        end="end" if pin.side == "bottom" or pin.side == "right" else "start",
                        ex=fp_llx if pin.side != "right" else fp_urx,
                        ey=fp_lly if pin.side != "top" else fp_ury
                    )
                    pattern_arg = "-pattern fill_optimised"
                else:
                    assign_arg = "-assign {{ {x} {y} }}".format(x=pin.location[0], y=pin.location[1])

                layers_arg = ""
                if pin.layers is not None and len(pin.layers) > 0:
                    layers_arg = "-layer {{ {} }}".format(" ".join(pin.layers))

                width_arg = get_or_else(optional_map(pin.width, lambda f: "-pin_width {f}".format(f=f)), "")
                depth_arg = get_or_else(optional_map(pin.depth, lambda f: "-pin_depth {f}".format(f=f)), "")

                cmd = [
                    "edit_pin",
                    "-fixed_pin",
                    "-pin", pin.pins,
                    "-hinst", self.top_module,
                    pattern_arg,
                    layers_arg,
                    side_arg,
                    start_arg,
                    end_arg,
                    assign_arg,
                    width_arg,
                    depth_arg
                ]

                self.verbose_append(" ".join(cmd))
        self.verbose_append("set_db assign_pins_edit_in_batch false")
        return True

    def power_straps(self) -> bool:
        """Place the power straps for the design."""
        power_straps_tcl = os.path.join(self.run_dir, "power_straps.tcl")
        with open(power_straps_tcl, "w") as f:
            f.write("\n".join(self.create_power_straps_tcl()))
        self.verbose_append("source -echo -verbose {}".format(power_straps_tcl))
        return True

    def place_opt_design(self) -> bool:
        """Place the design and do pre-routing optimization."""
        self.verbose_append("place_opt_design")
        return True

    def clock_tree(self) -> bool:
        """Setup and route a clock tree for clock nets."""
        if len(self.get_clock_ports()) > 0:
            # Ignore clock tree when there are no clocks
            self.verbose_append("create_clock_tree_spec")
            if bool(self.get_setting("par.innovus.use_cco")):
                # -hold is a secret flag for ccopt_design (undocumented anywhere)
                self.verbose_append("ccopt_design -hold -report_dir hammer_cts_debug -report_prefix hammer_cts")
            else:
                self.verbose_append("clock_design")
        return True

    def add_fillers(self) -> bool:
        """add filler cells"""
        stdfiller = self.technology.get_special_cell_by_type(CellType.StdFiller)

        if len(stdfiller) == 0:
            self.logger.warning(
                "The technology plugin 'special cells: stdfiller' field does not exist. It should specify a list of (non IO) filler cells. No filler will be added. You can override this with an add_fillers hook if you do not specify filler cells in the technology plugin.")
        else:
            stdfiller = stdfiller[0].name
            filler_str = ""
            for cell in stdfiller:
                filler_str += str(cell) + ' '
            self.append("set_db add_fillers_cells \"{FILLER}\"".format(FILLER=filler_str))
            self.append("add_fillers")
        return True


    def route_design(self) -> bool:
        """Route the design."""
        self.verbose_append("route_design")
        return True

    def opt_design(self) -> bool:
        """Post-route optimization and fix setup & hold time violations."""
        self.verbose_append("opt_design -post_route -setup -hold")
        return True

    def assemble_design(self) -> bool:
        # TODO: implement the assemble_design step.
        return True

    def write_netlist(self) -> bool:
        # Don't use virtual connects (using colon, e.g. VSS:) because they mess up LVS
        self.verbose_append("set_db write_stream_virtual_connection false")

        # Connect power nets that are tied together
        for pwr_gnd_net in (self.get_all_power_nets() + self.get_all_ground_nets()):
            if pwr_gnd_net.tie is not None:
                self.verbose_append("connect_global_net {tie} -type net -net_base_name {net}".format(tie=pwr_gnd_net.tie, net=pwr_gnd_net.name))

        # Output the Verilog netlist for the design and include physical cells (-phys) like decaps and fill
        self.verbose_append("write_netlist {netlist} -top_module_first -top_module {top} -exclude_leaf_cells -phys -flat -exclude_insts_of_cells {{ {pcells} }} ".format(
            netlist=self.output_netlist_filename,
            top=self.top_module,
            pcells=" ".join(self.get_physical_only_cells())
        ))

        self.verbose_append("write_netlist {netlist} -top_module_first -top_module {top} -exclude_leaf_cells -exclude_insts_of_cells {{ {pcells} }} ".format(
            netlist=self.output_sim_netlist_filename,
            top=self.top_module,
            pcells=" ".join(self.get_physical_only_cells())
        ))

        return True

    def write_gds(self) -> bool:
        map_file = get_or_else(
            optional_map(self.get_gds_map_file(), lambda f: "-map_file {}".format(f)),
            ""
        )

        gds_files = self.technology.read_libs([
            hammer_tech.filters.gds_filter
        ], hammer_tech.HammerTechnologyUtils.to_plain_item)
        if self.hierarchical_mode.is_nonleaf_hierarchical():
            ilm_gds = list(map(lambda ilm: ilm.gds, self.get_input_ilms()))
            gds_files.extend(ilm_gds)

        # If we are not merging, then we want to use -output_macros.
        # output_macros means that Innovus should take any macros it has and
        # just output the cells into the GDS. These cells will not have physical
        # information inside them and will need to be merged with some other
        # step later. We do not care about uniquifying them because Innovus will
        # output a single cell for each instance (essentially already unique).

        # On the other hand, if we tell Innovus to do the merge then it is going
        # to get a GDS with potentially multiple child cells and we then tell it
        # to uniquify these child cells in case of name collisons. Without that
        # we could have one child that applies to all cells of that name which
        # is often not what you want.
        # For example, if macro ADC1 has a subcell Comparator which is different
        # from ADC2's subcell Comparator, we don't want ADC1's Comparator to
        # replace ADC2's Comparator.
        # Note that cells not present in the GDSes to be merged will be emitted
        # as-is in the output (like with -output_macros).
        merge_options = "-output_macros" if not self.get_setting("par.inputs.gds_merge") else "-uniquify_cell_names -merge {{ {} }}".format(
            " ".join(gds_files)
        )

        self.verbose_append("write_stream -mode ALL {map_file} {merge_options} {gds}".format(
            map_file=map_file,
            merge_options=merge_options,
            gds=self.output_gds_filename
        ))
        return True

    def write_sdf(self) -> bool:

        # Output the Standard Delay Format File for use in timing annotated gate level simulations
        self.verbose_append("write_sdf {run_dir}/{top}.par.sdf".format(run_dir=self.run_dir, top=self.top_module))

        return True

    @property
    def output_innovus_lib_name(self) -> str:
        return "{top}_FINAL".format(top=self.top_module)

    @property
    def generated_scripts_dir(self) -> str:
        return os.path.join(self.run_dir, "generated-scripts")

    @property
    def open_chip_script(self) -> str:
        return os.path.join(self.generated_scripts_dir, "open_chip")

    @property
    def open_chip_tcl(self) -> str:
        return self.open_chip_script + ".tcl"

    def write_regs(self) -> bool:
        """write regs info to be read in for simulation register forcing"""
        self.append('''
        set write_regs_ir "./find_regs.json"
        set write_regs_ir [open $write_regs_ir "w"]
        puts $write_regs_ir "\{"
        puts $write_regs_ir {   "seq_cells" : [}

        set refs [get_db [get_db lib_cells -if .is_flop==true] .base_name]

        set len [llength $refs]

        for {set i 0} {$i < [llength $refs]} {incr i} {
            if {$i == $len - 1} {
                puts $write_regs_ir "    \\"[lindex $refs $i]\\""
            } else {
                puts $write_regs_ir "    \\"[lindex $refs $i]\\","
            }
        }

        puts $write_regs_ir "  \],"
        puts $write_regs_ir {   "reg_paths" : [}

        set regs [get_db [all_registers -edge_triggered -output_pins] .name]

        set len [llength $regs]

        for {set i 0} {$i < [llength $regs]} {incr i} {
            #regsub -all {/} [lindex $regs $i] . myreg
            set myreg [lindex $regs $i]
            if {$i == $len - 1} {
                puts $write_regs_ir "    \\"$myreg\\""
            } else {
                puts $write_regs_ir "    \\"$myreg\\","
            }
        }

        puts $write_regs_ir "  \]"

        puts $write_regs_ir "\}"
        close $write_regs_ir
        ''')

        return True

    def write_design(self) -> bool:
        # Save the Innovus design.
        self.verbose_append("write_db {lib_name} -def -verilog".format(
            lib_name=self.output_innovus_lib_name
        ))

        # Write netlist
        self.write_netlist()

        # GDS streamout.
        self.write_gds()

        # Write SDF
        self.write_sdf()

        # Make sure that generated-scripts exists.
        os.makedirs(self.generated_scripts_dir, exist_ok=True)

        return True

    @property
    def ran_write_ilm(self) -> bool:
        """The write_ilm stage sets this to True if it was run."""
        return self.attr_getter("_ran_write_ilm", False)

    @ran_write_ilm.setter
    def ran_write_ilm(self, val: bool) -> None:
        self.attr_setter("_ran_write_ilm", val)

    @property
    def ilm_dir_name(self) -> str:
        return os.path.join(self.run_dir, "{top}ILMDir".format(top=self.top_module))

    def write_ilm(self) -> bool:
        """Run time_design and write out the ILM."""
        self.verbose_append("time_design -post_route")
        self.verbose_append("time_design -post_route -hold")
        self.verbose_append("check_process_antenna")
        self.verbose_append("write_lef_abstract -5.8 {top}ILM.lef".format(top=self.top_module))
        self.verbose_append("write_ilm -model_type all -to_dir {ilm_dir_name} -type_flex_ilm ilm".format(
            ilm_dir_name=self.ilm_dir_name))
        self.ran_write_ilm = True
        return True

    def run_innovus(self) -> bool:
        # Quit Innovus.
        self.verbose_append("exit")

        # Create par script.
        par_tcl_filename = os.path.join(self.run_dir, "par.tcl")
        with open(par_tcl_filename, "w") as f:
            f.write("\n".join(self.output))

        # Build args.
        args = [
            self.get_setting("par.innovus.innovus_bin"),
            "-nowin",  # Prevent the GUI popping up.
            "-common_ui",
            "-files", par_tcl_filename
        ]

        # Temporarily disable colours/tag to make run output more readable.
        # TODO: think of a more elegant way to do this?
        HammerVLSILogging.enable_colour = False
        HammerVLSILogging.enable_tag = False
        self.run_executable(args, cwd=self.run_dir)  # TODO: check for errors and deal with them
        HammerVLSILogging.enable_colour = True
        HammerVLSILogging.enable_tag = True

        # TODO: check that par run was successful

        return True

    def create_floorplan_tcl(self) -> List[str]:
        """
        Create a floorplan TCL depending on the floorplan mode.
        """
        output = []  # type: List[str]

        floorplan_mode = str(self.get_setting("par.innovus.floorplan_mode"))
        if floorplan_mode == "manual":
            floorplan_script_contents = str(self.get_setting("par.innovus.floorplan_script_contents"))
            # TODO(edwardw): proper source locators/SourceInfo
            output.append("# Floorplan manually specified from HAMMER")
            output.extend(floorplan_script_contents.split("\n"))
        elif floorplan_mode == "generate":
            output.extend(self.generate_floorplan_tcl())
        elif floorplan_mode == "auto":
            output.append("# Using auto-generated floorplan")
            output.append("plan_design")
        else:
            if floorplan_mode != "blank":
                self.logger.error("Invalid floorplan_mode {mode}. Using blank floorplan.".format(mode=floorplan_mode))
            # Write blank floorplan
            output.append("# Blank floorplan specified from HAMMER")
        return output

    @staticmethod
    def generate_chip_size_constraint(width: Decimal, height: Decimal, left: Decimal, bottom: Decimal, right: Decimal,
                                      top: Decimal, site: str) -> str:
        """
        Given chip width/height and margins, generate an Innovus TCL command to create the floorplan.
        Also requires a technology specific name for the core site
        """

        site_str = "-site " + site

        # -flip -f allows standard cells to be flipped correctly during place-and-route
        return ("create_floorplan -core_margins_by die -flip f "
                "-die_size_by_io_height max {site_str} "
                "-die_size {{ {width} {height} {left} {bottom} {right} {top} }}").format(
            site_str=site_str,
            width=width,
            height=height,
            left=left,
            bottom=bottom,
            right=right,
            top=top
        )

    def generate_floorplan_tcl(self) -> List[str]:
        """
        Generate a TCL floorplan for Innovus based on the input config/IR.
        Not to be confused with create_floorplan_tcl, which calls this function.
        """
        output = []  # type: List[str]

        # TODO(edwardw): proper source locators/SourceInfo
        output.append("# Floorplan automatically generated from HAMMER")

        # Top-level chip size constraint.
        # Default/fallback constraints if no other constraints are provided.
        # TODO snap this to a core site
        chip_size_constraint = self.generate_chip_size_constraint(
            site=self.technology.get_placement_site().name,
            width=Decimal("1000"), height=Decimal("1000"),
            left=Decimal("100"), bottom=Decimal("100"),
            right=Decimal("100"), top=Decimal("100")
        )

        floorplan_constraints = self.get_placement_constraints()

        ############## Actually generate the constraints ################
        for constraint in floorplan_constraints:
            # Floorplan names/insts need to not include the top-level module,
            # despite the internal get_db commands including the top-level module...
            # e.g. Top/foo/bar -> foo/bar
            new_path = "/".join(constraint.path.split("/")[1:])

            if new_path == "":
                assert constraint.type == PlacementConstraintType.TopLevel, "Top must be a top-level/chip size constraint"
                margins = constraint.margins
                assert margins is not None
                # Set top-level chip dimensions.
                chip_size_constraint = self.generate_chip_size_constraint(
                    site=self.technology.get_placement_site().name,
                    width=constraint.width,
                    height=constraint.height,
                    left=margins.left,
                    bottom=margins.bottom,
                    right=margins.right,
                    top=margins.top
                )
            else:
                orientation = constraint.orientation if constraint.orientation is not None else "r0"
                if constraint.create_physical:
                    output.append("create_inst -cell {cell} -inst {inst} -location {{{x} {y}}} -orient {orientation} -physical -status fixed".format(
                        cell=constraint.master,
                        inst=new_path,
                        x=constraint.x,
                        y=constraint.y,
                        orientation=orientation
                    ))
                if constraint.type == PlacementConstraintType.Dummy:
                    pass
                elif constraint.type == PlacementConstraintType.Placement:
                    output.append("create_guide -name {name} -area {x1} {y1} {x2} {y2}".format(
                        name=new_path,
                        x1=constraint.x,
                        x2=constraint.x + constraint.width,
                        y1=constraint.y,
                        y2=constraint.y + constraint.height
                    ))
                elif constraint.type in [PlacementConstraintType.HardMacro, PlacementConstraintType.Hierarchical]:
                    output.append("place_inst {inst} {x} {y} {orientation}{fixed}".format(
                        inst=new_path,
                        x=constraint.x,
                        y=constraint.y,
                        orientation=orientation,
                        fixed=" -fixed" if constraint.create_physical else ""
                    ))
                    spacing = self.get_setting("par.blockage_spacing")
                    if constraint.top_layer is not None:
                        bot_layer = self.get_stackup().get_metal_by_index(1).name
                        output.append("create_place_halo -insts {inst} -halo_deltas {{{s} {s} {s} {s}}} -snap_to_site".format(
                            inst=new_path, s=spacing))
                        output.append("create_route_halo -bottom_layer {b} -space {s} -top_layer {t} -inst {inst}".format(
                            inst=new_path, b=bot_layer, t=constraint.top_layer, s=spacing))
                elif constraint.type == PlacementConstraintType.Obstruction:
                    obs_types = get_or_else(constraint.obs_types, [])  # type: List[ObstructionType]
                    if ObstructionType.Place in obs_types:
                        output.append("create_place_blockage -area {{{x} {y} {urx} {ury}}}".format(
                            x=constraint.x,
                            y=constraint.y,
                            urx=constraint.x+constraint.width,
                            ury=constraint.y+constraint.height
                        ))
                    if ObstructionType.Route in obs_types:
                        output.append("create_route_blockage -layers {{{layers}}} -spacing 0 -{area_flag} {{{x} {y} {urx} {ury}}}".format(
                            x=constraint.x,
                            y=constraint.y,
                            urx=constraint.x+constraint.width,
                            ury=constraint.y+constraint.height,
                            area_flag="rects" if self.version() >= self.version_number("181") else "area",
                            layers="all" if constraint.layers is None else " ".join(get_or_else(constraint.layers, []))
                        ))
                    if ObstructionType.Power in obs_types:
                        output.append("create_route_blockage -pg_nets -layers {{{layers}}} -{area_flag} {{{x} {y} {urx} {ury}}}".format(
                            x=constraint.x,
                            y=constraint.y,
                            urx=constraint.x+constraint.width,
                            ury=constraint.y+constraint.height,
                            area_flag="rects" if self.version() >= self.version_number("181") else "area",
                            layers="all" if constraint.layers is None else " ".join(get_or_else(constraint.layers, []))
                        ))
                else:
                    assert False, "Should not reach here"
        return [chip_size_constraint] + output

    def specify_std_cell_power_straps(self, blockage_spacing: Decimal, bbox: Optional[List[Decimal]], nets: List[str]) -> List[str]:
        """
        Generate a list of TCL commands that build the low-level standard cell power strap rails.
        This will use the -master option to create power straps based on technology.core.tap_cell_rail_reference.
        The layer is set by technology.core.std_cell_rail_layer, which should be the highest metal layer in the std cell rails.

        :param bbox: The optional (2N)-point bounding box of the area to generate straps. By default the entire core area is used.
        :param nets: A list of power net names (e.g. ["VDD", "VSS"]). Currently only two are supported.
        :return: A list of TCL commands that will generate power straps on rails.
        """
        layer_name = self.get_setting("technology.core.std_cell_rail_layer")
        layer = self.get_stackup().get_metal(layer_name)
        results = [
            "# Power strap definition for layer {} (rails):\n".format(layer_name),
            "reset_db -category add_stripes",
            "set_db add_stripes_stacked_via_bottom_layer {}".format(layer_name),
            "set_db add_stripes_stacked_via_top_layer {}".format(layer_name),
            "set_db add_stripes_spacing_from_block {}".format(blockage_spacing)
        ]
        tapcell = self.get_setting("technology.core.tap_cell_rail_reference")
        options = [
            "-pin_layer", layer_name,
            "-layer", layer_name,
            "-over_pins", "1",
            "-master", "\"{}\"".format(tapcell),
            "-block_ring_bottom_layer_limit", layer_name,
            "-block_ring_top_layer_limit", layer_name,
            "-pad_core_ring_bottom_layer_limit", layer_name,
            "-pad_core_ring_top_layer_limit", layer_name,
            "-direction", str(layer.direction),
            "-width", "pin_width",
            "-nets", "{ %s }" % " ".join(nets)
        ]
        if bbox is not None:
            options.extend([
                "-area", "{ %s }" % " ".join(map(str, bbox))
            ])
        results.append("add_stripes " + " ".join(options) + "\n")
        return results

    def specify_power_straps(self, layer_name: str, bottom_via_layer_name: str, blockage_spacing: Decimal, pitch: Decimal, width: Decimal, spacing: Decimal, offset: Decimal, bbox: Optional[List[Decimal]], nets: List[str], add_pins: bool) -> List[str]:
        """
        Generate a list of TCL commands that will create power straps on a given layer.
        This is a low-level, cad-tool-specific API. It is designed to be called by higher-level methods, so calling this directly is not recommended.
        This method assumes that power straps are built bottom-up, starting with standard cell rails.

        :param layer_name: The layer name of the metal on which to create straps.
        :param bottom_via_layer_name: The layer name of the lowest metal layer down to which to drop vias.
        :param blockage_spacing: The minimum spacing between the end of a strap and the beginning of a macro or blockage.
        :param pitch: The pitch between groups of power straps (i.e. from left edge of strap A to the next left edge of strap A).
        :param width: The width of each strap in a group.
        :param spacing: The spacing between straps in a group.
        :param offset: The offset to start the first group.
        :param bbox: The optional (2N)-point bounding box of the area to generate straps. By default the entire core area is used.
        :param nets: A list of power nets to create (e.g. ["VDD", "VSS"], ["VDDA", "VSS", "VDDB"],  ... etc.).
        :param add_pins: True if pins are desired on this layer; False otherwise.
        :return: A list of TCL commands that will generate power straps.
        """
        # TODO check that this has been not been called after a higher-level metal and error if so
        # TODO warn if the straps are off-pitch
        results = ["# Power strap definition for layer %s:\n" % layer_name]
        results.extend([
            "reset_db -category add_stripes",
            "set_db add_stripes_stacked_via_top_layer {}".format(layer_name),
            "set_db add_stripes_stacked_via_bottom_layer {}".format(bottom_via_layer_name),
            "set_db add_stripes_trim_antenna_back_to_shape {stripe}",
            "set_db add_stripes_spacing_from_block {}".format(blockage_spacing)
        ])
        layer = self.get_stackup().get_metal(layer_name)
        options = [
            "-create_pins", ("1" if (add_pins) else "0"),
            "-block_ring_bottom_layer_limit", layer_name,
            "-block_ring_top_layer_limit", bottom_via_layer_name,
            "-direction", str(layer.direction),
            "-layer", layer_name,
            "-nets", "{%s}" % " ".join(nets),
            "-pad_core_ring_bottom_layer_limit", bottom_via_layer_name,
            "-set_to_set_distance", str(pitch),
            "-spacing", str(spacing),
            "-switch_layer_over_obs", "0",
            "-width", str(width)
        ]
        # Where to get the io-to-core offset from a bbox
        index = 0
        if layer.direction == RoutingDirection.Horizontal:
            index = 1
        elif layer.direction != RoutingDirection.Vertical:
            raise ValueError("Cannot handle routing direction {d} for layer {l} when creating power straps".format(d=str(layer.direction), l=layer_name))

        if bbox is not None:
            options.extend([
                "-area", "{ %s }" % " ".join(map(str, bbox)),
                "-start", str(offset + bbox[index])
            ])

        else:
            # Just put straps in the core area
            options.extend([
                "-area", "[get_db designs .core_bbox]",
                "-start", "[expr [lindex [lindex [get_db designs .core_bbox] 0] {index}] + {offset}]".format(index=index, offset=offset)
            ])
        results.append("add_stripes " + " ".join(options) + "\n")
        return results

def innovus_global_settings(ht: HammerTool) -> bool:
    """Settings that need to be reapplied at every tool invocation"""
    ht.create_enter_script()

    # Python sucks here for verbosity
    verbose_append = ht.verbose_append

    # Generic settings
    verbose_append("set_db design_process_node {}".format(ht.get_setting("vlsi.core.node")))
    verbose_append("set_multi_cpu_usage -local_cpu {}".format(ht.get_setting("vlsi.core.max_threads")))

    return True

tool = Innovus
