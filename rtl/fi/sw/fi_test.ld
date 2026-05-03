/* Linker script for Ibex FI test program.
 * Places everything in the lower 1KB of the 128KB BRAM at 0x00000000. */

MEMORY
{
    RAM (rwx) : ORIGIN = 0x00000000, LENGTH = 128K
}

SECTIONS
{
    .text : {
        *(.text*)
    } > RAM

    .rodata : {
        *(.rodata*)
    } > RAM

    .data : {
        *(.data*)
    } > RAM

    .bss : {
        *(.bss*)
    } > RAM

    /DISCARD/ : {
        *(.comment*)
        *(.riscv.attributes*)
    }
}
