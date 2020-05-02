create_clock clk -name clk -period 1000.0
set_clock_uncertainty 10.0 [get_clocks clk]
create_clock cfg_clk -name cfg_clk -period 10000.0
set_clock_uncertainty 100.0 [get_clocks cfg_clk]

