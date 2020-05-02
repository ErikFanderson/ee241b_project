puts "set_db design_process_node 7" 
set_db design_process_node 7
puts "set_multi_cpu_usage -local_cpu 12" 
set_multi_cpu_usage -local_cpu 12
puts "set_db timing_analysis_cppr both" 
set_db timing_analysis_cppr both
puts "set_db timing_analysis_type ocv" 
set_db timing_analysis_type ocv
puts "set_library_unit -time 1ps" 
set_library_unit -time 1ps
puts "read_physical -lef { /scratch/cs199-ccz/ee241bS20/build/tech-asap7-cache/extracted/ASAP7_PDKandLIB.tar/ASAP7_PDKandLIB_v1p5/asap7libs_24.tar.bz2/asap7libs_24/techlef_misc/asap7_tech_4x_170803.lef /scratch/cs199-ccz/ee241bS20/build/tech-asap7-cache/extracted/ASAP7_PDKandLIB.tar/ASAP7_PDKandLIB_v1p5/asap7libs_24.tar.bz2/asap7libs_24/lef/scaled/asap7sc7p5t_24_R_4x_170912.lef /scratch/cs199-ccz/ee241bS20/build/tech-asap7-cache/extracted/ASAP7_PDKandLIB.tar/ASAP7_PDKandLIB_v1p5/asap7libs_24.tar.bz2/asap7libs_24/lef/scaled/asap7sc7p5t_24_L_4x_170912.lef /scratch/cs199-ccz/ee241bS20/build/tech-asap7-cache/extracted/ASAP7_PDKandLIB.tar/ASAP7_PDKandLIB_v1p5/asap7libs_24.tar.bz2/asap7libs_24/lef/scaled/asap7sc7p5t_24_SL_4x_170912.lef /scratch/cs199-ccz/ee241bS20/build/tech-asap7-cache/extracted/ASAP7_PDKandLIB.tar/ASAP7_PDKandLIB_v1p5/asap7libs_24.tar.bz2/asap7libs_24/lef/scaled/asap7sc7p5t_24_SRAM_4x_170912.lef /scratch/cs199-ccz/ee241bS20/hammer/src/hammer-vlsi/technology/asap7/sram_compiler/memories/lef/SRAM2RW16x32_x4.lef }" 
read_physical -lef { /scratch/cs199-ccz/ee241bS20/build/tech-asap7-cache/extracted/ASAP7_PDKandLIB.tar/ASAP7_PDKandLIB_v1p5/asap7libs_24.tar.bz2/asap7libs_24/techlef_misc/asap7_tech_4x_170803.lef /scratch/cs199-ccz/ee241bS20/build/tech-asap7-cache/extracted/ASAP7_PDKandLIB.tar/ASAP7_PDKandLIB_v1p5/asap7libs_24.tar.bz2/asap7libs_24/lef/scaled/asap7sc7p5t_24_R_4x_170912.lef /scratch/cs199-ccz/ee241bS20/build/tech-asap7-cache/extracted/ASAP7_PDKandLIB.tar/ASAP7_PDKandLIB_v1p5/asap7libs_24.tar.bz2/asap7libs_24/lef/scaled/asap7sc7p5t_24_L_4x_170912.lef /scratch/cs199-ccz/ee241bS20/build/tech-asap7-cache/extracted/ASAP7_PDKandLIB.tar/ASAP7_PDKandLIB_v1p5/asap7libs_24.tar.bz2/asap7libs_24/lef/scaled/asap7sc7p5t_24_SL_4x_170912.lef /scratch/cs199-ccz/ee241bS20/build/tech-asap7-cache/extracted/ASAP7_PDKandLIB.tar/ASAP7_PDKandLIB_v1p5/asap7libs_24.tar.bz2/asap7libs_24/lef/scaled/asap7sc7p5t_24_SRAM_4x_170912.lef /scratch/cs199-ccz/ee241bS20/hammer/src/hammer-vlsi/technology/asap7/sram_compiler/memories/lef/SRAM2RW16x32_x4.lef }
puts "read_mmmc /scratch/cs199-ccz/ee241bS20/build/par-rundir/mmmc.tcl" 
read_mmmc /scratch/cs199-ccz/ee241bS20/build/par-rundir/mmmc.tcl
puts "read_netlist { /scratch/cs199-ccz/ee241bS20/build/syn-rundir/clb_tile.mapped.v } -top clb_tile" 
read_netlist { /scratch/cs199-ccz/ee241bS20/build/syn-rundir/clb_tile.mapped.v } -top clb_tile
puts "init_design" 
init_design
puts "read_power_intent -cpf /scratch/cs199-ccz/ee241bS20/build/par-rundir/power_spec.cpf" 
read_power_intent -cpf /scratch/cs199-ccz/ee241bS20/build/par-rundir/power_spec.cpf
puts "commit_power_intent" 
commit_power_intent
puts "set_db design_flow_effort standard" 
set_db design_flow_effort standard

