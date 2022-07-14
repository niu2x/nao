	.section .text
	.code16
_start:	
	xor %ax, %ax
	mov %ax, %ds
	mov %ax, %fs
	mov %ax, %ss
	mov %ax, %es
	mov $0xE, %ah
	mov $0, %bh
	mov $(_msg-_start+0x7c00), %di
1:	mov 0(%di), %al
	cmp $0, %al
	je 1f
	int $0x10
	inc %di
	jmp 1b
1:	hlt
	jmp 1b
_msg:
	.asciz "hello world"
_end:
	.space 400-(_end-_start), 0x61
