# ============================================================================
# ibex_fi_top.xdc — Ibex 小型化故障注入测试系统 约束文件
# 适配板卡: 与 C906_SSS.xdc 相同的 Xilinx Kintex UltraScale (XCKU040) 板卡
# 主要保留 C906 设计中已验证的引脚分配（时钟/UART/复位/LED）
# ============================================================================

# ---------------------------------------------------------------------------
# 一、时钟输入
# ---------------------------------------------------------------------------
# 100 MHz 差分时钟（与 C906 设计同源）
set_property PACKAGE_PIN AK17 [get_ports clk_in1_p]
set_property IOSTANDARD DIFF_HSTL_I_18 [get_ports clk_in1_p]

# 输入时钟周期约束 (10 ns = 100 MHz)
create_clock -period 10.000 -name clk_in1_p [get_ports clk_in1_p]

# ---------------------------------------------------------------------------
# 二、复位
# ---------------------------------------------------------------------------
set_property PACKAGE_PIN Y22 [get_ports reset]
set_property IOSTANDARD LVCMOS18 [get_ports reset]

# ---------------------------------------------------------------------------
# 三、UART 接口 (115200, 8N1)
# ---------------------------------------------------------------------------
set_property PACKAGE_PIN AG32 [get_ports uart0_sin_rx]
set_property IOSTANDARD LVCMOS18 [get_ports uart0_sin_rx]

set_property PACKAGE_PIN AG31 [get_ports uart0_sout_tx]
set_property IOSTANDARD LVCMOS18 [get_ports uart0_sout_tx]

# 减小 TX 输出驱动 slew rate，避免过冲
set_property SLEW SLOW [get_ports uart0_sout_tx]

# ---------------------------------------------------------------------------
# 四、调试/状态指示
# ---------------------------------------------------------------------------
# LED: 寄存器比较失配指示（与 C906 设计同位置）
set_property PACKAGE_PIN N23 [get_ports led_compare]
set_property IOSTANDARD LVCMOS33 [get_ports led_compare]

# 验证标志（恒为 1，用于上电指示）
set_property PACKAGE_PIN M26 [get_ports verf]
set_property IOSTANDARD LVCMOS33 [get_ports verf]

# ---------------------------------------------------------------------------
# 五、Fault count 计数输出 (16-bit)
# ---------------------------------------------------------------------------
# 低 8 位映射到 C906 设计中的 GPIO 引脚，可用逻辑分析仪或 LED 直接观测
set_property PACKAGE_PIN N21 [get_ports {fault_count_out[0]}]
set_property PACKAGE_PIN M21 [get_ports {fault_count_out[1]}]
set_property PACKAGE_PIN L27 [get_ports {fault_count_out[2]}]
set_property PACKAGE_PIN M27 [get_ports {fault_count_out[3]}]
set_property PACKAGE_PIN L24 [get_ports {fault_count_out[4]}]
set_property PACKAGE_PIN L23 [get_ports {fault_count_out[5]}]
set_property PACKAGE_PIN AF12 [get_ports {fault_count_out[6]}]
set_property PACKAGE_PIN AF13 [get_ports {fault_count_out[7]}]

set_property IOSTANDARD LVCMOS33 [get_ports {fault_count_out[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {fault_count_out[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {fault_count_out[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {fault_count_out[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {fault_count_out[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {fault_count_out[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {fault_count_out[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {fault_count_out[7]}]

# 高 8 位 (fault_count_out[15:8]) 默认未分配引脚
# 选项 A: 注释掉或删除该端口（修改 ibex_fi_top.sv 顶层端口）
# 选项 B: 根据板卡自行分配引脚
# 选项 C: 通过 Vivado VIO IP 在线观察（无需引脚）
# 以下为占位 IOSTANDARD，需用户补充 PACKAGE_PIN 后启用
# set_property IOSTANDARD LVCMOS33 [get_ports {fault_count_out[8]}]
# set_property IOSTANDARD LVCMOS33 [get_ports {fault_count_out[9]}]
# set_property IOSTANDARD LVCMOS33 [get_ports {fault_count_out[10]}]
# set_property IOSTANDARD LVCMOS33 [get_ports {fault_count_out[11]}]
# set_property IOSTANDARD LVCMOS33 [get_ports {fault_count_out[12]}]
# set_property IOSTANDARD LVCMOS33 [get_ports {fault_count_out[13]}]
# set_property IOSTANDARD LVCMOS33 [get_ports {fault_count_out[14]}]
# set_property IOSTANDARD LVCMOS33 [get_ports {fault_count_out[15]}]

# ---------------------------------------------------------------------------
# 六、综合优化保护
# ---------------------------------------------------------------------------
# 防止综合器优化掉关键比对路径，确保两个 Ibex 核独立例化
set_property DONT_TOUCH TRUE [get_cells u_core0]
set_property DONT_TOUCH TRUE [get_cells u_core1]
set_property DONT_TOUCH TRUE [get_cells u_compare]
set_property DONT_TOUCH TRUE [get_cells u_fault_count]

# ---------------------------------------------------------------------------
# 七、比较器 Pblock 物理约束（参考 C906 设计的 c906_comparee pblock）
# ---------------------------------------------------------------------------
# 将比较逻辑约束在芯片中央区域，缩短从两个 Ibex 寄存器堆到比较器的布线
# 坐标范围与 C906 设计相同（SLICE_X91Y285:SLICE_X100Y299）
create_pblock pblock_compare
add_cells_to_pblock [get_pblocks pblock_compare] [get_cells -quiet [list u_compare]]
resize_pblock [get_pblocks pblock_compare] -add {SLICE_X91Y285:SLICE_X100Y299}

# ---------------------------------------------------------------------------
# 八、跨时钟域 false_path（按需启用）
# ---------------------------------------------------------------------------
# fault_count 模块和 Ibex 核分别由 clk_sys (clk_out4) 和 clk_cpu (clk_out1) 驱动
# 比较器输出 (compare_mismatch) 跨越这两个时钟域，需要 false_path 标记
# 注：clk_out1/clk_out4 由 clk_wiz_0 自动生成，路径名以实际综合后为准
# set_false_path -from [get_clocks -of_objects [get_pins u_clk_wiz_0/inst/mmcme*/CLKOUT0]] \
#                -to   [get_clocks -of_objects [get_pins u_clk_wiz_0/inst/mmcme*/CLKOUT3]]
# set_false_path -from [get_clocks -of_objects [get_pins u_clk_wiz_0/inst/mmcme*/CLKOUT3]] \
#                -to   [get_clocks -of_objects [get_pins u_clk_wiz_0/inst/mmcme*/CLKOUT0]]

# 如果选择 fault_count 与 Ibex 共用同一时钟（clk_out1），可省略上述 false_path

# ---------------------------------------------------------------------------
# 九、Bitstream / 配置选项
# ---------------------------------------------------------------------------
# SEM IP 需要访问 ICAP 接口，禁用 bitstream 加密
# set_property BITSTREAM.GENERAL.COMPRESS TRUE [current_design]
# set_property CONFIG_VOLTAGE 1.8 [current_design]
# set_property CFGBVS GND [current_design]
