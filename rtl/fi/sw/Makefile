# Build the Ibex FI test program.
# Requires: riscv32-unknown-elf toolchain (RISC-V GCC)
#
# Usage:
#   make                 Build fi_test.vmem (Verilog hex for $readmemh)
#   make clean           Remove build artifacts

CROSS = riscv32-unknown-elf
ARCH  = rv32imc
ABI   = ilp32

TARGET = fi_test

CFLAGS  = -march=$(ARCH) -mabi=$(ABI) -nostdlib -nostartfiles -O2
LDFLAGS = -march=$(ARCH) -mabi=$(ABI) -nostdlib -T fi_test.ld

all: $(TARGET).vmem

$(TARGET).elf: fi_test.S fi_test.ld
	$(CROSS)-gcc $(CFLAGS) $(LDFLAGS) fi_test.S -o $@

$(TARGET).bin: $(TARGET).elf
	$(CROSS)-objcopy -O binary $< $@

$(TARGET).vmem: $(TARGET).elf
	$(CROSS)-objcopy -O verilog $< $@

# Also produce a .coe for Vivado BRAM initialization
$(TARGET).coe: $(TARGET).bin
	@echo "memory_initialization_radix=16;" > $@
	@echo "memory_initialization_vector=" >> $@
	@hexdump -v -e '4/4 "%08X " "\n"' $< | sed 's/ /,/g' | sed 's/,$$//' >> $@
	@echo ";" >> $@

clean:
	rm -f $(TARGET).elf $(TARGET).bin $(TARGET).vmem $(TARGET).coe

.PHONY: all clean
