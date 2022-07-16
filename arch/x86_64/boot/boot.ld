ENTRY(_start)

OUTPUT_FORMAT(elf32-i386)
OUTPUT_ARCH(i386)

SECTIONS {
	. = 0x7c00;
	.text.first_sector : {
		first_sector.o(.text);
	}	

	. = 0x10000;

	.text : {
		*(.text);
	}	
	
	. = ALIGN(16);
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