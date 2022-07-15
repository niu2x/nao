	.macro push_regs
	push %bx
	push %cx
	push %dx
	push %di
	.endm

	.macro pop_regs
	pop %di
	pop %dx
	pop %cx
	pop %bx
	.endm
