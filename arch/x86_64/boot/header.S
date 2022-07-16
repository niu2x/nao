// load at 0x1000:0x0000, 448KB
	
	.set header_seg, 0x1000
	.set origin, 0x0000

	.include "utils.h"
	.section .text
	.code16
	.global _start	
_start:
	mov $header_seg, %ax
	mov %ax, %ds
	mov %ax, %es
	mov %ax, %fs

	mov $(_msg1 - _start + origin), %ax
	call _puts

	jmp _enter_32

_enter_32:

	mov $(_msg2 - _start + origin), %ax
	call _puts

	cli

	call _set_A20
	lgdt _gdtp-_start

	mov %cr0, %eax 
	or $1, %al
	mov %eax, %cr0

	mov $0, %cx 
	data32 ljmp $8, $(_entry_32 - _start + header_seg*16)

	.code32
_entry_32:
	mov $16, %ax	
	mov %ax, %es
	mov %ax, %ds
	mov %ax, %fs
	mov %ax, %ss
	mov $0x7C00, %esp
	mov $0x7C00, %ebp

	mov $0xb8000, %eax

	movb $65, 2(%eax)
	movb $0xF0, 3(%eax)

	call main32
	// xor %eax, %eax
	// mov $1, %eax
	// or %eax, %eax

1:	hlt
	jmp 1b

	.code16 
_putchar:
	push_regs
	mov $0xE, %ah	
	int $0x10
	pop_regs
	ret

_wait_8042_command:
	in $0x64, %al
	test $2, %al
	jnz	_wait_8042_command
	ret

_set_A20:
    call _wait_8042_command  
    mov $0xAD, %al         
    out %al, $0x64

    call _wait_8042_command 
    mov $0xD0, %al           
    out %al, $0x64

    call _wait_8042_command   
    in  $0x60, %al           
    push %ax               

    call _wait_8042_command  
    mov     $0xD1, %al         
    out      %al, $0x64            

    call _wait_8042_command  
    pop     %ax              
    or      $2, %al
    out     %al, $0x60

    call _wait_8042_command  
    mov     $0xAE, %al        
    out     %al, $0x64

    call _wait_8042_command 
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

_msg2:
	.asciz "[nao] set a20 \n\r"

_gdtp:
	.short 23
	.long _gdt - _start + header_seg*16

_gdt:
	.byte 0,0,0,0,0,0,0,0	

	.short 0xFFFF
	.short 0
	.byte 0
	.byte 0b10011010
	.byte 0xCF
	.byte 0

	.short 0xFFFF
	.short 0
	.byte 0
	.byte 0b10010010
	.byte 0xCF
	.byte 0
