HAMMER_EXEC ?= /scratch/lpt/ee241bS20/hammer/src/hammer-shell/hammer-vlsi
HAMMER_DEPENDENCIES ?= /scratch/lpt/ee241bS20/fpga_nems.yml /scratch/lpt/ee241bS20/nems_libs.json /scratch/lpt/ee241bS20/inst-env.yml /scratch/lpt/ee241bS20/inst-env.yml /scratch/lpt/ee241bS20/lars_erik/rtl_nems/clb_tile/custom_defines.v /scratch/lpt/ee241bS20/lars_erik/rtl_nems/clb_tile/clb_tile.v /scratch/lpt/ee241bS20/lars_erik/rtl_nems/clb_tile/clb.v /scratch/lpt/ee241bS20/lars_erik/rtl_nems/clb_tile/fraclut6sffc.v /scratch/lpt/ee241bS20/lars_erik/rtl_nems/clb_tile/cbox_clb_x0y0e.v /scratch/lpt/ee241bS20/lars_erik/rtl_nems/clb_tile/cbox_clb_x0y0n.v /scratch/lpt/ee241bS20/lars_erik/rtl_nems/clb_tile/cbox_clb_x0y0s.v /scratch/lpt/ee241bS20/lars_erik/rtl_nems/clb_tile/cbox_clb_x0y0w.v /scratch/lpt/ee241bS20/lars_erik/rtl_nems/clb_tile/cfg_mux10.v /scratch/lpt/ee241bS20/lars_erik/rtl_nems/clb_tile/cfg_mux3.v /scratch/lpt/ee241bS20/lars_erik/rtl_nems/clb_tile/cfg_mux4.v


####################################################################################
## Global steps
####################################################################################
.PHONY: pcb
pcb: /scratch/lpt/ee241bS20/obj/pcb-rundir/pcb-output-full.json

/scratch/lpt/ee241bS20/obj/pcb-rundir/pcb-output-full.json: $(HAMMER_DEPENDENCIES)
	$(HAMMER_EXEC) -e /scratch/lpt/ee241bS20/inst-env.yml -e /scratch/lpt/ee241bS20/inst-env.yml -p /scratch/lpt/ee241bS20/fpga_nems.yml -p /scratch/lpt/ee241bS20/nems_libs.json --obj_dir /scratch/lpt/ee241bS20/obj pcb


####################################################################################
## Steps for clb_tile
####################################################################################
.PHONY: syn par drc lvs
syn: /scratch/lpt/ee241bS20/obj/syn-rundir/syn-output-full.json
par: /scratch/lpt/ee241bS20/obj/par-rundir/par-output-full.json
drc: /scratch/lpt/ee241bS20/obj/drc-rundir/drc-output-full.json
lvs: /scratch/lpt/ee241bS20/obj/lvs-rundir/lvs-output-full.json


/scratch/lpt/ee241bS20/obj/syn-rundir/syn-output-full.json: $(HAMMER_DEPENDENCIES)
	$(HAMMER_EXEC) -e /scratch/lpt/ee241bS20/inst-env.yml -e /scratch/lpt/ee241bS20/inst-env.yml -p /scratch/lpt/ee241bS20/fpga_nems.yml -p /scratch/lpt/ee241bS20/nems_libs.json --obj_dir /scratch/lpt/ee241bS20/obj syn

/scratch/lpt/ee241bS20/obj/par-input.json: /scratch/lpt/ee241bS20/obj/syn-rundir/syn-output-full.json
	$(HAMMER_EXEC) -e /scratch/lpt/ee241bS20/inst-env.yml -e /scratch/lpt/ee241bS20/inst-env.yml -p /scratch/lpt/ee241bS20/obj/syn-rundir/syn-output-full.json -o /scratch/lpt/ee241bS20/obj/par-input.json --obj_dir /scratch/lpt/ee241bS20/obj syn-to-par

/scratch/lpt/ee241bS20/obj/par-rundir/par-output-full.json: /scratch/lpt/ee241bS20/obj/par-input.json
	$(HAMMER_EXEC) -e /scratch/lpt/ee241bS20/inst-env.yml -e /scratch/lpt/ee241bS20/inst-env.yml -p /scratch/lpt/ee241bS20/obj/par-input.json --obj_dir /scratch/lpt/ee241bS20/obj par

