// Minimal RISC-V test program for Ibex dual-core fault injection.
// Initializes all 32 registers to known values, then loops forever
// performing ALU operations that touch every register each iteration.
//
// Build (requires riscv32-unknown-elf toolchain):
//   riscv32-unknown-elf-gcc -march=rv32imc -mabi=ilp32 -nostdlib -T fi_test.ld \
//       fi_test.S -o fi_test.elf
//   riscv32-unknown-elf-objcopy -O binary fi_test.elf fi_test.bin
//   riscv32-unknown-elf-objcopy -O verilog fi_test.elf fi_test.vmem
//
// The .vmem file can be loaded into the ram_2p via MemInitFile parameter.

    .section .text
    .globl _start
    .option norvc       // Disable compressed instructions for deterministic startup

_start:
    // Initialize all 32 registers to unique non-zero values.
    // x0 is always 0 (hardwired), but we list it for completeness.
    li   x1,  0xDEADB001
    li   x2,  0xDEADB002
    li   x3,  0xDEADB003
    li   x4,  0xDEADB004
    li   x5,  0xDEADB005
    li   x6,  0xDEADB006
    li   x7,  0xDEADB007
    li   x8,  0xDEADB008
    li   x9,  0xDEADB009
    li   x10, 0xDEADB00A
    li   x11, 0xDEADB00B
    li   x12, 0xDEADB00C
    li   x13, 0xDEADB00D
    li   x14, 0xDEADB00E
    li   x15, 0xDEADB00F
    li   x16, 0xDEADB010
    li   x17, 0xDEADB011
    li   x18, 0xDEADB012
    li   x19, 0xDEADB013
    li   x20, 0xDEADB014
    li   x21, 0xDEADB015
    li   x22, 0xDEADB016
    li   x23, 0xDEADB017
    li   x24, 0xDEADB018
    li   x25, 0xDEADB019
    li   x26, 0xDEADB01A
    li   x27, 0xDEADB01B
    li   x28, 0xDEADB01C
    li   x29, 0xDEADB01D
    li   x30, 0xDEADB01E
    li   x31, 0xDEADB01F

// Main loop: exercises all registers every iteration.
// The loop body uses every architectural register so that any single
// register corruption caused by an SEU will eventually be captured
// by the comparator.
loop:
    // Arithmetic chain that touches every register
    add   x1,  x1,  x2        // x1  = x1 + x2
    sub   x3,  x3,  x4        // x3  = x3 - x4
    xor   x5,  x5,  x6        // x5  = x5 ^ x6
    or    x7,  x7,  x8        // x7  = x7 | x8
    and   x9,  x9,  x10       // x9  = x9 & x10
    sll   x11, x11, x1        // x11 = x11 << (x1 & 0x1F)   [use low 5 bits]
    srl   x12, x12, x2        // x12 = x12 >> (x2 & 0x1F)
    sra   x13, x13, x3        // x13 = x13 >>> (x3 & 0x1F)
    slt   x14, x14, x15       // x14 = (x14 < x15 signed) ? 1 : 0
    sltu  x16, x16, x17       // x16 = (x16 < x17 unsigned) ? 1 : 0
    add   x18, x18, x19       // x18 = x18 + x19
    sub   x20, x20, x21       // x20 = x20 - x21
    xor   x22, x22, x23       // x22 = x22 ^ x23
    or    x24, x24, x25       // x24 = x24 | x25
    and   x26, x26, x27       // x26 = x26 & x27
    add   x28, x28, x29       // x28 = x28 + x29
    sub   x30, x30, x31       // x30 = x30 - x31

    // Multiplication (RV32M) for extra coverage
    mul   x31, x31, x1        // x31 = (x31 * x1)[31:0]

    // Second pass using results from the first pass, shuffling pairs.
    add   x2,  x2,  x3        // x2  = x2 + x3
    sub   x4,  x4,  x5        // x4  = x4 - x5
    xor   x6,  x6,  x7        // x6  = x6 ^ x7
    or    x8,  x8,  x9        // x8  = x8 | x9
    and   x10, x10, x11       // x10 = x10 & x11
    add   x15, x15, x16       // x15 = x15 + x16
    sub   x17, x17, x18       // x17 = x17 - x18
    xor   x19, x19, x20       // x19 = x19 ^ x20
    or    x21, x21, x22       // x21 = x21 | x22
    and   x23, x23, x24       // x23 = x23 & x24
    add   x25, x25, x26       // x25 = x25 + x26
    sub   x27, x27, x28       // x27 = x27 - x28
    xor   x29, x29, x30       // x29 = x29 ^ x30

    // Use x0 as operand (always zero) — verifies that x0 stays zero
    add   x1,  x0,  x1        // x1 = 0 + x1 (no-op for x1, but reads x0)

    j     loop                 // infinite loop
