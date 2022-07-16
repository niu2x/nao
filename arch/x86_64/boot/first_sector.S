	.section .text
	.code16

	.include "utils.h"
// load at 0x7c00
	.set origin, 0x7c00
	.set header_sector, 2047
	.set header_origin_seg, 0x1000
_start:	
// zero segs
	xor %ax, %ax
	mov %ax, %ds
	mov %ax, %fs
	mov %ax, %ss
	mov %ax, %es
// set stack to 0x00000500-0x00007BFF
	mov $0x7C00, %sp
	mov $0x7C00, %bp

	mov $(_msg4-_start)+origin, %ax
	call _puts

	mov $0x00, %ah
	mov $0x80, %dl
	int $0x13
	jc _error

	mov $(_msg3-_start)+origin, %ax
	call _puts

	mov $0x41, %ah
	mov $0x80, %dl
	mov $0x55AA, %bx
	int $0x13
	jc _error

	mov $(_msg1-_start)+origin, %ax
	call _puts

	mov $7, %cx
read_finish_loop:
	cmp $0, %cx
	je read_finish
	dec %cx
	mov $0x42, %ah
	mov $0x80, %dl
	mov $(_dapack-_start)+origin, %si
	int $0x13
	jc _error

	mov $(_dapack-_start)+origin, %si
	mov 6(%si), %ax
	add $0x1000, %ax
	mov %ax, 6(%si)

	mov 8(%si), %ax
	add $128, %ax
	mov %ax, 8(%si)

	jmp read_finish_loop
read_finish:
	ljmp $0x1000, $0x0000

1:	hlt
	jmp 1b
_msg1:
	.asciz "[nao] load head.S\n\r"
_msg2:
	.asciz "[nao] error\n\r"
_msg3:
	.asciz "[nao] check extensions\n\r"
_msg4:
	.asciz "[nao] reset\n\r"
_msg5:
	.asciz "[nao] read finish\n\r"
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

_error:
	mov $(_msg2-_start)+origin, %ax
	call _puts
1:	hlt
	jmp 1b

// 0x00010000	0x0007FFFF
	.align 8
_dapack:
	.byte 0x10
	.byte 0x0
	.short 128
	.short 0
	.short header_origin_seg
	.short header_sector
	.short 0
	.short 0
	.short 0
_end:
