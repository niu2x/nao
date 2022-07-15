ENTRY(_start)

OUTPUT_FORMAT(elf32-i386)
OUTPUT_ARCH(i386)

SECTIONS {
	. = 0x10000;
	. = ALIGN(4);
	.text : {
		*(.text)
	}
	. = ALIGN(4);
	.data : {
		*(.data)
		*(.bss)
		*(.rodata)
		*(COMMON)
	}

	/DISCARD/: {
		*(*)
	}
}