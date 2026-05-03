// Minimal Ibex system wrapper for dual-core fault injection comparison.
// Instantiates ibex_core directly (bypassing ibex_top) with a custom register
// file that exposes all 32 architectural registers, and a dual-port BRAM for
// instruction+data memory.
//
// Configured for minimal area: no ICache, no PMP, no SecureIbex, 2-stage
// pipeline, no branch predictor, no debug triggers, no ECC.

module ibex_fi_wrapper #(
    parameter int unsigned        MEM_DEPTH = 65536,        // 256KB RAM
    parameter logic        [31:0] BOOT_ADDR = 32'h00000000
) (
  input logic clk_i,
  input logic rst_ni,

  // All 32 architectural registers exported for comparison
  output logic [31:0] rf_regs_o[32]
);

  import ibex_pkg::*;

  // ---------- Ibex core configuration ----------
  localparam bit RV32E = 0;
  localparam rv32m_e RV32M = RV32MFast;
  localparam rv32b_e RV32B = RV32BNone;
  localparam rv32zc_e RV32ZC = RV32ZcaZcbZcmp;
  localparam bit MemECC = 0;
  localparam int unsigned RegFileDataWidth = 32;
  localparam int unsigned MemDataWidth = 32;

  // ---------- Signals ----------
  // Instruction bus
  logic                        instr_req;
  logic                        instr_gnt;
  logic                        instr_rvalid;
  logic [                31:0] instr_addr;
  logic [    MemDataWidth-1:0] instr_rdata;
  logic                        instr_err;

  // Data bus
  logic                        data_req;
  logic                        data_gnt;
  logic                        data_rvalid;
  logic                        data_we;
  logic [                 3:0] data_be;
  logic [                31:0] data_addr;
  logic [    MemDataWidth-1:0] data_wdata;
  logic [    MemDataWidth-1:0] data_rdata;
  logic                        data_err;

  // Register file interface
  logic                        dummy_instr_id;
  logic                        dummy_instr_wb;
  logic [                 4:0] rf_raddr_a;
  logic [                 4:0] rf_raddr_b;
  logic [                 4:0] rf_waddr_wb;
  logic                        rf_we_wb;
  logic [RegFileDataWidth-1:0] rf_wdata_wb_ecc;
  logic [RegFileDataWidth-1:0] rf_rdata_a_ecc;
  logic [RegFileDataWidth-1:0] rf_rdata_b_ecc;

  // RAM signals
  logic                        ram_a_rvalid;
  logic [                31:0] ram_a_rdata;
  logic                        ram_b_rvalid;
  logic [                31:0] ram_b_rdata;

  // ---------- Ibex core ----------
  ibex_core #(
    .PMPEnable        (1'b0),
    .PMPGranularity   (0),
    .PMPNumRegions    (4),
    .MHPMCounterNum   (0),
    .MHPMCounterWidth (40),
    .RV32E            (RV32E),
    .RV32M            (RV32M),
    .RV32B            (RV32B),
    .RV32ZC           (RV32ZC),
    .BranchTargetALU  (0),
    .WritebackStage   (0),
    .ICache           (0),
    .ICacheECC        (0),
    .BranchPredictor  (0),
    .DbgTriggerEn     (0),
    .DbgHwBreakNum    (1),
    .SecureIbex       (0),
    .DummyInstructions(0),
    .RegFileECC       (0),
    .RegFileDataWidth (RegFileDataWidth),
    .MemECC           (MemECC),
    .MemDataWidth     (MemDataWidth),
    .DmBaseAddr       (32'h1A110000),
    .DmHaltAddr       (32'h1A110800),
    .DmExceptionAddr  (32'h1A110808)
  ) u_core (
    .clk_i,
    .rst_ni,
    .hart_id_i  (32'h00000000),
    .boot_addr_i(BOOT_ADDR),

    // Instruction bus
    .instr_req_o   (instr_req),
    .instr_gnt_i   (instr_gnt),
    .instr_rvalid_i(instr_rvalid),
    .instr_addr_o  (instr_addr),
    .instr_rdata_i (instr_rdata),
    .instr_err_i   (instr_err),

    // Data bus
    .data_req_o   (data_req),
    .data_gnt_i   (data_gnt),
    .data_rvalid_i(data_rvalid),
    .data_we_o    (data_we),
    .data_be_o    (data_be),
    .data_addr_o  (data_addr),
    .data_wdata_o (data_wdata),
    .data_rdata_i (data_rdata),
    .data_err_i   (data_err),

    // Register file
    .dummy_instr_id_o (dummy_instr_id),
    .dummy_instr_wb_o (dummy_instr_wb),
    .rf_raddr_a_o     (rf_raddr_a),
    .rf_raddr_b_o     (rf_raddr_b),
    .rf_waddr_wb_o    (rf_waddr_wb),
    .rf_we_wb_o       (rf_we_wb),
    .rf_wdata_wb_ecc_o(rf_wdata_wb_ecc),
    .rf_rdata_a_ecc_i (rf_rdata_a_ecc),
    .rf_rdata_b_ecc_i (rf_rdata_b_ecc),

    // ICache RAMs — not used (ICache=0), tie off inputs
    .ic_tag_req_o      (),
    .ic_tag_write_o    (),
    .ic_tag_addr_o     (),
    .ic_tag_wdata_o    (),
    .ic_tag_rdata_i    ('{default: '0}),
    .ic_data_req_o     (),
    .ic_data_write_o   (),
    .ic_data_addr_o    (),
    .ic_data_wdata_o   (),
    .ic_data_rdata_i   ('{default: '0}),
    .ic_scr_key_valid_i(1'b0),
    .ic_scr_key_req_o  (),

    // Interrupts — all tied off (no peripherals)
    .irq_software_i(1'b0),
    .irq_timer_i   (1'b0),
    .irq_external_i(1'b0),
    .irq_fast_i    (15'b0),
    .irq_nm_i      (1'b0),
    .irq_pending_o (),

    // Debug — not used
    .debug_req_i           (1'b0),
    .crash_dump_o          (),
    .double_fault_seen_o   (),
    .fetch_enable_i        (IbexMuBiOn),
    .alert_minor_o         (),
    .alert_major_internal_o(),
    .alert_major_bus_o     (),
    .core_busy_o           ()
  );

  // ---------- Custom register file with full export ----------
  ibex_register_file_fpga_fi #(
    .RV32E            (RV32E),
    .DataWidth        (RegFileDataWidth),
    .DummyInstructions(0),
    .WordZeroVal      ('0)
  ) u_regfile (
    .clk_i,
    .rst_ni,
    .test_en_i       (1'b0),
    .dummy_instr_id_i(dummy_instr_id),
    .dummy_instr_wb_i(dummy_instr_wb),
    .raddr_a_i       (rf_raddr_a),
    .rdata_a_o       (rf_rdata_a_ecc),
    .raddr_b_i       (rf_raddr_b),
    .rdata_b_o       (rf_rdata_b_ecc),
    .waddr_a_i       (rf_waddr_wb),
    .wdata_a_i       (rf_wdata_wb_ecc),
    .we_a_i          (rf_we_wb),
    .rf_all_o        (rf_regs_o)
  );

  // ---------- Dual-port RAM (A: data, B: instructions) ----------
  assign instr_gnt   = 1'b1;  // always grant instruction requests
  assign instr_err   = 1'b0;  // no bus errors
  assign instr_rdata = {ram_b_rdata};  // MemDataWidth=32

  assign data_gnt    = 1'b1;  // always grant data requests
  assign data_err    = 1'b0;  // no bus errors
  assign data_rdata  = {ram_a_rdata};  // MemDataWidth=32
  assign data_rvalid = ram_a_rvalid;

  ram_2p #(
    .Depth      (MEM_DEPTH),
    .BExtraDelay(0),          // no extra instruction fetch delay
    .MemInitFile("")
  ) u_ram (
    .clk_i,
    .rst_ni,
    // Port A: data memory (read/write)
    .a_req_i   (data_req),
    .a_we_i    (data_we),
    .a_be_i    (data_be),
    .a_addr_i  (data_addr),
    .a_wdata_i (data_wdata[31:0]),
    .a_rvalid_o(ram_a_rvalid),
    .a_rdata_o (ram_a_rdata),
    // Port B: instruction memory (read-only)
    .b_req_i   (instr_req),
    .b_we_i    (1'b0),
    .b_be_i    (4'b1111),
    .b_addr_i  (instr_addr),
    .b_wdata_i (32'b0),
    .b_rvalid_o(ram_b_rvalid),
    .b_rdata_o (ram_b_rdata)
  );

  assign instr_rvalid = ram_b_rvalid;

endmodule
