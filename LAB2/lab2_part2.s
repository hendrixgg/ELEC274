.equ    JTAG_UART_BASE,     0x10001000  # Address of first JTAG UART register.
.equ    DATA_OFFSET,        0           # Offset of JTAG UART data register.
.equ    STATUS_OFFSET,      4           # offset of JTAG UART status register.
.equ    WSPACE_MASK,        0xFFFF      # Used in AND operation to check status.
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
    
    # Summarize lists.
    movia   r2, '\n'
    call    PrintChar

    movia   r3, N
    ldw     r3, 0(r3)
    movia   r2, LIST1
    call    summarize_list
    movia   r2, '\n'
    call    PrintChar
    movia   r2, LIST2
    call    summarize_list
    movia   r2, '\n'
    call    PrintChar

_end:
    break
#------------------------------------------------------------------------------#

# input: x = r2, y = r3, n = r4, upper = r5, f = r6
# save/restore: r3, r4, count = r7, temp_val = r8,
# return: r2
# Assume that there is at least one element in each list and that n > 0.
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

# inputs: list = r2, n = r3
# save/restore: printchar = r2, r3, list -> r4, list[i] = r5
# return: none
# Assume that there is at least one element in the list and that n > 0.
summarize_list:
    subi    sp, sp, 20 # reserve extra space for link register (ra).
    stw     r2, 0(sp)
    stw     r3, 4(sp)
    stw     r4, 8(sp)
    stw     r5, 12(sp)
    stw     ra, 16(sp) # Doing a nested call, so saving the register ra on the stack.
    
    # Store the list pointer in r4 since we are using r2 to call PrintChar.
    mov     r4, r2
    sl_loop:
        # Load element from list.
        ldw     r5, 0(r4)
        sl_loop_if:
            bge     r5, r0, sl_loop_else_if
        sl_loop_then1: # if list[i] < 0
            movi    r2, '-'
            br      sl_loop_end_if
        sl_loop_else_if: 
            bgt     r5, r0, sl_loop_else
            br      sl_loop_end_if
        sl_loop_then2: # else if list[i] == 0
            movi    r2, '0'
            br      sl_loop_end_if
        sl_loop_else: # list[i] > 0
            movi    r2, '+'
        sl_loop_end_if:
        call    PrintChar # print the character in r2
        
        # Increment the list pointer by one word.
        addi    r4, r4, 4
        # Decrement the loop counter.
        subi    r3, r3, 1
        bgt     r3, r0, sl_loop
        
    ldw     r2, 0(sp)
    ldw     r3, 4(sp)
    ldw     r4, 8(sp)
    ldw     r5, 12(sp)
    ldw     ra, 16(sp)
    addi    sp, sp, 20 
    
    ret
#------------------------------------------------------------------------------#

PrintChar:
    subi    sp, sp, 8       # Adjust stack pointer down to reserve space.
    stw     r3, 4(sp)       # Save value of register r3 so it can be a temp.
    stw     r4, 0(sp)       # Save value of register r4 so it can be a temp.
    movia   r3, JTAG_UART_BASE      # Point to first memory-mapped I/O register.
pc_loop:
    ldwio   r4, STATUS_OFFSET(r3)   # Read bits from status register.
    andhi   r4, r4, WSPACE_MASK     # Mask off lower bits to isolate upper bits.
    beq     r4, r0, pc_loop         # If upper bits are zero, loop again.
    stwio   r2, DATA_OFFSET(r3)     # Otherwise, write character to data register.
    ldw     r3, 4(sp)       # Restore value of r3 from the stack.
    ldw     r4, 0(sp)       # Restore value of r4 from the stack.
    addi    sp, sp, 8       # Readjust stack pointer up to deallocate space.
    ret                     # return to calling routine.

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
    
