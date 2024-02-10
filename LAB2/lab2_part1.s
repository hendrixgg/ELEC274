.equ STACK_PT_START,     0x7FFFFC

.text
.global _start
.org    0x0000

# Write initial instructions here.
_start:
    movia   sp, STACK_PT_START
    # Put arguments into registers r2 - r6.
    movia   r2, LIST1
    movia   r3, LIST2
    movia   r4, N
    ldw     r4, 0(r4)
    movia   r5, UPPER
    ldw     r5, 0(r5)
    movia   r6, F
    ldw     r6, 0(r6)
    # Call list_compute sub-routine.
    call    list_compute
    # Store return value in memory location RESULT.
    stw     r2, RESULT(r0)
_end:
    break
#------------------------------------------------------------------------------#

# input: r2, r3, n = r4, upper = r5, f = r6
# save/restore: r3, r4, count = r7, temp_val = r8,
# return: r2
list_compute:
    subi    sp, sp, 16
    stw     r3, 0(sp)
    stw     r4, 4(sp)
    stw     r7, 8(sp)
    stw     r8, 12(sp)
    # Initialize the count.
    movi    r7, 0
    lc_loop:
        # Load element from list x.
        ldw r8, 0(r2)
        lc_loop_if:
            bgt     r8, r5, lc_loop_else
        lc_loop_then:
            # *y = f * (*x) - 3
            mul     r8, r6, r8
            subi    r8, r8, 3
            stw     r8, 0(r3)
            br      lc_loop_end_if
        lc_loop_else:
            # *y = 0
            stw     r0, 0(r3)
            # *x = upper
            stw     r5, 0(r2)
            # count = count + 1
            addi    r7, r7, 1
        lc_loop_end_if:
        # Increment x and y pointers by one word each.
        addi    r2, r2, 4
        addi    r3, r3, 4
        # Decrement the loop counter.
        subi    r4, r4, 1
        # Continue looping if n > 0.
        bgt     r4, r0, lc_loop

    # Store value of count (r7) into r2 for return value.
    mov     r2, r7
    # Restore overwritten registers.
    ldw     r3, 0(sp)
    ldw     r4, 4(sp)
    ldw     r7, 8(sp)
    ldw     r8, 12(sp)
    addi    sp, sp, 16
    
    ret



#------------------------------------------------------------------------------#

.org    0x1000
# Write constants and variables here.
N:      .word   3
LIST1:  .word   1, 3, 5
LIST2:  .word   -1, -1, -1
UPPER:  .word   5
F:      .word   2
RESULT: .skip   4
.end
    
