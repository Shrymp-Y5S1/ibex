// 32-way 32-bit register comparator for Ibex dual-core fault injection.
// Compares architectural register state between two Ibex cores and asserts
// mismatch when any register pair differs.

module ibex_fi_compare (
  input  logic [31:0] reg_0,
  input  logic [31:0] reg_0b,
  input  logic [31:0] reg_1,
  input  logic [31:0] reg_1b,
  input  logic [31:0] reg_2,
  input  logic [31:0] reg_2b,
  input  logic [31:0] reg_3,
  input  logic [31:0] reg_3b,
  input  logic [31:0] reg_4,
  input  logic [31:0] reg_4b,
  input  logic [31:0] reg_5,
  input  logic [31:0] reg_5b,
  input  logic [31:0] reg_6,
  input  logic [31:0] reg_6b,
  input  logic [31:0] reg_7,
  input  logic [31:0] reg_7b,
  input  logic [31:0] reg_8,
  input  logic [31:0] reg_8b,
  input  logic [31:0] reg_9,
  input  logic [31:0] reg_9b,
  input  logic [31:0] reg_10,
  input  logic [31:0] reg_10b,
  input  logic [31:0] reg_11,
  input  logic [31:0] reg_11b,
  input  logic [31:0] reg_12,
  input  logic [31:0] reg_12b,
  input  logic [31:0] reg_13,
  input  logic [31:0] reg_13b,
  input  logic [31:0] reg_14,
  input  logic [31:0] reg_14b,
  input  logic [31:0] reg_15,
  input  logic [31:0] reg_15b,
  input  logic [31:0] reg_16,
  input  logic [31:0] reg_16b,
  input  logic [31:0] reg_17,
  input  logic [31:0] reg_17b,
  input  logic [31:0] reg_18,
  input  logic [31:0] reg_18b,
  input  logic [31:0] reg_19,
  input  logic [31:0] reg_19b,
  input  logic [31:0] reg_20,
  input  logic [31:0] reg_20b,
  input  logic [31:0] reg_21,
  input  logic [31:0] reg_21b,
  input  logic [31:0] reg_22,
  input  logic [31:0] reg_22b,
  input  logic [31:0] reg_23,
  input  logic [31:0] reg_23b,
  input  logic [31:0] reg_24,
  input  logic [31:0] reg_24b,
  input  logic [31:0] reg_25,
  input  logic [31:0] reg_25b,
  input  logic [31:0] reg_26,
  input  logic [31:0] reg_26b,
  input  logic [31:0] reg_27,
  input  logic [31:0] reg_27b,
  input  logic [31:0] reg_28,
  input  logic [31:0] reg_28b,
  input  logic [31:0] reg_29,
  input  logic [31:0] reg_29b,
  input  logic [31:0] reg_30,
  input  logic [31:0] reg_30b,
  input  logic [31:0] reg_31,
  input  logic [31:0] reg_31b,
  output logic        mismatch
);

  wire t0 = (reg_0 != reg_0b);
  wire t1 = (reg_1 != reg_1b);
  wire t2 = (reg_2 != reg_2b);
  wire t3 = (reg_3 != reg_3b);
  wire t4 = (reg_4 != reg_4b);
  wire t5 = (reg_5 != reg_5b);
  wire t6 = (reg_6 != reg_6b);
  wire t7 = (reg_7 != reg_7b);
  wire t8 = (reg_8 != reg_8b);
  wire t9 = (reg_9 != reg_9b);
  wire t10 = (reg_10 != reg_10b);
  wire t11 = (reg_11 != reg_11b);
  wire t12 = (reg_12 != reg_12b);
  wire t13 = (reg_13 != reg_13b);
  wire t14 = (reg_14 != reg_14b);
  wire t15 = (reg_15 != reg_15b);
  wire t16 = (reg_16 != reg_16b);
  wire t17 = (reg_17 != reg_17b);
  wire t18 = (reg_18 != reg_18b);
  wire t19 = (reg_19 != reg_19b);
  wire t20 = (reg_20 != reg_20b);
  wire t21 = (reg_21 != reg_21b);
  wire t22 = (reg_22 != reg_22b);
  wire t23 = (reg_23 != reg_23b);
  wire t24 = (reg_24 != reg_24b);
  wire t25 = (reg_25 != reg_25b);
  wire t26 = (reg_26 != reg_26b);
  wire t27 = (reg_27 != reg_27b);
  wire t28 = (reg_28 != reg_28b);
  wire t29 = (reg_29 != reg_29b);
  wire t30 = (reg_30 != reg_30b);
  wire t31 = (reg_31 != reg_31b);

  assign mismatch = t0 | t1 | t2 | t3 | t4 | t5 | t6 | t7 | t8 | t9 | t10 | t11 | t12 | t13 | t14 |
      t15 | t16 | t17 | t18 | t19 | t20 | t21 | t22 | t23 | t24 | t25 | t26 | t27 | t28 | t29 |
      t30 | t31;

endmodule
