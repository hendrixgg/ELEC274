.equ	KBD_STATUS, 0x4004
.equ	KBD_DATA,	0x4000
.equ	DISP_STATUS,0x4014
.equ	DISP_DATA, 	0x4019

.text
.global _start
.org 	0x0000
_start:
	
	movia 	r2, LOC
	
	movi 	r3, '\r'
READ:
	ldb		r4, KBD_STATUS(r0)
	andi	r4, r4, 2
	beq		r4, r0, READ
	ldb		r5, KBD_DATA(r0)
	
	stb		r5, 0(r2)
	addi	r2, r2, 1
ECHO:
	ldb		r4, DISP_STATUS(r0)
	andi	r4, r4, 1
	beq		r4, r0, ECHO
	stb		r5, DISP_DATA(r0)
	
	bne		r5, r3, READ
	
break

.org 	0x1000
LOC:	.word	'a'