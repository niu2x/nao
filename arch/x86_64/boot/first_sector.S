	.section .text
_start:	
	mov $0, %ax
	mov $0, %dl
	mov $0x0E, %ah
	mov $65, %al
	mov $0, %bh
	int $0x10
	int $0x10
1:	hlt
	jmp 1b
_end:
	.space 400-(_end-_start), 0x61
