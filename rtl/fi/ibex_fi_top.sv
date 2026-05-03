// ============================================================================
// ibex_fi_top — Ibex-based dual-core fault injection test system
// ============================================================================
//
// Architecture:
//   Two identical Ibex cores (32-bit RV32IMC) execute the same program from
//   independent dual-port BRAMs. A 32-way register comparator flags any
//   divergence caused by SEM IP configuration-bit flips. The fault_count
//   module (reused from the C906 design) manages injection windows via UART
//   and reports outcomes: 0x00 = No Effect, 0x01 = SDC, 0x02 = Crash.
//
// UART protocol (identical to C906 design):
//   's' (0x73) — Start injection window, reset accumulators
//   'e' (0x65) — End window, push outcome to FIFO, pulse core reset
//   'c' (0x63) — Collect: flush FIFO over UART TX
//
// UART TX mux: SEM IP owns TX by default; fault_count takes over during
//               FIFO flush (fc_uart_tx_active = 1).
// ============================================================================

module ibex_fi_top (
    // Differential clock input (from FPGA oscillator)
    input  logic        clk_in1_p,
    input  logic        clk_in1_n,

    // External reset (active-high button)
    input  logic        reset,

    // UART to host
    input  logic        uart0_sin_rx,
    output logic        uart0_sout_tx,

    // Debug / monitoring
    output logic        led_compare,
    output logic [15:0] fault_count_out,
    output logic        verf
);

  // ---------- Clock & reset ----------
  wire clk_cpu;       // clk_out1: Ibex cores
  wire clk_out2;      // unused
  wire clk_sem;       // clk_out3: SEM IP
  wire clk_sys;       // clk_out4: fault_count
  wire clk_out5;      // unused (VIO)
  wire locked;

  wire cpurst;
  wire link_nrst;

  // ---------- UART & fault injection ----------
  wire         compare_mismatch;
  wire [15:0]  fault_cnt;
  wire         fc_uart_tx;
  wire         fc_uart_tx_active;
  wire         sem_uart_tx;

  // ---------- Register export arrays ----------
  wire [31:0]  core0_regs [32];
  wire [31:0]  core1_regs [32];

  // ---------- Clock wizard ----------
  (* DONT_TOUCH = "TRUE" *) clk_wiz_0 u_clk_wiz_0 (
    .clk_out1  (clk_cpu),
    .clk_out2  (clk_out2),
    .clk_out3  (clk_sem),
    .clk_out4  (clk_sys),
    .clk_out5  (clk_out5),
    .resetn    (reset),
    .locked    (locked),
    .clk_in1_p (clk_in1_p),
    .clk_in1_n (clk_in1_n)
  );

  // ---------- Reset chain ----------
  // cpurst = link_nrst AND external reset.
  // link_nrst is pulsed low by fault_count on 'e' to restart both cores
  // for the next injection window.
  assign cpurst = link_nrst & reset;

  // ---------- Ibex core 0 (golden) ----------
  ibex_fi_wrapper #(
    .MEM_DEPTH(32768),  // 128KB
    .BOOT_ADDR(32'h00000000)
  ) u_core0 (
    .clk_i     (clk_cpu),
    .rst_ni    (cpurst),
    .rf_regs_o (core0_regs)
  );

  // ---------- Ibex core 1 (worker) ----------
  ibex_fi_wrapper #(
    .MEM_DEPTH(32768),  // 128KB — same as core 0
    .BOOT_ADDR(32'h00000000)
  ) u_core1 (
    .clk_i     (clk_cpu),
    .rst_ni    (cpurst),
    .rf_regs_o (core1_regs)
  );

  // ---------- 32-way register comparator ----------
  ibex_fi_compare u_compare (
    .reg_0   (core0_regs[0]),  .reg_0b  (core1_regs[0]),
    .reg_1   (core0_regs[1]),  .reg_1b  (core1_regs[1]),
    .reg_2   (core0_regs[2]),  .reg_2b  (core1_regs[2]),
    .reg_3   (core0_regs[3]),  .reg_3b  (core1_regs[3]),
    .reg_4   (core0_regs[4]),  .reg_4b  (core1_regs[4]),
    .reg_5   (core0_regs[5]),  .reg_5b  (core1_regs[5]),
    .reg_6   (core0_regs[6]),  .reg_6b  (core1_regs[6]),
    .reg_7   (core0_regs[7]),  .reg_7b  (core1_regs[7]),
    .reg_8   (core0_regs[8]),  .reg_8b  (core1_regs[8]),
    .reg_9   (core0_regs[9]),  .reg_9b  (core1_regs[9]),
    .reg_10  (core0_regs[10]), .reg_10b (core1_regs[10]),
    .reg_11  (core0_regs[11]), .reg_11b (core1_regs[11]),
    .reg_12  (core0_regs[12]), .reg_12b (core1_regs[12]),
    .reg_13  (core0_regs[13]), .reg_13b (core1_regs[13]),
    .reg_14  (core0_regs[14]), .reg_14b (core1_regs[14]),
    .reg_15  (core0_regs[15]), .reg_15b (core1_regs[15]),
    .reg_16  (core0_regs[16]), .reg_16b (core1_regs[16]),
    .reg_17  (core0_regs[17]), .reg_17b (core1_regs[17]),
    .reg_18  (core0_regs[18]), .reg_18b (core1_regs[18]),
    .reg_19  (core0_regs[19]), .reg_19b (core1_regs[19]),
    .reg_20  (core0_regs[20]), .reg_20b (core1_regs[20]),
    .reg_21  (core0_regs[21]), .reg_21b (core1_regs[21]),
    .reg_22  (core0_regs[22]), .reg_22b (core1_regs[22]),
    .reg_23  (core0_regs[23]), .reg_23b (core1_regs[23]),
    .reg_24  (core0_regs[24]), .reg_24b (core1_regs[24]),
    .reg_25  (core0_regs[25]), .reg_25b (core1_regs[25]),
    .reg_26  (core0_regs[26]), .reg_26b (core1_regs[26]),
    .reg_27  (core0_regs[27]), .reg_27b (core1_regs[27]),
    .reg_28  (core0_regs[28]), .reg_28b (core1_regs[28]),
    .reg_29  (core0_regs[29]), .reg_29b (core1_regs[29]),
    .reg_30  (core0_regs[30]), .reg_30b (core1_regs[30]),
    .reg_31  (core0_regs[31]), .reg_31b (core1_regs[31]),
    .mismatch (compare_mismatch)
  );

  // ---------- Fault count / UART protocol manager ----------
  fault_count #(
    .CLK_FRE              (100),
    .DATA_WIDTH           (8),
    .PARITY_ON            (0),
    .PARITY_TYPE          (0),
    .BAUD_RATE            (115200),
    .CRASH_TIMEOUT_CYCLES (32'd200_000_000),
    .FIFO_DEPTH_LOG2      (11)   // 2048-entry FIFO
  ) u_fault_count (
    .i_clk_sys         (clk_sys),
    .i_rst_n           (reset),
    .i_uart_rx         (uart0_sin_rx),
    .compare           (compare_mismatch),
    .o_uart_data       (),
    .o_ld_parity       (),
    .o_rx_done         (),
    .compare_valid_sign(),
    .fault             (fault_cnt),
    .cklink_nrst       (link_nrst),
    .o_uart_tx         (fc_uart_tx),
    .o_uart_tx_active  (fc_uart_tx_active)
  );

  // ---------- SEM IP ----------
  (* DONT_TOUCH = "TRUE" *) sem_ultra_0_example_design u_sem (
    .clk_in      (clk_sem),
    .reset_n     (reset),
    .uart_rx     (uart0_sin_rx),
    .uart_tx     (sem_uart_tx)
    // Additional SEM IP ports (status, error, etc.) connected per IP config
  );

  // ---------- UART TX mux ----------
  // SEM IP owns TX by default; fault_count takes over during result collection.
  assign uart0_sout_tx = fc_uart_tx_active ? fc_uart_tx : sem_uart_tx;

  // ---------- Debug outputs ----------
  assign led_compare     = compare_mismatch;
  assign fault_count_out = fault_cnt;
  assign verf            = 1'b1;

endmodule
