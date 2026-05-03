// Copyright lowRISC contributors.
// Copyright 2018 ETH Zurich and University of Bologna, see also CREDITS.md.
// Licensed under the Apache License, Version 2.0, see LICENSE for details.
// SPDX-License-Identifier: Apache-2.0
//
// Modified from ibex_register_file_fpga.sv:
//   Added rf_all_o port to export all 32 register values for fault injection
//   dual-core lockstep comparison.

/**
 * RISC-V register file — FPGA-optimized with full register export
 *
 * Register file with 31 or 15x 32 bit wide registers. Register 0 is fixed to 0.
 * This variant exposes all register contents on the rf_all_o output port,
 * allowing external comparison logic to detect fault-induced divergences
 * between two identical Ibex cores.
 */
module ibex_register_file_fpga_fi #(
    parameter bit                          RV32E             = 0,
    parameter int unsigned                 DataWidth         = 32,
    parameter bit                          DummyInstructions = 0,
    parameter logic        [DataWidth-1:0] WordZeroVal       = '0
) (
  // Clock and Reset
  input logic clk_i,
  input logic rst_ni,

  input logic test_en_i,
  input logic dummy_instr_id_i,
  input logic dummy_instr_wb_i,

  // Read port R1
  input  logic [          4:0] raddr_a_i,
  output logic [DataWidth-1:0] rdata_a_o,
  // Read port R2
  input  logic [          4:0] raddr_b_i,
  output logic [DataWidth-1:0] rdata_b_o,
  // Write port W1
  input  logic [          4:0] waddr_a_i,
  input  logic [DataWidth-1:0] wdata_a_i,
  input  logic                 we_a_i,

  // Full register file export for fault injection comparison
  output logic [DataWidth-1:0] rf_all_o[32]
);

  localparam int ADDR_WIDTH = RV32E ? 4 : 5;
  localparam int NUM_WORDS = 2 ** ADDR_WIDTH;

  logic [DataWidth-1:0] mem[NUM_WORDS];
  logic                 we;

  assign rdata_a_o = (raddr_a_i == '0) ? WordZeroVal : mem[raddr_a_i];
  assign rdata_b_o = (raddr_b_i == '0) ? WordZeroVal : mem[raddr_b_i];

  // Export all register values (combinational, for comparison)
  // Register 0 is always zero — exported for uniformity with C906 design
  for (genvar i = 0; i < 32; i++) begin : g_rf_export
    assign rf_all_o[i] = (i < NUM_WORDS) ? mem[i] : '0;
  end

  // we select — never write to x0
  assign we = (waddr_a_i == '0) ? 1'b0 : we_a_i;

  always @(posedge clk_i) begin : sync_write
    if (we == 1'b1) begin
      mem[waddr_a_i] <= wdata_a_i;
    end
  end : sync_write

  initial begin
    for (int k = 0; k < NUM_WORDS; k++) begin
      mem[k] = WordZeroVal;
    end
  end

  // Reset/unused signal tie-offs (same as original)
  logic unused_rst_ni;
  assign unused_rst_ni = rst_ni;
  logic unused_dummy_instr;
  assign unused_dummy_instr = dummy_instr_id_i ^ dummy_instr_wb_i;
  logic unused_test_en;
  assign unused_test_en = test_en_i;

endmodule
