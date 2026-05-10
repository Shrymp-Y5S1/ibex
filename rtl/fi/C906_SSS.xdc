
set_property PACKAGE_PIN AK17 [get_ports clk_in1_p]
set_property IOSTANDARD DIFF_HSTL_I_18 [get_ports clk_in1_p]
set_property PACKAGE_PIN Y22 [get_ports reset]
set_property IOSTANDARD LVCMOS18 [get_ports reset]
set_property PACKAGE_PIN AG32 [get_ports uart0_sin_rx]
set_property IOSTANDARD LVCMOS18 [get_ports uart0_sin_rx]
set_property PACKAGE_PIN AG31 [get_ports uart0_sout_tx]
set_property IOSTANDARD LVCMOS18 [get_ports uart0_sout_tx]

#ck_link port define
#set_property IOSTANDARD LVCMOS33 [get_ports gnd_1]
#set_property PACKAGE_PIN M24 [get_ports gnd_1]

#set_property IOSTANDARD LVCMOS33 [get_ports gnd_2]
#set_property PACKAGE_PIN H26 [get_ports gnd_2]

set_property IOSTANDARD LVCMOS33 [get_ports nrst_b]
set_property PACKAGE_PIN N24 [get_ports nrst_b]

set_property IOSTANDARD LVCMOS33 [get_ports verf]
set_property PACKAGE_PIN M26 [get_ports verf]

set_property IOSTANDARD LVCMOS33 [get_ports jclk]
set_property PACKAGE_PIN M25 [get_ports jclk]

set_property IOSTANDARD LVCMOS33 [get_ports jrst_b]
set_property PACKAGE_PIN H26 [get_ports jrst_b]

set_property IOSTANDARD LVCMOS33 [get_ports jtg_tdo]
set_property PACKAGE_PIN J26 [get_ports jtg_tdo]

set_property IOSTANDARD LVCMOS33 [get_ports jtg_tdi]
set_property PACKAGE_PIN J24 [get_ports jtg_tdi]

set_property IOSTANDARD LVCMOS33 [get_ports jtg_tms]
set_property PACKAGE_PIN J25 [get_ports jtg_tms]




set_property SLEW SLOW [get_ports jtg_tdo]
set_property SLEW SLOW [get_ports uart0_sout_tx]


set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets jclk]
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets jclk_IBUF_inst/O]

#5M
create_clock -period 200.000 -name jclk -waveform {0.000 100.000} [get_ports jclk]

#50M
create_clock -period 20.000 -name u_soc/x_apb/x_apb_bridge/apb_xx_pwrite_reg/Q -waveform {0.000 10.000} [get_pins u_soc/x_apb/x_apb_bridge/apb_xx_pwrite_reg/Q]
#25M
create_clock -period 40.000 -name u_soc/x_cpu_sub_system_axi/x_c906_wrapper/sys_apb_clk_reg/Q -waveform {0.000 20.000} [get_pins u_soc/x_cpu_sub_system_axi/x_c906_wrapper/sys_apb_clk_reg/Q]

#50M
create_clock -period 20.000 -name u2_soc/x_apb/x_apb_bridge/apb_xx_pwrite_reg/Q -waveform {0.000 10.000} [get_pins u2_soc/x_apb/x_apb_bridge/apb_xx_pwrite_reg/Q]
#25M
create_clock -period 40.000 -name u2_soc/x_cpu_sub_system_axi/x_c906_wrapper/sys_apb_clk_reg/Q -waveform {0.000 20.000} [get_pins u2_soc/x_cpu_sub_system_axi/x_c906_wrapper/sys_apb_clk_reg/Q]


set_false_path -from [get_clocks u_soc/x_apb/x_apb_bridge/apb_xx_pwrite_reg/Q] -to [get_clocks -of_objects [get_pins u_clk_wiz_0/inst/mmcme3_adv_inst/CLKOUT0]]

set_false_path -from [get_clocks u2_soc/x_apb/x_apb_bridge/apb_xx_pwrite_reg/Q] -to [get_clocks -of_objects [get_pins u_clk_wiz_0/inst/mmcme3_adv_inst/CLKOUT0]]

set_property PACKAGE_PIN N23 [get_ports led_compare]
set_property IOSTANDARD LVCMOS33 [get_ports led_compare]



set_property PACKAGE_PIN AF13 [get_ports {b_pad_gpio_porta[7]}]
set_property PACKAGE_PIN AF12 [get_ports {b_pad_gpio_porta[6]}]
set_property PACKAGE_PIN L23 [get_ports {b_pad_gpio_porta[5]}]
set_property PACKAGE_PIN L24 [get_ports {b_pad_gpio_porta[4]}]
set_property PACKAGE_PIN M27 [get_ports {b_pad_gpio_porta[3]}]
set_property PACKAGE_PIN L27 [get_ports {b_pad_gpio_porta[2]}]
set_property PACKAGE_PIN M21 [get_ports {b_pad_gpio_porta[1]}]
set_property PACKAGE_PIN N21 [get_ports {b_pad_gpio_porta[0]}]


