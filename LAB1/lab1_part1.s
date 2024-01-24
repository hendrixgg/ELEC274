.text
.global _start
.org 	0x0000

_start:
		#	C = (F + N) / K
		ldw		r2, F(r0)
		ldw		r3, N(r0)
		add		r2, r2, r3
		ldw		r3, K(r0)
		div		r2, r2, r3
		stw		r2, C(r0)

		#	J = C * N
		# already have C in r2
		ldw		r3, N(r0)
		mul		r2, r2, r3
		stw		r2, J(r0)

		#	S = B + 4 - A
		ldw		r2, B(r0)
		addi	r2, r2, 4
		ldw		r3, A(r0)
		sub		r2, r2, r3
		stw		r2, S(r0)

_end:
		br 		_end
#-------------------------------------------------------------------------------#

		.org 	0x1000
# constants
A:		.word 	1
B:		.word 	2
F: 		.word 	3
K:		.word	4
N:		.word	5
# results
C: 		.skip 	4
J: 		.skip	4
S:		.skip 	4
