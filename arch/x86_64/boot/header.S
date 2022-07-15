// load at 0x1000:0x0000, 448KB
	.section .text
_start:
_end:
	.space (448*1024-(_end-_start)), 0x62
