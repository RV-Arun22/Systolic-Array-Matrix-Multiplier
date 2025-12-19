read_libs /linuxeda_new/c2scadence/FOUNDRY/digital/90nm/dig/lib/fast.lib
read_hdl design.v
elaborate
syn_generic
syn_map
syn_opt
write_hdl > ./output/design_netlist.v
write_sdc > ./output/outputconstraints1.sdc
gui_show
report timing -unconstrained >> ./reports/design_timing.rpt
report power >> ./reports/design_power.rpt
report area > ./reports/design_area.rpt
report gates > ./reports/design_gates.rpt
report clock_gating > ./reports/design_clock_gating.rpt
