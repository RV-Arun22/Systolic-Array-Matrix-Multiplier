##tcl script
read_libs /linuxeda_new/c2scadence/FOUNDRY/digital/90nm/dig/lib/typical.lib
read_hdl xlr.v
read_hdl counter.v
read_hdl synchr_fifo.v
read_hdl fifo_zero_injector.v
read_hdl SA.v
read_hdl PE.v
read_hdl SA_control.v

elaborate

read_sdc sys_array.sdc

#retime -min_area
set_db dft_scan_style muxed_scan
define_shift_enable -name test_enable -active high -create_port test_enable
check_dft_rules

syn_generic
syn_map
map_dft_unmapped_logic accelerator
syn_opt

#Enables DFT with clock gating
#set_db dft_compression_lp_gating_support true
check_dft_rules
define_scan_chain -name scan_chain -sdi scan_in -sdo scan_out -create_ports
connect_scan_chains -auto_create_chains

write_hdl > sys_Array_netlist_4ns_posedgeSA.v
write_sdc > output_constraints1_4ns_posedgeSA.sdc
write_sdf > output_constraints_4ns_posedgeSA.sdf
write_dft_atpg -library /linuxeda_new/c2scadence/FOUNDRY/digital/90nm/dig/vlog/typical.v

gui_show

report timing >> ./reports/SA_timing_4ns_posedgeSA.rpt
report power >> ./reports/SA_power_4ns_posedgeSA.rpt
report area >> ./reports/SA_area_4ns_posedgeSA.rpt
report gates >> ./reports/SA_gates_4ns_posedgeSA.rpt
report dft_chains >> ./reports/SA_dft_chains_4ns_posedgeSA.rpt
report dft_setup >> ./reports/SA_dft_setup_4ns_posedgeSA.rpt
report_scan_chains >> ./reports/SA_scan_chains_4ns_posedgeSA.rpt
