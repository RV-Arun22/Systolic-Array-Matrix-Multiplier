create_clock -name "clk" -period 2.5 -waveform  {0.0 1.25} [get_ports clk]
set_clock_transition -rise 0.01 [get_clocks "clk"]
set_clock_transition -fall 0.01 [get_clocks "clk"]
set_clock_uncertainty 0.01 [get_ports "clk"]
set_input_delay  -max 0.01 -clock clk [all_inputs] 
set_output_delay  -max 0.01 -clock clk [all_outputs]