puts "set_dont_use \[get_db lib_cells */AO*\]"
if { [get_db lib_cells */AO*] ne "" } {
    set_dont_use [get_db lib_cells */AO*]
} else {
    puts "WARNING: cell */AO* was not found for set_dont_use"
}
            

puts "set_dont_use \[get_db lib_cells */OA*\]"
if { [get_db lib_cells */OA*] ne "" } {
    set_dont_use [get_db lib_cells */OA*]
} else {
    puts "WARNING: cell */OA* was not found for set_dont_use"
}
            

puts "set_dont_use \[get_db lib_cells */A2O1*\]"
if { [get_db lib_cells */A2O1*] ne "" } {
    set_dont_use [get_db lib_cells */A2O1*]
} else {
    puts "WARNING: cell */A2O1* was not found for set_dont_use"
}
            

set_db route_design_bottom_routing_layer 2
set_db route_design_top_routing_layer 7
    
puts "write_db pre_floorplan_design" 
write_db pre_floorplan_design
puts "ln -sfn pre_floorplan_design latest" 
ln -sfn pre_floorplan_design latest
puts "source -echo -verbose /scratch/cs199-ccz/ee241bS20/build/par-rundir/floorplan.tcl" 
source -echo -verbose /scratch/cs199-ccz/ee241bS20/build/par-rundir/floorplan.tcl
puts "write_db pre_place_bumps" 
write_db pre_place_bumps
puts "ln -sfn pre_place_bumps latest" 
ln -sfn pre_place_bumps latest
puts "write_db pre_place_tap_cells" 
write_db pre_place_tap_cells
puts "ln -sfn pre_place_tap_cells latest" 
ln -sfn pre_place_tap_cells latest
set_db add_well_taps_cell TAPCELL_ASAP7_75t_L
add_well_taps -cell_interval 50 -in_row_offset 10.564
puts "write_db pre_power_straps" 
write_db pre_power_straps
puts "ln -sfn pre_power_straps latest" 
ln -sfn pre_power_straps latest
puts "source -echo -verbose /scratch/cs199-ccz/ee241bS20/build/par-rundir/power_straps.tcl" 
source -echo -verbose /scratch/cs199-ccz/ee241bS20/build/par-rundir/power_straps.tcl
puts "write_db pre_place_pins" 
write_db pre_place_pins
puts "ln -sfn pre_place_pins latest" 
ln -sfn pre_place_pins latest
puts "set_db assign_pins_edit_in_batch true" 
set_db assign_pins_edit_in_batch true
puts "edit_pin -fixed_pin -pin clk -hinst clb_tile -pattern fill_optimised -layer { M5 M7 } -side bottom -start { 200 0 } -end { 0 0 }   " 
edit_pin -fixed_pin -pin clk -hinst clb_tile -pattern fill_optimised -layer { M5 M7 } -side bottom -start { 200 0 } -end { 0 0 }   
puts "edit_pin -fixed_pin -pin arc_L1_x0y0s* -hinst clb_tile -pattern fill_optimised -layer { M5 M7 } -side bottom -start { 200 0 } -end { 0 0 }   " 
edit_pin -fixed_pin -pin arc_L1_x0y0s* -hinst clb_tile -pattern fill_optimised -layer { M5 M7 } -side bottom -start { 200 0 } -end { 0 0 }   
puts "edit_pin -fixed_pin -pin arr_L1_u1y0s* -hinst clb_tile -pattern fill_optimised -layer { M5 M7 } -side bottom -start { 200 0 } -end { 0 0 }   " 
edit_pin -fixed_pin -pin arr_L1_u1y0s* -hinst clb_tile -pattern fill_optimised -layer { M5 M7 } -side bottom -start { 200 0 } -end { 0 0 }   
puts "edit_pin -fixed_pin -pin arr_L1_x0y0w* -hinst clb_tile -pattern fill_optimised -layer { M4 M6 } -side left -end { 0 150 } -start { 0 0 }   " 
edit_pin -fixed_pin -pin arr_L1_x0y0w* -hinst clb_tile -pattern fill_optimised -layer { M4 M6 } -side left -end { 0 150 } -start { 0 0 }   
puts "edit_pin -fixed_pin -pin arr_L1_x0v1w* -hinst clb_tile -pattern fill_optimised -layer { M4 M6 } -side left -end { 0 150 } -start { 0 0 }   " 
edit_pin -fixed_pin -pin arr_L1_x0v1w* -hinst clb_tile -pattern fill_optimised -layer { M4 M6 } -side left -end { 0 150 } -start { 0 0 }   
puts "edit_pin -fixed_pin -pin arc_L1_x0v1w* -hinst clb_tile -pattern fill_optimised -layer { M4 M6 } -side left -end { 0 150 } -start { 0 0 }   " 
edit_pin -fixed_pin -pin arc_L1_x0v1w* -hinst clb_tile -pattern fill_optimised -layer { M4 M6 } -side left -end { 0 150 } -start { 0 0 }   
puts "edit_pin -fixed_pin -pin arr_L1_x0y0e* -hinst clb_tile -pattern fill_optimised -layer { M4 M6 } -side right -start { 200 150 } -end { 200 0 }   " 
edit_pin -fixed_pin -pin arr_L1_x0y0e* -hinst clb_tile -pattern fill_optimised -layer { M4 M6 } -side right -start { 200 150 } -end { 200 0 }   
puts "edit_pin -fixed_pin -pin arr_L1_x0v1e* -hinst clb_tile -pattern fill_optimised -layer { M4 M6 } -side right -start { 200 150 } -end { 200 0 }   " 
edit_pin -fixed_pin -pin arr_L1_x0v1e* -hinst clb_tile -pattern fill_optimised -layer { M4 M6 } -side right -start { 200 150 } -end { 200 0 }   
puts "edit_pin -fixed_pin -pin arc_L1_x0v1e* -hinst clb_tile -pattern fill_optimised -layer { M4 M6 } -side right -start { 200 150 } -end { 200 0 }   " 
edit_pin -fixed_pin -pin arc_L1_x0v1e* -hinst clb_tile -pattern fill_optimised -layer { M4 M6 } -side right -start { 200 150 } -end { 200 0 }   
puts "edit_pin -fixed_pin -pin arc_L1_x0y0n* -hinst clb_tile -pattern fill_optimised -layer { M5 M7 } -side top -end { 200 150 } -start { 0 150 }   " 
edit_pin -fixed_pin -pin arc_L1_x0y0n* -hinst clb_tile -pattern fill_optimised -layer { M5 M7 } -side top -end { 200 150 } -start { 0 150 }   
puts "edit_pin -fixed_pin -pin arr_L1_u1y0n* -hinst clb_tile -pattern fill_optimised -layer { M5 M7 } -side top -end { 200 150 } -start { 0 150 }   " 
edit_pin -fixed_pin -pin arr_L1_u1y0n* -hinst clb_tile -pattern fill_optimised -layer { M5 M7 } -side top -end { 200 150 } -start { 0 150 }   
puts "edit_pin -fixed_pin -pin cfg_clk -hinst clb_tile -pattern fill_optimised -layer { M5 M7 } -side top -end { 200 150 } -start { 0 150 }   " 
edit_pin -fixed_pin -pin cfg_clk -hinst clb_tile -pattern fill_optimised -layer { M5 M7 } -side top -end { 200 150 } -start { 0 150 }   
puts "edit_pin -fixed_pin -pin cfg_scan_en -hinst clb_tile -pattern fill_optimised -layer { M5 M7 } -side top -end { 200 150 } -start { 0 150 }   " 
edit_pin -fixed_pin -pin cfg_scan_en -hinst clb_tile -pattern fill_optimised -layer { M5 M7 } -side top -end { 200 150 } -start { 0 150 }   
puts "edit_pin -fixed_pin -pin cfg_lut_we -hinst clb_tile -pattern fill_optimised -layer { M5 M7 } -side top -end { 200 150 } -start { 0 150 }   " 
edit_pin -fixed_pin -pin cfg_lut_we -hinst clb_tile -pattern fill_optimised -layer { M5 M7 } -side top -end { 200 150 } -start { 0 150 }   
puts "edit_pin -fixed_pin -pin cfg_scan_in -hinst clb_tile -pattern fill_optimised -layer { M5 M7 } -side top -end { 200 150 } -start { 0 150 }   " 
edit_pin -fixed_pin -pin cfg_scan_in -hinst clb_tile -pattern fill_optimised -layer { M5 M7 } -side top -end { 200 150 } -start { 0 150 }   
puts "edit_pin -fixed_pin -pin cfg_scan_out -hinst clb_tile -pattern fill_optimised -layer { M5 M7 } -side top -end { 200 150 } -start { 0 150 }   " 
edit_pin -fixed_pin -pin cfg_scan_out -hinst clb_tile -pattern fill_optimised -layer { M5 M7 } -side top -end { 200 150 } -start { 0 150 }   
puts "set_db assign_pins_edit_in_batch false" 
set_db assign_pins_edit_in_batch false
puts "write_db pre_place_opt_design" 
write_db pre_place_opt_design
puts "ln -sfn pre_place_opt_design latest" 
ln -sfn pre_place_opt_design latest
puts "place_opt_design" 
place_opt_design
puts "write_db pre_clock_tree" 
write_db pre_clock_tree
puts "ln -sfn pre_clock_tree latest" 
ln -sfn pre_clock_tree latest
puts "write_db pre_add_fillers" 
write_db pre_add_fillers
puts "ln -sfn pre_add_fillers latest" 
ln -sfn pre_add_fillers latest
set_db add_fillers_cells "FILLER_ASAP7_75t_R FILLER_ASAP7_75t_L FILLER_ASAP7_75t_SL FILLER_ASAP7_75t_SRAM FILLERxp5_ASAP7_75t_R FILLERxp5_ASAP7_75t_L FILLERxp5_ASAP7_75t_SL FILLERxp5_ASAP7_75t_SRAM DECAPx1_ASAP7_75t_R DECAPx1_ASAP7_75t_L DECAPx1_ASAP7_75t_SL DECAPx1_ASAP7_75t_SRAM DECAPx2_ASAP7_75t_R DECAPx2_ASAP7_75t_L DECAPx2_ASAP7_75t_SL DECAPx2_ASAP7_75t_SRAM DECAPx4_ASAP7_75t_R DECAPx4_ASAP7_75t_L DECAPx4_ASAP7_75t_SL DECAPx4_ASAP7_75t_SRAM DECAPx6_ASAP7_75t_R DECAPx6_ASAP7_75t_L DECAPx6_ASAP7_75t_SL DECAPx6_ASAP7_75t_SRAM DECAPx10_ASAP7_75t_R DECAPx10_ASAP7_75t_L DECAPx10_ASAP7_75t_SL DECAPx10_ASAP7_75t_SRAM "
add_fillers
puts "write_db pre_route_design" 
write_db pre_route_design
puts "ln -sfn pre_route_design latest" 
ln -sfn pre_route_design latest
puts "route_design" 
route_design
puts "write_db pre_opt_design" 
write_db pre_opt_design
puts "ln -sfn pre_opt_design latest" 
ln -sfn pre_opt_design latest
puts "opt_design -post_route -setup -hold" 
opt_design -post_route -setup -hold
puts "write_db pre_write_regs" 
write_db pre_write_regs
puts "ln -sfn pre_write_regs latest" 
ln -sfn pre_write_regs latest

        set write_regs_ir "./find_regs.json"
        set write_regs_ir [open $write_regs_ir "w"]
        puts $write_regs_ir "\{"
        puts $write_regs_ir {   "seq_cells" : [}

        set refs [get_db [get_db lib_cells -if .is_flop==true] .base_name]

        set len [llength $refs]

        for {set i 0} {$i < [llength $refs]} {incr i} {
            if {$i == $len - 1} {
                puts $write_regs_ir "    \"[lindex $refs $i]\""
            } else {
                puts $write_regs_ir "    \"[lindex $refs $i]\","
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
                puts $write_regs_ir "    \"$myreg\""
            } else {
                puts $write_regs_ir "    \"$myreg\","
            }
        }

        puts $write_regs_ir "  \]"

        puts $write_regs_ir "\}"
        close $write_regs_ir
        
puts "write_db pre_write_design" 
write_db pre_write_design
puts "ln -sfn pre_write_design latest" 
ln -sfn pre_write_design latest
puts "write_db clb_tile_FINAL -def -verilog" 
write_db clb_tile_FINAL -def -verilog
puts "set_db write_stream_virtual_connection false" 
set_db write_stream_virtual_connection false
puts "write_netlist /scratch/cs199-ccz/ee241bS20/build/par-rundir/clb_tile.lvs.v -top_module_first -top_module clb_tile -exclude_leaf_cells -phys -flat -exclude_insts_of_cells { TAPCELL_ASAP7_75t_R TAPCELL_ASAP7_75t_L TAPCELL_ASAP7_75t_SL TAPCELL_ASAP7_75t_SRAM TAPCELL_WITH_FILLER_ASAP7_75t_R TAPCELL_WITH_FILLER_ASAP7_75t_L TAPCELL_WITH_FILLER_ASAP7_75t_SL TAPCELL_WITH_FILLER_ASAP7_75t_SRAM FILLER_ASAP7_75t_R FILLER_ASAP7_75t_L FILLER_ASAP7_75t_SL FILLER_ASAP7_75t_SRAM FILLERxp5_ASAP7_75t_R FILLERxp5_ASAP7_75t_L FILLERxp5_ASAP7_75t_SL FILLERxp5_ASAP7_75t_SRAM DECAPx1_ASAP7_75t_R DECAPx1_ASAP7_75t_L DECAPx1_ASAP7_75t_SL DECAPx1_ASAP7_75t_SRAM DECAPx2_ASAP7_75t_R DECAPx2_ASAP7_75t_L DECAPx2_ASAP7_75t_SL DECAPx2_ASAP7_75t_SRAM DECAPx4_ASAP7_75t_R DECAPx4_ASAP7_75t_L DECAPx4_ASAP7_75t_SL DECAPx4_ASAP7_75t_SRAM DECAPx6_ASAP7_75t_R DECAPx6_ASAP7_75t_L DECAPx6_ASAP7_75t_SL DECAPx6_ASAP7_75t_SRAM DECAPx10_ASAP7_75t_R DECAPx10_ASAP7_75t_L DECAPx10_ASAP7_75t_SL DECAPx10_ASAP7_75t_SRAM } " 
write_netlist /scratch/cs199-ccz/ee241bS20/build/par-rundir/clb_tile.lvs.v -top_module_first -top_module clb_tile -exclude_leaf_cells -phys -flat -exclude_insts_of_cells { TAPCELL_ASAP7_75t_R TAPCELL_ASAP7_75t_L TAPCELL_ASAP7_75t_SL TAPCELL_ASAP7_75t_SRAM TAPCELL_WITH_FILLER_ASAP7_75t_R TAPCELL_WITH_FILLER_ASAP7_75t_L TAPCELL_WITH_FILLER_ASAP7_75t_SL TAPCELL_WITH_FILLER_ASAP7_75t_SRAM FILLER_ASAP7_75t_R FILLER_ASAP7_75t_L FILLER_ASAP7_75t_SL FILLER_ASAP7_75t_SRAM FILLERxp5_ASAP7_75t_R FILLERxp5_ASAP7_75t_L FILLERxp5_ASAP7_75t_SL FILLERxp5_ASAP7_75t_SRAM DECAPx1_ASAP7_75t_R DECAPx1_ASAP7_75t_L DECAPx1_ASAP7_75t_SL DECAPx1_ASAP7_75t_SRAM DECAPx2_ASAP7_75t_R DECAPx2_ASAP7_75t_L DECAPx2_ASAP7_75t_SL DECAPx2_ASAP7_75t_SRAM DECAPx4_ASAP7_75t_R DECAPx4_ASAP7_75t_L DECAPx4_ASAP7_75t_SL DECAPx4_ASAP7_75t_SRAM DECAPx6_ASAP7_75t_R DECAPx6_ASAP7_75t_L DECAPx6_ASAP7_75t_SL DECAPx6_ASAP7_75t_SRAM DECAPx10_ASAP7_75t_R DECAPx10_ASAP7_75t_L DECAPx10_ASAP7_75t_SL DECAPx10_ASAP7_75t_SRAM } 
puts "write_netlist /scratch/cs199-ccz/ee241bS20/build/par-rundir/clb_tile.sim.v -top_module_first -top_module clb_tile -exclude_leaf_cells -exclude_insts_of_cells { TAPCELL_ASAP7_75t_R TAPCELL_ASAP7_75t_L TAPCELL_ASAP7_75t_SL TAPCELL_ASAP7_75t_SRAM TAPCELL_WITH_FILLER_ASAP7_75t_R TAPCELL_WITH_FILLER_ASAP7_75t_L TAPCELL_WITH_FILLER_ASAP7_75t_SL TAPCELL_WITH_FILLER_ASAP7_75t_SRAM FILLER_ASAP7_75t_R FILLER_ASAP7_75t_L FILLER_ASAP7_75t_SL FILLER_ASAP7_75t_SRAM FILLERxp5_ASAP7_75t_R FILLERxp5_ASAP7_75t_L FILLERxp5_ASAP7_75t_SL FILLERxp5_ASAP7_75t_SRAM DECAPx1_ASAP7_75t_R DECAPx1_ASAP7_75t_L DECAPx1_ASAP7_75t_SL DECAPx1_ASAP7_75t_SRAM DECAPx2_ASAP7_75t_R DECAPx2_ASAP7_75t_L DECAPx2_ASAP7_75t_SL DECAPx2_ASAP7_75t_SRAM DECAPx4_ASAP7_75t_R DECAPx4_ASAP7_75t_L DECAPx4_ASAP7_75t_SL DECAPx4_ASAP7_75t_SRAM DECAPx6_ASAP7_75t_R DECAPx6_ASAP7_75t_L DECAPx6_ASAP7_75t_SL DECAPx6_ASAP7_75t_SRAM DECAPx10_ASAP7_75t_R DECAPx10_ASAP7_75t_L DECAPx10_ASAP7_75t_SL DECAPx10_ASAP7_75t_SRAM } " 
write_netlist /scratch/cs199-ccz/ee241bS20/build/par-rundir/clb_tile.sim.v -top_module_first -top_module clb_tile -exclude_leaf_cells -exclude_insts_of_cells { TAPCELL_ASAP7_75t_R TAPCELL_ASAP7_75t_L TAPCELL_ASAP7_75t_SL TAPCELL_ASAP7_75t_SRAM TAPCELL_WITH_FILLER_ASAP7_75t_R TAPCELL_WITH_FILLER_ASAP7_75t_L TAPCELL_WITH_FILLER_ASAP7_75t_SL TAPCELL_WITH_FILLER_ASAP7_75t_SRAM FILLER_ASAP7_75t_R FILLER_ASAP7_75t_L FILLER_ASAP7_75t_SL FILLER_ASAP7_75t_SRAM FILLERxp5_ASAP7_75t_R FILLERxp5_ASAP7_75t_L FILLERxp5_ASAP7_75t_SL FILLERxp5_ASAP7_75t_SRAM DECAPx1_ASAP7_75t_R DECAPx1_ASAP7_75t_L DECAPx1_ASAP7_75t_SL DECAPx1_ASAP7_75t_SRAM DECAPx2_ASAP7_75t_R DECAPx2_ASAP7_75t_L DECAPx2_ASAP7_75t_SL DECAPx2_ASAP7_75t_SRAM DECAPx4_ASAP7_75t_R DECAPx4_ASAP7_75t_L DECAPx4_ASAP7_75t_SL DECAPx4_ASAP7_75t_SRAM DECAPx6_ASAP7_75t_R DECAPx6_ASAP7_75t_L DECAPx6_ASAP7_75t_SL DECAPx6_ASAP7_75t_SRAM DECAPx10_ASAP7_75t_R DECAPx10_ASAP7_75t_L DECAPx10_ASAP7_75t_SL DECAPx10_ASAP7_75t_SRAM } 
puts "write_stream -mode ALL -map_file /scratch/cs199-ccz/ee241bS20/build/tech-asap7-cache/extracted/ASAP7_PDKandLIB.tar/ASAP7_PDKandLIB_v1p5/asap7PDK_r1p5.tar.bz2/asap7PDK_r1p5/cdslib/asap7_TechLib/asap7_fromAPR.layermap -uniquify_cell_names -merge { /scratch/cs199-ccz/ee241bS20/build/tech-asap7-cache/extracted/ASAP7_PDKandLIB.tar/ASAP7_PDKandLIB_v1p5/asap7libs_24.tar.bz2/asap7libs_24/gds/asap7sc7p5t_24_R.gds /scratch/cs199-ccz/ee241bS20/build/tech-asap7-cache/extracted/ASAP7_PDKandLIB.tar/ASAP7_PDKandLIB_v1p5/asap7libs_24.tar.bz2/asap7libs_24/gds/asap7sc7p5t_24_L.gds /scratch/cs199-ccz/ee241bS20/build/tech-asap7-cache/extracted/ASAP7_PDKandLIB.tar/ASAP7_PDKandLIB_v1p5/asap7libs_24.tar.bz2/asap7libs_24/gds/asap7sc7p5t_24_SL.gds /scratch/cs199-ccz/ee241bS20/build/tech-asap7-cache/extracted/ASAP7_PDKandLIB.tar/ASAP7_PDKandLIB_v1p5/asap7libs_24.tar.bz2/asap7libs_24/gds/asap7sc7p5t_24_SRAM.gds /scratch/cs199-ccz/ee241bS20/hammer/src/hammer-vlsi/technology/asap7/sram_compiler/memories/gds/SRAM2RW16x32_x4.gds } /scratch/cs199-ccz/ee241bS20/build/par-rundir/clb_tile.gds" 
write_stream -mode ALL -map_file /scratch/cs199-ccz/ee241bS20/build/tech-asap7-cache/extracted/ASAP7_PDKandLIB.tar/ASAP7_PDKandLIB_v1p5/asap7PDK_r1p5.tar.bz2/asap7PDK_r1p5/cdslib/asap7_TechLib/asap7_fromAPR.layermap -uniquify_cell_names -merge { /scratch/cs199-ccz/ee241bS20/build/tech-asap7-cache/extracted/ASAP7_PDKandLIB.tar/ASAP7_PDKandLIB_v1p5/asap7libs_24.tar.bz2/asap7libs_24/gds/asap7sc7p5t_24_R.gds /scratch/cs199-ccz/ee241bS20/build/tech-asap7-cache/extracted/ASAP7_PDKandLIB.tar/ASAP7_PDKandLIB_v1p5/asap7libs_24.tar.bz2/asap7libs_24/gds/asap7sc7p5t_24_L.gds /scratch/cs199-ccz/ee241bS20/build/tech-asap7-cache/extracted/ASAP7_PDKandLIB.tar/ASAP7_PDKandLIB_v1p5/asap7libs_24.tar.bz2/asap7libs_24/gds/asap7sc7p5t_24_SL.gds /scratch/cs199-ccz/ee241bS20/build/tech-asap7-cache/extracted/ASAP7_PDKandLIB.tar/ASAP7_PDKandLIB_v1p5/asap7libs_24.tar.bz2/asap7libs_24/gds/asap7sc7p5t_24_SRAM.gds /scratch/cs199-ccz/ee241bS20/hammer/src/hammer-vlsi/technology/asap7/sram_compiler/memories/gds/SRAM2RW16x32_x4.gds } /scratch/cs199-ccz/ee241bS20/build/par-rundir/clb_tile.gds
puts "write_sdf /scratch/cs199-ccz/ee241bS20/build/par-rundir/clb_tile.par.sdf" 
write_sdf /scratch/cs199-ccz/ee241bS20/build/par-rundir/clb_tile.par.sdf
puts "write_db pre_scale_final_gds" 
write_db pre_scale_final_gds
puts "ln -sfn pre_scale_final_gds latest" 
ln -sfn pre_scale_final_gds latest

# Write script out to a temporary file and execute it
set fp [open "/scratch/cs199-ccz/ee241bS20/build/par-rundir/gds_scale.py" "w"]
puts -nonewline $fp "#!/usr/bin/python3

# Scale the final GDS by a factor of 4
# This is a tech hook that should be inserted post write_design

import sys

try:
    import gdspy
    print('Scaling down place & routed GDS')
except ImportError:
    print('Check your gdspy installation!')
    sys.exit()

# load the standard cell list from the gds folder and lop off '_SL' from end
cell_list = \[line.strip()\[:-3\] for line in open('/scratch/cs199-ccz/ee241bS20/build/tech-asap7-cache/extracted/ASAP7_PDKandLIB.tar/ASAP7_PDKandLIB_v1p5/asap7libs_24.tar.bz2/asap7libs_24/gds/cell_list.txt', 'r')\]

# Need to remove blk layer from any macros, else LVS rule deck interprets it as a polygon
blockage_datatype = 4

# load original_gds
gds_lib = gdspy.GdsLibrary().read_gds(infile='/scratch/cs199-ccz/ee241bS20/build/par-rundir/clb_tile.gds', units='import')
# Iterate through cells that aren't part of standard cell library and scale
for k,v in gds_lib.cell_dict.items():
    if not any(cell in k for cell in cell_list):
        print('Scaling down ' + k)

        # Need to remove 'blk' layer from any macros, else LVS rule deck interprets it as a polygon
        # This has a layer datatype of 4
        # Then scale down the polygon
        v.polygons = \[poly.scale(0.25) for poly in v.polygons if not 4 in poly.datatypes\]

        # Scale paths
        for path in v.paths:
            path.scale(0.25)
            # gdspy bug: we also need to scale custom path extensions
            # Will be fixed by gdspy/pull#101 in next release
            for i, end in enumerate(path.ends):
                if isinstance(end, tuple):
                    path.ends\[i\] = tuple(\[e*0.25 for e in end\])

        # Scale and move labels
        for label in v.labels:
            # Bug fix for some EDA tools that didn't set MAG field in gds file
            # Maybe this is expected behavior in ASAP7 PDK
            # In gdspy/__init__.py: `kwargs\['magnification'\] = record\[1\]\[0\]`
            label.magnification = 0.25
            label.translate(-label.position\[0\]*0.75, -label.position\[1\]*0.75)

        # Scale and move references
        for ref in v.references:
            ref.magnification = 0.25
            ref.translate(-ref.origin\[0\]*0.75, -ref.origin\[1\]*0.75)
            ref.magnification = 1

# Overwrite original GDS file
gds_lib.write_gds('/scratch/cs199-ccz/ee241bS20/build/par-rundir/clb_tile.gds')
        "
close $fp

# Innovus <19.1 appends some bad LD_LIBRARY_PATHS, so remove them before executing python
set env(LD_LIBRARY_PATH) [join [lsearch -not -all -inline [split $env(LD_LIBRARY_PATH) ":"] "*INNOVUS*"] ":"]
python3 /scratch/cs199-ccz/ee241bS20/build/par-rundir/gds_scale.py

puts "write_db post_scale_final_gds" 
write_db post_scale_final_gds
puts "ln -sfn post_scale_final_gds latest" 
ln -sfn post_scale_final_gds latest
puts "exit" 
exit