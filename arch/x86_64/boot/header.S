// load at 0x1000:0x0000, 448KB
	.include "utils.h"
	.section .text
	.set origin, 0x0000
	.code16
_start:
	mov $0x1000, %ax
	mov %ax, %ds
	mov %ax, %es
	mov %ax, %fs

	mov $(_msg1 - _start + origin), %ax
	call _puts

1:	hlt
	jmp 1b

_putchar:
	push_regs
	mov $0xE, %ah	
	int $0x10
	pop_regs
	ret

_puts:
	push_regs
	mov %ax, %di
1:	mov 0(%di), %al
	cmp $0, %al
	je 2f
	call _putchar
	inc %di
	jmp 1b
2:	pop_regs
	ret

_msg1:
	.asciz "[nao] header begin \n\r"

_end:
	.space (448*1024-(_end-_start)), 0x62