/scratch/lpt/ee241bS20/obj/drc-input.json: /scratch/lpt/ee241bS20/obj/par-rundir/par-output-full.json
	$(HAMMER_EXEC) -e /scratch/lpt/ee241bS20/inst-env.yml -e /scratch/lpt/ee241bS20/inst-env.yml -p /scratch/lpt/ee241bS20/obj/par-rundir/par-output-full.json -o /scratch/lpt/ee241bS20/obj/drc-input.json --obj_dir /scratch/lpt/ee241bS20/obj par-to-drc

/scratch/lpt/ee241bS20/obj/drc-rundir/drc-output-full.json: /scratch/lpt/ee241bS20/obj/drc-input.json
	$(HAMMER_EXEC) -e /scratch/lpt/ee241bS20/inst-env.yml -e /scratch/lpt/ee241bS20/inst-env.yml -p /scratch/lpt/ee241bS20/obj/drc-input.json --obj_dir /scratch/lpt/ee241bS20/obj drc

/scratch/lpt/ee241bS20/obj/lvs-input.json: /scratch/lpt/ee241bS20/obj/par-rundir/par-output-full.json
	$(HAMMER_EXEC) -e /scratch/lpt/ee241bS20/inst-env.yml -e /scratch/lpt/ee241bS20/inst-env.yml -p /scratch/lpt/ee241bS20/obj/par-rundir/par-output-full.json -o /scratch/lpt/ee241bS20/obj/lvs-input.json --obj_dir /scratch/lpt/ee241bS20/obj par-to-lvs

/scratch/lpt/ee241bS20/obj/lvs-rundir/lvs-output-full.json: /scratch/lpt/ee241bS20/obj/lvs-input.json
	$(HAMMER_EXEC) -e /scratch/lpt/ee241bS20/inst-env.yml -e /scratch/lpt/ee241bS20/inst-env.yml -p /scratch/lpt/ee241bS20/obj/lvs-input.json --obj_dir /scratch/lpt/ee241bS20/obj lvs

# Redo steps
# These intentionally break the dependency graph, but allow the flexibility to rerun a step after changing a config.
# Hammer doesn't know what settings impact synthesis only, e.g., so these are for power-users who "know better."
# The HAMMER_REDO_ARGS variable allows patching in of new configurations with -p or using --to_step or --from_step, for example.
.PHONY: redo-syn redo-par redo-drc redo-lvs

redo-syn:
	$(HAMMER_EXEC) -e /scratch/lpt/ee241bS20/inst-env.yml -e /scratch/lpt/ee241bS20/inst-env.yml -p /scratch/lpt/ee241bS20/fpga_nems.yml -p /scratch/lpt/ee241bS20/nems_libs.json $(HAMMER_REDO_ARGS) --obj_dir /scratch/lpt/ee241bS20/obj syn

redo-par:
	$(HAMMER_EXEC) -e /scratch/lpt/ee241bS20/inst-env.yml -e /scratch/lpt/ee241bS20/inst-env.yml -p /scratch/lpt/ee241bS20/obj/par-input.json $(HAMMER_REDO_ARGS) --obj_dir /scratch/lpt/ee241bS20/obj par

redo-drc:
	$(HAMMER_EXEC) -e /scratch/lpt/ee241bS20/inst-env.yml -e /scratch/lpt/ee241bS20/inst-env.yml -p /scratch/lpt/ee241bS20/obj/drc-input.json $(HAMMER_REDO_ARGS) --obj_dir /scratch/lpt/ee241bS20/obj drc

redo-lvs:
	$(HAMMER_EXEC) -e /scratch/lpt/ee241bS20/inst-env.yml -e /scratch/lpt/ee241bS20/inst-env.yml -p /scratch/lpt/ee241bS20/obj/lvs-input.json $(HAMMER_REDO_ARGS) --obj_dir /scratch/lpt/ee241bS20/obj lvs