set_property IOSTANDARD LVCMOS33 [get_ports {b_pad_gpio_porta[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {b_pad_gpio_porta[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {b_pad_gpio_porta[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {b_pad_gpio_porta[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {b_pad_gpio_porta[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {b_pad_gpio_porta[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {b_pad_gpio_porta[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {b_pad_gpio_porta[0]}]


set_property MARK_DEBUG true [get_nets {u_soc/x_cpu_sub_system_axi/x_c906_wrapper/x_cpu_top/x_aq_top_0/x_aq_core/x_aq_ifu_top/x_aq_ifu_pcgen/pcgen_icache_va[7]}]
set_property MARK_DEBUG true [get_nets {u_soc/x_cpu_sub_system_axi/x_c906_wrapper/x_cpu_top/x_aq_top_0/x_aq_core/x_aq_ifu_top/x_aq_ifu_pcgen/pcgen_icache_va[3]}]
set_property MARK_DEBUG true [get_nets {u_soc/x_cpu_sub_system_axi/x_c906_wrapper/x_cpu_top/x_aq_top_0/x_aq_core/x_aq_ifu_top/x_aq_ifu_pcgen/pcgen_icache_va[0]}]
set_property MARK_DEBUG true [get_nets {u_soc/x_cpu_sub_system_axi/x_c906_wrapper/x_cpu_top/x_aq_top_0/x_aq_core/x_aq_ifu_top/x_aq_ifu_pcgen/pcgen_icache_va[1]}]
set_property MARK_DEBUG true [get_nets {u_soc/x_cpu_sub_system_axi/x_c906_wrapper/x_cpu_top/x_aq_top_0/x_aq_core/x_aq_ifu_top/x_aq_ifu_pcgen/pcgen_icache_va[2]}]
set_property MARK_DEBUG true [get_nets {u_soc/x_cpu_sub_system_axi/x_c906_wrapper/x_cpu_top/x_aq_top_0/x_aq_core/x_aq_ifu_top/x_aq_ifu_pcgen/pcgen_icache_va[4]}]
set_property MARK_DEBUG true [get_nets {u_soc/x_cpu_sub_system_axi/x_c906_wrapper/x_cpu_top/x_aq_top_0/x_aq_core/x_aq_ifu_top/x_aq_ifu_pcgen/pcgen_icache_va[5]}]
set_property MARK_DEBUG true [get_nets {u_soc/x_cpu_sub_system_axi/x_c906_wrapper/x_cpu_top/x_aq_top_0/x_aq_core/x_aq_ifu_top/x_aq_ifu_pcgen/pcgen_icache_va[6]}]
set_property MARK_DEBUG true [get_nets {u_soc/x_cpu_sub_system_axi/x_c906_wrapper/x_cpu_top/x_aq_top_0/x_aq_core/x_aq_ifu_top/x_aq_ifu_pcgen/pcgen_icache_va[8]}]
set_property MARK_DEBUG true [get_nets {u_soc/x_cpu_sub_system_axi/x_c906_wrapper/x_cpu_top/x_aq_top_0/x_aq_core/x_aq_ifu_top/x_aq_ifu_pcgen/pcgen_icache_va[9]}]
set_property MARK_DEBUG true [get_nets {u_soc/x_cpu_sub_system_axi/x_c906_wrapper/x_cpu_top/x_aq_top_0/x_aq_core/x_aq_ifu_top/x_aq_ifu_pcgen/pcgen_icache_va[10]}]
set_property MARK_DEBUG true [get_nets {u_soc/x_cpu_sub_system_axi/x_c906_wrapper/x_cpu_top/x_aq_top_0/x_aq_core/x_aq_ifu_top/x_aq_ifu_pcgen/pcgen_icache_va[11]}]
set_property MARK_DEBUG true [get_nets {u_soc/x_cpu_sub_system_axi/x_c906_wrapper/x_cpu_top/x_aq_top_0/x_aq_core/x_aq_ifu_top/x_aq_ifu_pcgen/pcgen_icache_va[12]}]
set_property MARK_DEBUG true [get_nets {u_soc/x_cpu_sub_system_axi/x_c906_wrapper/x_cpu_top/x_aq_top_0/x_aq_core/x_aq_ifu_top/x_aq_ifu_pcgen/pcgen_icache_va[13]}]
set_property MARK_DEBUG true [get_nets {u_soc/x_cpu_sub_system_axi/x_c906_wrapper/x_cpu_top/x_aq_top_0/x_aq_core/x_aq_ifu_top/x_aq_ifu_pcgen/pcgen_icache_va[14]}]
set_property MARK_DEBUG true [get_nets {u_soc/x_cpu_sub_system_axi/x_c906_wrapper/x_cpu_top/x_aq_top_0/x_aq_core/x_aq_ifu_top/x_aq_ifu_pcgen/pcgen_icache_va[15]}]
set_property MARK_DEBUG true [get_nets {u_soc/x_cpu_sub_system_axi/x_c906_wrapper/x_cpu_top/x_aq_top_0/x_aq_core/x_aq_ifu_top/x_aq_ifu_pcgen/pcgen_icache_va[16]}]
set_property MARK_DEBUG true [get_nets {u_soc/x_cpu_sub_system_axi/x_c906_wrapper/x_cpu_top/x_aq_top_0/x_aq_core/x_aq_ifu_top/x_aq_ifu_pcgen/pcgen_icache_va[17]}]
set_property MARK_DEBUG true [get_nets {u_soc/x_cpu_sub_system_axi/x_c906_wrapper/x_cpu_top/x_aq_top_0/x_aq_core/x_aq_ifu_top/x_aq_ifu_pcgen/pcgen_icache_va[18]}]
set_property MARK_DEBUG true [get_nets {u_soc/x_cpu_sub_system_axi/x_c906_wrapper/x_cpu_top/x_aq_top_0/x_aq_core/x_aq_ifu_top/x_aq_ifu_pcgen/pcgen_icache_va[19]}]
set_property MARK_DEBUG true [get_nets {u_soc/x_cpu_sub_system_axi/x_c906_wrapper/x_cpu_top/x_aq_top_0/x_aq_core/x_aq_ifu_top/x_aq_ifu_pcgen/pcgen_icache_va[20]}]
set_property MARK_DEBUG true [get_nets {u_soc/x_cpu_sub_system_axi/x_c906_wrapper/x_cpu_top/x_aq_top_0/x_aq_core/x_aq_ifu_top/x_aq_ifu_pcgen/pcgen_icache_va[21]}]
set_property MARK_DEBUG true [get_nets {u_soc/x_cpu_sub_system_axi/x_c906_wrapper/x_cpu_top/x_aq_top_0/x_aq_core/x_aq_ifu_top/x_aq_ifu_pcgen/pcgen_icache_va[22]}]
set_property MARK_DEBUG true [get_nets {u_soc/x_cpu_sub_system_axi/x_c906_wrapper/x_cpu_top/x_aq_top_0/x_aq_core/x_aq_ifu_top/x_aq_ifu_pcgen/pcgen_icache_va[23]}]
set_property MARK_DEBUG true [get_nets {u2_soc/x_cpu_sub_system_axi/x_c906_wrapper/x_cpu_top/x_aq_top_0/x_aq_core/x_aq_ifu_top/x_aq_ifu_pcgen/pcgen_icache_va[2]}]
set_property MARK_DEBUG true [get_nets {u2_soc/x_cpu_sub_system_axi/x_c906_wrapper/x_cpu_top/x_aq_top_0/x_aq_core/x_aq_ifu_top/x_aq_ifu_pcgen/pcgen_icache_va[0]}]
set_property MARK_DEBUG true [get_nets {u2_soc/x_cpu_sub_system_axi/x_c906_wrapper/x_cpu_top/x_aq_top_0/x_aq_core/x_aq_ifu_top/x_aq_ifu_pcgen/pcgen_icache_va[1]}]
set_property MARK_DEBUG true [get_nets {u2_soc/x_cpu_sub_system_axi/x_c906_wrapper/x_cpu_top/x_aq_top_0/x_aq_core/x_aq_ifu_top/x_aq_ifu_pcgen/pcgen_icache_va[13]}]
set_property MARK_DEBUG true [get_nets {u2_soc/x_cpu_sub_system_axi/x_c906_wrapper/x_cpu_top/x_aq_top_0/x_aq_core/x_aq_ifu_top/x_aq_ifu_pcgen/pcgen_icache_va[14]}]
set_property MARK_DEBUG true [get_nets {u2_soc/x_cpu_sub_system_axi/x_c906_wrapper/x_cpu_top/x_aq_top_0/x_aq_core/x_aq_ifu_top/x_aq_ifu_pcgen/pcgen_icache_va[17]}]
set_property MARK_DEBUG true [get_nets {u2_soc/x_cpu_sub_system_axi/x_c906_wrapper/x_cpu_top/x_aq_top_0/x_aq_core/x_aq_ifu_top/x_aq_ifu_pcgen/pcgen_icache_va[3]}]
set_property MARK_DEBUG true [get_nets {u2_soc/x_cpu_sub_system_axi/x_c906_wrapper/x_cpu_top/x_aq_top_0/x_aq_core/x_aq_ifu_top/x_aq_ifu_pcgen/pcgen_icache_va[4]}]
set_property MARK_DEBUG true [get_nets {u2_soc/x_cpu_sub_system_axi/x_c906_wrapper/x_cpu_top/x_aq_top_0/x_aq_core/x_aq_ifu_top/x_aq_ifu_pcgen/pcgen_icache_va[22]}]
set_property MARK_DEBUG true [get_nets {u2_soc/x_cpu_sub_system_axi/x_c906_wrapper/x_cpu_top/x_aq_top_0/x_aq_core/x_aq_ifu_top/x_aq_ifu_pcgen/pcgen_icache_va[23]}]
set_property MARK_DEBUG true [get_nets {u2_soc/x_cpu_sub_system_axi/x_c906_wrapper/x_cpu_top/x_aq_top_0/x_aq_core/x_aq_ifu_top/x_aq_ifu_pcgen/pcgen_icache_va[5]}]
set_property MARK_DEBUG true [get_nets {u2_soc/x_cpu_sub_system_axi/x_c906_wrapper/x_cpu_top/x_aq_top_0/x_aq_core/x_aq_ifu_top/x_aq_ifu_pcgen/pcgen_icache_va[6]}]
set_property MARK_DEBUG true [get_nets {u2_soc/x_cpu_sub_system_axi/x_c906_wrapper/x_cpu_top/x_aq_top_0/x_aq_core/x_aq_ifu_top/x_aq_ifu_pcgen/pcgen_icache_va[7]}]
set_property MARK_DEBUG true [get_nets {u2_soc/x_cpu_sub_system_axi/x_c906_wrapper/x_cpu_top/x_aq_top_0/x_aq_core/x_aq_ifu_top/x_aq_ifu_pcgen/pcgen_icache_va[8]}]
set_property MARK_DEBUG true [get_nets {u2_soc/x_cpu_sub_system_axi/x_c906_wrapper/x_cpu_top/x_aq_top_0/x_aq_core/x_aq_ifu_top/x_aq_ifu_pcgen/pcgen_icache_va[11]}]
set_property MARK_DEBUG true [get_nets {u2_soc/x_cpu_sub_system_axi/x_c906_wrapper/x_cpu_top/x_aq_top_0/x_aq_core/x_aq_ifu_top/x_aq_ifu_pcgen/pcgen_icache_va[9]}]
set_property MARK_DEBUG true [get_nets {u2_soc/x_cpu_sub_system_axi/x_c906_wrapper/x_cpu_top/x_aq_top_0/x_aq_core/x_aq_ifu_top/x_aq_ifu_pcgen/pcgen_icache_va[15]}]
set_property MARK_DEBUG true [get_nets {u2_soc/x_cpu_sub_system_axi/x_c906_wrapper/x_cpu_top/x_aq_top_0/x_aq_core/x_aq_ifu_top/x_aq_ifu_pcgen/pcgen_icache_va[12]}]
set_property MARK_DEBUG true [get_nets {u2_soc/x_cpu_sub_system_axi/x_c906_wrapper/x_cpu_top/x_aq_top_0/x_aq_core/x_aq_ifu_top/x_aq_ifu_pcgen/pcgen_icache_va[18]}]
set_property MARK_DEBUG true [get_nets {u2_soc/x_cpu_sub_system_axi/x_c906_wrapper/x_cpu_top/x_aq_top_0/x_aq_core/x_aq_ifu_top/x_aq_ifu_pcgen/pcgen_icache_va[19]}]
set_property MARK_DEBUG true [get_nets {u2_soc/x_cpu_sub_system_axi/x_c906_wrapper/x_cpu_top/x_aq_top_0/x_aq_core/x_aq_ifu_top/x_aq_ifu_pcgen/pcgen_icache_va[21]}]
set_property MARK_DEBUG true [get_nets {u2_soc/x_cpu_sub_system_axi/x_c906_wrapper/x_cpu_top/x_aq_top_0/x_aq_core/x_aq_ifu_top/x_aq_ifu_pcgen/pcgen_icache_va[20]}]
set_property MARK_DEBUG true [get_nets {u2_soc/x_cpu_sub_system_axi/x_c906_wrapper/x_cpu_top/x_aq_top_0/x_aq_core/x_aq_ifu_top/x_aq_ifu_pcgen/pcgen_icache_va[16]}]
set_property MARK_DEBUG true [get_nets {u2_soc/x_cpu_sub_system_axi/x_c906_wrapper/x_cpu_top/x_aq_top_0/x_aq_core/x_aq_ifu_top/x_aq_ifu_pcgen/pcgen_icache_va[10]}]
set_false_path -from [get_pins u_soc/x_cpu_sub_system_axi/x_c906_wrapper/x_cpu_top/x_aq_mp_rst_top/ciu_rst_ff_3rd_reg/C] -to [get_pins {u_soc/x_cpu_sub_system_axi/x_c906_wrapper/x_cpu_top/x_aq_plic_top/x_plic_kid_busif/x_plic_int_sync/sync_ff_reg[0][26]/CLR}]
#set_false_path -from [get_pins u_soc/x_cpu_sub_system_axi/x_c906_wrapper/x_cpu_top/x_aq_mp_rst_top/ciu_rst_ff_3rd_reg/C] -to [get_pins {u_soc/x_cpu_sub_system_axi/x_c906_wrapper/x_cpu_top/x_aq_plic_top/x_plic_kid_busif/x_plic_int_sync/sync_ff_reg[0][26]/CLR}]


create_pblock compare
add_cells_to_pblock [get_pblocks compare] [get_cells -quiet [list c906_comparee]]
resize_pblock [get_pblocks compare] -add {SLICE_X91Y285:SLICE_X100Y299}
create_debug_core u_ila_0 ila
set_property ALL_PROBE_SAME_MU true [get_debug_cores u_ila_0]
set_property ALL_PROBE_SAME_MU_CNT 4 [get_debug_cores u_ila_0]
set_property C_ADV_TRIGGER true [get_debug_cores u_ila_0]
set_property C_DATA_DEPTH 1024 [get_debug_cores u_ila_0]
set_property C_EN_STRG_QUAL true [get_debug_cores u_ila_0]
set_property C_INPUT_PIPE_STAGES 0 [get_debug_cores u_ila_0]
set_property C_TRIGIN_EN false [get_debug_cores u_ila_0]
set_property C_TRIGOUT_EN false [get_debug_cores u_ila_0]
set_property port_width 1 [get_debug_ports u_ila_0/clk]
connect_debug_port u_ila_0/clk [get_nets [list clk_out1]]
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe0]
set_property port_width 64 [get_debug_ports u_ila_0/probe0]
connect_debug_port u_ila_0/probe0 [get_nets [list {u2_soc/x_cpu_sub_system_axi/x_c906_wrapper/x_cpu_top/x_aq_top_0/x_aq_core/x_aq_ifu_top/x_aq_ifu_pcgen/pcgen_icache_va[0]} {u2_soc/x_cpu_sub_system_axi/x_c906_wrapper/x_cpu_top/x_aq_top_0/x_aq_core/x_aq_ifu_top/x_aq_ifu_pcgen/pcgen_icache_va[1]} {u2_soc/x_cpu_sub_system_axi/x_c906_wrapper/x_cpu_top/x_aq_top_0/x_aq_core/x_aq_ifu_top/x_aq_ifu_pcgen/pcgen_icache_va[2]} {u2_soc/x_cpu_sub_system_axi/x_c906_wrapper/x_cpu_top/x_aq_top_0/x_aq_core/x_aq_ifu_top/x_aq_ifu_pcgen/pcgen_icache_va[3]} {u2_soc/x_cpu_sub_system_axi/x_c906_wrapper/x_cpu_top/x_aq_top_0/x_aq_core/x_aq_ifu_top/x_aq_ifu_pcgen/pcgen_icache_va[4]} {u2_soc/x_cpu_sub_system_axi/x_c906_wrapper/x_cpu_top/x_aq_top_0/x_aq_core/x_aq_ifu_top/x_aq_ifu_pcgen/pcgen_icache_va[5]} {u2_soc/x_cpu_sub_system_axi/x_c906_wrapper/x_cpu_top/x_aq_top_0/x_aq_core/x_aq_ifu_top/x_aq_ifu_pcgen/pcgen_icache_va[6]} {u2_soc/x_cpu_sub_system_axi/x_c906_wrapper/x_cpu_top/x_aq_top_0/x_aq_core/x_aq_ifu_top/x_aq_ifu_pcgen/pcgen_icache_va[7]} {u2_soc/x_cpu_sub_system_axi/x_c906_wrapper/x_cpu_top/x_aq_top_0/x_aq_core/x_aq_ifu_top/x_aq_ifu_pcgen/pcgen_icache_va[8]} {u2_soc/x_cpu_sub_system_axi/x_c906_wrapper/x_cpu_top/x_aq_top_0/x_aq_core/x_aq_ifu_top/x_aq_ifu_pcgen/pcgen_icache_va[9]} {u2_soc/x_cpu_sub_system_axi/x_c906_wrapper/x_cpu_top/x_aq_top_0/x_aq_core/x_aq_ifu_top/x_aq_ifu_pcgen/pcgen_icache_va[10]} {u2_soc/x_cpu_sub_system_axi/x_c906_wrapper/x_cpu_top/x_aq_top_0/x_aq_core/x_aq_ifu_top/x_aq_ifu_pcgen/pcgen_icache_va[11]} {u2_soc/x_cpu_sub_system_axi/x_c906_wrapper/x_cpu_top/x_aq_top_0/x_aq_core/x_aq_ifu_top/x_aq_ifu_pcgen/pcgen_icache_va[12]} {u2_soc/x_cpu_sub_system_axi/x_c906_wrapper/x_cpu_top/x_aq_top_0/x_aq_core/x_aq_ifu_top/x_aq_ifu_pcgen/pcgen_icache_va[13]} {u2_soc/x_cpu_sub_system_axi/x_c906_wrapper/x_cpu_top/x_aq_top_0/x_aq_core/x_aq_ifu_top/x_aq_ifu_pcgen/pcgen_icache_va[14]} {u2_soc/x_cpu_sub_system_axi/x_c906_wrapper/x_cpu_top/x_aq_top_0/x_aq_core/x_aq_ifu_top/x_aq_ifu_pcgen/pcgen_icache_va[15]} {u2_soc/x_cpu_sub_system_axi/x_c906_wrapper/x_cpu_top/x_aq_top_0/x_aq_core/x_aq_ifu_top/x_aq_ifu_pcgen/pcgen_icache_va[16]} {u2_soc/x_cpu_sub_system_axi/x_c906_wrapper/x_cpu_top/x_aq_top_0/x_aq_core/x_aq_ifu_top/x_aq_ifu_pcgen/pcgen_icache_va[17]} {u2_soc/x_cpu_sub_system_axi/x_c906_wrapper/x_cpu_top/x_aq_top_0/x_aq_core/x_aq_ifu_top/x_aq_ifu_pcgen/pcgen_icache_va[18]} {u2_soc/x_cpu_sub_system_axi/x_c906_wrapper/x_cpu_top/x_aq_top_0/x_aq_core/x_aq_ifu_top/x_aq_ifu_pcgen/pcgen_icache_va[19]} {u2_soc/x_cpu_sub_system_axi/x_c906_wrapper/x_cpu_top/x_aq_top_0/x_aq_core/x_aq_ifu_top/x_aq_ifu_pcgen/pcgen_icache_va[20]} {u2_soc/x_cpu_sub_system_axi/x_c906_wrapper/x_cpu_top/x_aq_top_0/x_aq_core/x_aq_ifu_top/x_aq_ifu_pcgen/pcgen_icache_va[21]} {u2_soc/x_cpu_sub_system_axi/x_c906_wrapper/x_cpu_top/x_aq_top_0/x_aq_core/x_aq_ifu_top/x_aq_ifu_pcgen/pcgen_icache_va[22]} {u2_soc/x_cpu_sub_system_axi/x_c906_wrapper/x_cpu_top/x_aq_top_0/x_aq_core/x_aq_ifu_top/x_aq_ifu_pcgen/pcgen_icache_va[23]} {u2_soc/x_cpu_sub_system_axi/x_c906_wrapper/x_cpu_top/x_aq_top_0/x_aq_core/x_aq_ifu_top/x_aq_ifu_pcgen/pcgen_icache_va[24]} {u2_soc/x_cpu_sub_system_axi/x_c906_wrapper/x_cpu_top/x_aq_top_0/x_aq_core/x_aq_ifu_top/x_aq_ifu_pcgen/pcgen_icache_va[25]} {u2_soc/x_cpu_sub_system_axi/x_c906_wrapper/x_cpu_top/x_aq_top_0/x_aq_core/x_aq_ifu_top/x_aq_ifu_pcgen/pcgen_icache_va[26]} {u2_soc/x_cpu_sub_system_axi/x_c906_wrapper/x_cpu_top/x_aq_top_0/x_aq_core/x_aq_ifu_top/x_aq_ifu_pcgen/pcgen_icache_va[27]} {u2_soc/x_cpu_sub_system_axi/x_c906_wrapper/x_cpu_top/x_aq_top_0/x_aq_core/x_aq_ifu_top/x_aq_ifu_pcgen/pcgen_icache_va[28]} {u2_soc/x_cpu_sub_system_axi/x_c906_wrapper/x_cpu_top/x_aq_top_0/x_aq_core/x_aq_ifu_top/x_aq_ifu_pcgen/pcgen_icache_va[29]} {u2_soc/x_cpu_sub_system_axi/x_c906_wrapper/x_cpu_top/x_aq_top_0/x_aq_core/x_aq_ifu_top/x_aq_ifu_pcgen/pcgen_icache_va[30]} {u2_soc/x_cpu_sub_system_axi/x_c906_wrapper/x_cpu_top/x_aq_top_0/x_aq_core/x_aq_ifu_top/x_aq_ifu_pcgen/pcgen_icache_va[31]} {u2_soc/x_cpu_sub_system_axi/x_c906_wrapper/x_cpu_top/x_aq_top_0/x_aq_core/x_aq_ifu_top/x_aq_ifu_pcgen/pcgen_icache_va[32]} {u2_soc/x_cpu_sub_system_axi/x_c906_wrapper/x_cpu_top/x_aq_top_0/x_aq_core/x_aq_ifu_top/x_aq_ifu_pcgen/pcgen_icache_va[33]} {u2_soc/x_cpu_sub_system_axi/x_c906_wrapper/x_cpu_top/x_aq_top_0/x_aq_core/x_aq_ifu_top/x_aq_ifu_pcgen/pcgen_icache_va[34]} {u2_soc/x_cpu_sub_system_axi/x_c906_wrapper/x_cpu_top/x_aq_top_0/x_aq_core/x_aq_ifu_top/x_aq_ifu_pcgen/pcgen_icache_va[35]} {u2_soc/x_cpu_sub_system_axi/x_c906_wrapper/x_cpu_top/x_aq_top_0/x_aq_core/x_aq_ifu_top/x_aq_ifu_pcgen/pcgen_icache_va[36]} {u2_soc/x_cpu_sub_system_axi/x_c906_wrapper/x_cpu_top/x_aq_top_0/x_aq_core/x_aq_ifu_top/x_aq_ifu_pcgen/pcgen_icache_va[37]} {u2_soc/x_cpu_sub_system_axi/x_c906_wrapper/x_cpu_top/x_aq_top_0/x_aq_core/x_aq_ifu_top/x_aq_ifu_pcgen/pcgen_icache_va[38]} {u2_soc/x_cpu_sub_system_axi/x_c906_wrapper/x_cpu_top/x_aq_top_0/x_aq_core/x_aq_ifu_top/x_aq_ifu_pcgen/pcgen_icache_va[39]} {u2_soc/x_cpu_sub_system_axi/x_c906_wrapper/x_cpu_top/x_aq_top_0/x_aq_core/x_aq_ifu_top/x_aq_ifu_pcgen/pcgen_icache_va[40]} {u2_soc/x_cpu_sub_system_axi/x_c906_wrapper/x_cpu_top/x_aq_top_0/x_aq_core/x_aq_ifu_top/x_aq_ifu_pcgen/pcgen_icache_va[41]} {u2_soc/x_cpu_sub_system_axi/x_c906_wrapper/x_cpu_top/x_aq_top_0/x_aq_core/x_aq_ifu_top/x_aq_ifu_pcgen/pcgen_icache_va[42]} {u2_soc/x_cpu_sub_system_axi/x_c906_wrapper/x_cpu_top/x_aq_top_0/x_aq_core/x_aq_ifu_top/x_aq_ifu_pcgen/pcgen_icache_va[43]} {u2_soc/x_cpu_sub_system_axi/x_c906_wrapper/x_cpu_top/x_aq_top_0/x_aq_core/x_aq_ifu_top/x_aq_ifu_pcgen/pcgen_icache_va[44]} {u2_soc/x_cpu_sub_system_axi/x_c906_wrapper/x_cpu_top/x_aq_top_0/x_aq_core/x_aq_ifu_top/x_aq_ifu_pcgen/pcgen_icache_va[45]} {u2_soc/x_cpu_sub_system_axi/x_c906_wrapper/x_cpu_top/x_aq_top_0/x_aq_core/x_aq_ifu_top/x_aq_ifu_pcgen/pcgen_icache_va[46]} {u2_soc/x_cpu_sub_system_axi/x_c906_wrapper/x_cpu_top/x_aq_top_0/x_aq_core/x_aq_ifu_top/x_aq_ifu_pcgen/pcgen_icache_va[47]} {u2_soc/x_cpu_sub_system_axi/x_c906_wrapper/x_cpu_top/x_aq_top_0/x_aq_core/x_aq_ifu_top/x_aq_ifu_pcgen/pcgen_icache_va[48]} {u2_soc/x_cpu_sub_system_axi/x_c906_wrapper/x_cpu_top/x_aq_top_0/x_aq_core/x_aq_ifu_top/x_aq_ifu_pcgen/pcgen_icache_va[49]} {u2_soc/x_cpu_sub_system_axi/x_c906_wrapper/x_cpu_top/x_aq_top_0/x_aq_core/x_aq_ifu_top/x_aq_ifu_pcgen/pcgen_icache_va[50]} {u2_soc/x_cpu_sub_system_axi/x_c906_wrapper/x_cpu_top/x_aq_top_0/x_aq_core/x_aq_ifu_top/x_aq_ifu_pcgen/pcgen_icache_va[51]} {u2_soc/x_cpu_sub_system_axi/x_c906_wrapper/x_cpu_top/x_aq_top_0/x_aq_core/x_aq_ifu_top/x_aq_ifu_pcgen/pcgen_icache_va[52]} {u2_soc/x_cpu_sub_system_axi/x_c906_wrapper/x_cpu_top/x_aq_top_0/x_aq_core/x_aq_ifu_top/x_aq_ifu_pcgen/pcgen_icache_va[53]} {u2_soc/x_cpu_sub_system_axi/x_c906_wrapper/x_cpu_top/x_aq_top_0/x_aq_core/x_aq_ifu_top/x_aq_ifu_pcgen/pcgen_icache_va[54]} {u2_soc/x_cpu_sub_system_axi/x_c906_wrapper/x_cpu_top/x_aq_top_0/x_aq_core/x_aq_ifu_top/x_aq_ifu_pcgen/pcgen_icache_va[55]} {u2_soc/x_cpu_sub_system_axi/x_c906_wrapper/x_cpu_top/x_aq_top_0/x_aq_core/x_aq_ifu_top/x_aq_ifu_pcgen/pcgen_icache_va[56]} {u2_soc/x_cpu_sub_system_axi/x_c906_wrapper/x_cpu_top/x_aq_top_0/x_aq_core/x_aq_ifu_top/x_aq_ifu_pcgen/pcgen_icache_va[57]} {u2_soc/x_cpu_sub_system_axi/x_c906_wrapper/x_cpu_top/x_aq_top_0/x_aq_core/x_aq_ifu_top/x_aq_ifu_pcgen/pcgen_icache_va[58]} {u2_soc/x_cpu_sub_system_axi/x_c906_wrapper/x_cpu_top/x_aq_top_0/x_aq_core/x_aq_ifu_top/x_aq_ifu_pcgen/pcgen_icache_va[59]} {u2_soc/x_cpu_sub_system_axi/x_c906_wrapper/x_cpu_top/x_aq_top_0/x_aq_core/x_aq_ifu_top/x_aq_ifu_pcgen/pcgen_icache_va[60]} {u2_soc/x_cpu_sub_system_axi/x_c906_wrapper/x_cpu_top/x_aq_top_0/x_aq_core/x_aq_ifu_top/x_aq_ifu_pcgen/pcgen_icache_va[61]} {u2_soc/x_cpu_sub_system_axi/x_c906_wrapper/x_cpu_top/x_aq_top_0/x_aq_core/x_aq_ifu_top/x_aq_ifu_pcgen/pcgen_icache_va[62]} {u2_soc/x_cpu_sub_system_axi/x_c906_wrapper/x_cpu_top/x_aq_top_0/x_aq_core/x_aq_ifu_top/x_aq_ifu_pcgen/pcgen_icache_va[63]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe1]
set_property port_width 64 [get_debug_ports u_ila_0/probe1]
connect_debug_port u_ila_0/probe1 [get_nets [list {u_soc/x_cpu_sub_system_axi/x_c906_wrapper/x_cpu_top/x_aq_top_0/x_aq_core/x_aq_ifu_top/x_aq_ifu_pcgen/pcgen_icache_va[0]} {u_soc/x_cpu_sub_system_axi/x_c906_wrapper/x_cpu_top/x_aq_top_0/x_aq_core/x_aq_ifu_top/x_aq_ifu_pcgen/pcgen_icache_va[1]} {u_soc/x_cpu_sub_system_axi/x_c906_wrapper/x_cpu_top/x_aq_top_0/x_aq_core/x_aq_ifu_top/x_aq_ifu_pcgen/pcgen_icache_va[2]} {u_soc/x_cpu_sub_system_axi/x_c906_wrapper/x_cpu_top/x_aq_top_0/x_aq_core/x_aq_ifu_top/x_aq_ifu_pcgen/pcgen_icache_va[3]} {u_soc/x_cpu_sub_system_axi/x_c906_wrapper/x_cpu_top/x_aq_top_0/x_aq_core/x_aq_ifu_top/x_aq_ifu_pcgen/pcgen_icache_va[4]} {u_soc/x_cpu_sub_system_axi/x_c906_wrapper/x_cpu_top/x_aq_top_0/x_aq_core/x_aq_ifu_top/x_aq_ifu_pcgen/pcgen_icache_va[5]} {u_soc/x_cpu_sub_system_axi/x_c906_wrapper/x_cpu_top/x_aq_top_0/x_aq_core/x_aq_ifu_top/x_aq_ifu_pcgen/pcgen_icache_va[6]} {u_soc/x_cpu_sub_system_axi/x_c906_wrapper/x_cpu_top/x_aq_top_0/x_aq_core/x_aq_ifu_top/x_aq_ifu_pcgen/pcgen_icache_va[7]} {u_soc/x_cpu_sub_system_axi/x_c906_wrapper/x_cpu_top/x_aq_top_0/x_aq_core/x_aq_ifu_top/x_aq_ifu_pcgen/pcgen_icache_va[8]} {u_soc/x_cpu_sub_system_axi/x_c906_wrapper/x_cpu_top/x_aq_top_0/x_aq_core/x_aq_ifu_top/x_aq_ifu_pcgen/pcgen_icache_va[9]} {u_soc/x_cpu_sub_system_axi/x_c906_wrapper/x_cpu_top/x_aq_top_0/x_aq_core/x_aq_ifu_top/x_aq_ifu_pcgen/pcgen_icache_va[10]} {u_soc/x_cpu_sub_system_axi/x_c906_wrapper/x_cpu_top/x_aq_top_0/x_aq_core/x_aq_ifu_top/x_aq_ifu_pcgen/pcgen_icache_va[11]} {u_soc/x_cpu_sub_system_axi/x_c906_wrapper/x_cpu_top/x_aq_top_0/x_aq_core/x_aq_ifu_top/x_aq_ifu_pcgen/pcgen_icache_va[12]} {u_soc/x_cpu_sub_system_axi/x_c906_wrapper/x_cpu_top/x_aq_top_0/x_aq_core/x_aq_ifu_top/x_aq_ifu_pcgen/pcgen_icache_va[13]} {u_soc/x_cpu_sub_system_axi/x_c906_wrapper/x_cpu_top/x_aq_top_0/x_aq_core/x_aq_ifu_top/x_aq_ifu_pcgen/pcgen_icache_va[14]} {u_soc/x_cpu_sub_system_axi/x_c906_wrapper/x_cpu_top/x_aq_top_0/x_aq_core/x_aq_ifu_top/x_aq_ifu_pcgen/pcgen_icache_va[15]} {u_soc/x_cpu_sub_system_axi/x_c906_wrapper/x_cpu_top/x_aq_top_0/x_aq_core/x_aq_ifu_top/x_aq_ifu_pcgen/pcgen_icache_va[16]} {u_soc/x_cpu_sub_system_axi/x_c906_wrapper/x_cpu_top/x_aq_top_0/x_aq_core/x_aq_ifu_top/x_aq_ifu_pcgen/pcgen_icache_va[17]} {u_soc/x_cpu_sub_system_axi/x_c906_wrapper/x_cpu_top/x_aq_top_0/x_aq_core/x_aq_ifu_top/x_aq_ifu_pcgen/pcgen_icache_va[18]} {u_soc/x_cpu_sub_system_axi/x_c906_wrapper/x_cpu_top/x_aq_top_0/x_aq_core/x_aq_ifu_top/x_aq_ifu_pcgen/pcgen_icache_va[19]} {u_soc/x_cpu_sub_system_axi/x_c906_wrapper/x_cpu_top/x_aq_top_0/x_aq_core/x_aq_ifu_top/x_aq_ifu_pcgen/pcgen_icache_va[20]} {u_soc/x_cpu_sub_system_axi/x_c906_wrapper/x_cpu_top/x_aq_top_0/x_aq_core/x_aq_ifu_top/x_aq_ifu_pcgen/pcgen_icache_va[21]} {u_soc/x_cpu_sub_system_axi/x_c906_wrapper/x_cpu_top/x_aq_top_0/x_aq_core/x_aq_ifu_top/x_aq_ifu_pcgen/pcgen_icache_va[22]} {u_soc/x_cpu_sub_system_axi/x_c906_wrapper/x_cpu_top/x_aq_top_0/x_aq_core/x_aq_ifu_top/x_aq_ifu_pcgen/pcgen_icache_va[23]} {u_soc/x_cpu_sub_system_axi/x_c906_wrapper/x_cpu_top/x_aq_top_0/x_aq_core/x_aq_ifu_top/x_aq_ifu_pcgen/pcgen_icache_va[24]} {u_soc/x_cpu_sub_system_axi/x_c906_wrapper/x_cpu_top/x_aq_top_0/x_aq_core/x_aq_ifu_top/x_aq_ifu_pcgen/pcgen_icache_va[25]} {u_soc/x_cpu_sub_system_axi/x_c906_wrapper/x_cpu_top/x_aq_top_0/x_aq_core/x_aq_ifu_top/x_aq_ifu_pcgen/pcgen_icache_va[26]} {u_soc/x_cpu_sub_system_axi/x_c906_wrapper/x_cpu_top/x_aq_top_0/x_aq_core/x_aq_ifu_top/x_aq_ifu_pcgen/pcgen_icache_va[27]} {u_soc/x_cpu_sub_system_axi/x_c906_wrapper/x_cpu_top/x_aq_top_0/x_aq_core/x_aq_ifu_top/x_aq_ifu_pcgen/pcgen_icache_va[28]} {u_soc/x_cpu_sub_system_axi/x_c906_wrapper/x_cpu_top/x_aq_top_0/x_aq_core/x_aq_ifu_top/x_aq_ifu_pcgen/pcgen_icache_va[29]} {u_soc/x_cpu_sub_system_axi/x_c906_wrapper/x_cpu_top/x_aq_top_0/x_aq_core/x_aq_ifu_top/x_aq_ifu_pcgen/pcgen_icache_va[30]} {u_soc/x_cpu_sub_system_axi/x_c906_wrapper/x_cpu_top/x_aq_top_0/x_aq_core/x_aq_ifu_top/x_aq_ifu_pcgen/pcgen_icache_va[31]} {u_soc/x_cpu_sub_system_axi/x_c906_wrapper/x_cpu_top/x_aq_top_0/x_aq_core/x_aq_ifu_top/x_aq_ifu_pcgen/pcgen_icache_va[32]} {u_soc/x_cpu_sub_system_axi/x_c906_wrapper/x_cpu_top/x_aq_top_0/x_aq_core/x_aq_ifu_top/x_aq_ifu_pcgen/pcgen_icache_va[33]} {u_soc/x_cpu_sub_system_axi/x_c906_wrapper/x_cpu_top/x_aq_top_0/x_aq_core/x_aq_ifu_top/x_aq_ifu_pcgen/pcgen_icache_va[34]} {u_soc/x_cpu_sub_system_axi/x_c906_wrapper/x_cpu_top/x_aq_top_0/x_aq_core/x_aq_ifu_top/x_aq_ifu_pcgen/pcgen_icache_va[35]} {u_soc/x_cpu_sub_system_axi/x_c906_wrapper/x_cpu_top/x_aq_top_0/x_aq_core/x_aq_ifu_top/x_aq_ifu_pcgen/pcgen_icache_va[36]} {u_soc/x_cpu_sub_system_axi/x_c906_wrapper/x_cpu_top/x_aq_top_0/x_aq_core/x_aq_ifu_top/x_aq_ifu_pcgen/pcgen_icache_va[37]} {u_soc/x_cpu_sub_system_axi/x_c906_wrapper/x_cpu_top/x_aq_top_0/x_aq_core/x_aq_ifu_top/x_aq_ifu_pcgen/pcgen_icache_va[38]} {u_soc/x_cpu_sub_system_axi/x_c906_wrapper/x_cpu_top/x_aq_top_0/x_aq_core/x_aq_ifu_top/x_aq_ifu_pcgen/pcgen_icache_va[39]} {u_soc/x_cpu_sub_system_axi/x_c906_wrapper/x_cpu_top/x_aq_top_0/x_aq_core/x_aq_ifu_top/x_aq_ifu_pcgen/pcgen_icache_va[40]} {u_soc/x_cpu_sub_system_axi/x_c906_wrapper/x_cpu_top/x_aq_top_0/x_aq_core/x_aq_ifu_top/x_aq_ifu_pcgen/pcgen_icache_va[41]} {u_soc/x_cpu_sub_system_axi/x_c906_wrapper/x_cpu_top/x_aq_top_0/x_aq_core/x_aq_ifu_top/x_aq_ifu_pcgen/pcgen_icache_va[42]} {u_soc/x_cpu_sub_system_axi/x_c906_wrapper/x_cpu_top/x_aq_top_0/x_aq_core/x_aq_ifu_top/x_aq_ifu_pcgen/pcgen_icache_va[43]} {u_soc/x_cpu_sub_system_axi/x_c906_wrapper/x_cpu_top/x_aq_top_0/x_aq_core/x_aq_ifu_top/x_aq_ifu_pcgen/pcgen_icache_va[44]} {u_soc/x_cpu_sub_system_axi/x_c906_wrapper/x_cpu_top/x_aq_top_0/x_aq_core/x_aq_ifu_top/x_aq_ifu_pcgen/pcgen_icache_va[45]} {u_soc/x_cpu_sub_system_axi/x_c906_wrapper/x_cpu_top/x_aq_top_0/x_aq_core/x_aq_ifu_top/x_aq_ifu_pcgen/pcgen_icache_va[46]} {u_soc/x_cpu_sub_system_axi/x_c906_wrapper/x_cpu_top/x_aq_top_0/x_aq_core/x_aq_ifu_top/x_aq_ifu_pcgen/pcgen_icache_va[47]} {u_soc/x_cpu_sub_system_axi/x_c906_wrapper/x_cpu_top/x_aq_top_0/x_aq_core/x_aq_ifu_top/x_aq_ifu_pcgen/pcgen_icache_va[48]} {u_soc/x_cpu_sub_system_axi/x_c906_wrapper/x_cpu_top/x_aq_top_0/x_aq_core/x_aq_ifu_top/x_aq_ifu_pcgen/pcgen_icache_va[49]} {u_soc/x_cpu_sub_system_axi/x_c906_wrapper/x_cpu_top/x_aq_top_0/x_aq_core/x_aq_ifu_top/x_aq_ifu_pcgen/pcgen_icache_va[50]} {u_soc/x_cpu_sub_system_axi/x_c906_wrapper/x_cpu_top/x_aq_top_0/x_aq_core/x_aq_ifu_top/x_aq_ifu_pcgen/pcgen_icache_va[51]} {u_soc/x_cpu_sub_system_axi/x_c906_wrapper/x_cpu_top/x_aq_top_0/x_aq_core/x_aq_ifu_top/x_aq_ifu_pcgen/pcgen_icache_va[52]} {u_soc/x_cpu_sub_system_axi/x_c906_wrapper/x_cpu_top/x_aq_top_0/x_aq_core/x_aq_ifu_top/x_aq_ifu_pcgen/pcgen_icache_va[53]} {u_soc/x_cpu_sub_system_axi/x_c906_wrapper/x_cpu_top/x_aq_top_0/x_aq_core/x_aq_ifu_top/x_aq_ifu_pcgen/pcgen_icache_va[54]} {u_soc/x_cpu_sub_system_axi/x_c906_wrapper/x_cpu_top/x_aq_top_0/x_aq_core/x_aq_ifu_top/x_aq_ifu_pcgen/pcgen_icache_va[55]} {u_soc/x_cpu_sub_system_axi/x_c906_wrapper/x_cpu_top/x_aq_top_0/x_aq_core/x_aq_ifu_top/x_aq_ifu_pcgen/pcgen_icache_va[56]} {u_soc/x_cpu_sub_system_axi/x_c906_wrapper/x_cpu_top/x_aq_top_0/x_aq_core/x_aq_ifu_top/x_aq_ifu_pcgen/pcgen_icache_va[57]} {u_soc/x_cpu_sub_system_axi/x_c906_wrapper/x_cpu_top/x_aq_top_0/x_aq_core/x_aq_ifu_top/x_aq_ifu_pcgen/pcgen_icache_va[58]} {u_soc/x_cpu_sub_system_axi/x_c906_wrapper/x_cpu_top/x_aq_top_0/x_aq_core/x_aq_ifu_top/x_aq_ifu_pcgen/pcgen_icache_va[59]} {u_soc/x_cpu_sub_system_axi/x_c906_wrapper/x_cpu_top/x_aq_top_0/x_aq_core/x_aq_ifu_top/x_aq_ifu_pcgen/pcgen_icache_va[60]} {u_soc/x_cpu_sub_system_axi/x_c906_wrapper/x_cpu_top/x_aq_top_0/x_aq_core/x_aq_ifu_top/x_aq_ifu_pcgen/pcgen_icache_va[61]} {u_soc/x_cpu_sub_system_axi/x_c906_wrapper/x_cpu_top/x_aq_top_0/x_aq_core/x_aq_ifu_top/x_aq_ifu_pcgen/pcgen_icache_va[62]} {u_soc/x_cpu_sub_system_axi/x_c906_wrapper/x_cpu_top/x_aq_top_0/x_aq_core/x_aq_ifu_top/x_aq_ifu_pcgen/pcgen_icache_va[63]}]]
set_property C_CLK_INPUT_FREQ_HZ 300000000 [get_debug_cores dbg_hub]
set_property C_ENABLE_CLK_DIVIDER false [get_debug_cores dbg_hub]
set_property C_USER_SCAN_CHAIN 1 [get_debug_cores dbg_hub]
connect_debug_port dbg_hub/clk [get_nets clk_out5]
