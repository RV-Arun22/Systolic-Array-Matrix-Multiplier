Report link: https://docs.google.com/document/d/1rOAeHgji_GgqxMRRKXCHq6IKWShLU0k5_ss_2HrwvVs/edit?usp=sharing
[Report path](/Report.pdf)
 
TCL_files:
    - optmize_delay.tcl
    - optimize_area_slow.tcl
    - optimize_area_typical.tcl
    - optimize_area_fast.tcl 
    - optimize_power.tcl

constraint_files:
    - optimize_delay_constraints.sdc
    - optimize_area_constraint.sdc

verilog_files:
    - design.v


optimizing performance:
    - synthesis performed for slow.lib since we want to check timing for the worst case.
    - Reducing the time period in the SDC file till we get a negative slack.
    - The design with the best performance also has the highest gate count, area and power.

optimizing area:
    - Synthesis was performed for all three corners (slow, typical and fast)
    - used a very large time period in the SDC file (10 ns)
    - used "retime -min_area" command.
    - also performed clock gating as we observed that the area went down when clock gating was done.
    - clock gating command is "set_db lp_insert_clock_gating true"

optimizing power:
    - synthesis performed for fast.lib since we want to check power for the worst case.
    - removed the input constraints file from the TCL script.
    - enabled clock gating using "set_db lp_insert_clock_gating true"
