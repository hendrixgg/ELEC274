.equ    JTAG_UART_BASE,     0x10001000  # Address of first JTAG UART register.
.equ    DATA_OFFSET,        0           # Offset of JTAG UART data register.
.equ    STATUS_OFFSET,      4           # offset of JTAG UART status register.
.equ    WSPACE_MASK,        0xFFFF      # Used in AND operation to check status.
.equ    STACK_PT_START,     0x7FFFFC

.text
.global _start
.org    0x0000

_start:
    # main routine
    movia   sp, STACK_PT_START

    movia   r2, TEXT
    call    PrintString

    movia   r2, LIST
    ldw     r3, N(r0)

    call    ShowByteList
    call    ShowByteList
    
_end:
    break


#------------------------------------------------------------------------------#

# Assumption: r2 is a pointer to at least one element, r3 contains n > 0.
ShowByteList:
    subi    sp, sp, 16
    stw     r4, 12(sp)
    stw     ra, 8(sp)
    stw     r3, 4(sp)
    stw     r2, 0(sp)
    
    mov     r4, r2  # r4 now contains the pointer to the list.
sbl_loop:
    movi    r2, '('
    call    PrintChar
    ldbu    r2, 0(r4)
sbl_if:
    bne     r2, r0, sbl_else
sbl_then:
    movi    r2, '-'
    call    PrintChar
    call    PrintChar
    br      sbl_end_if
sbl_else:
    call    PrintHexByte
sbl_end_if:
    movi    r2, ')'
    call    PrintChar
    movi    r2, ' '
    call    PrintChar
    
    addi    r4, r4, 1
    subi    r3, r3, 1
    bgt     r3, r0, sbl_loop

    movi    r2, '\n'
    call    PrintChar

    ldw     r4, 12(sp)
    ldw     ra, 8(sp)
    ldw     r3, 4(sp)
    ldw     r2, 0(sp)
    addi    sp, sp, 16

    ret

#------------------------------------------------------------------------------#

# Assumption: 0 <= [r2] <= 255 or a single hex byte.
PrintHexByte:
    subi    sp, sp, 12
    stw     ra, 8(sp)
    stw     r3, 4(sp)
    stw     r2, 0(sp)
    
    mov     r3, r2
    srli    r2, r3, 4
    call    PrintHexDigit
    andi    r2, r3, 0xF
    call    PrintHexDigit
    
    ldw     r2, 0(sp)
    ldw     r3, 4(sp)
    ldw     ra, 8(sp)
    addi    sp, sp, 12

    ret
#------------------------------------------------------------------------------#

# Assumption: 0 <= [r2] <= 15 or is a single hex digit.
PrintHexDigit:
    subi    sp, sp, 12
    stw     ra, 8(sp)
    stw     r3, 4(sp)
    stw     r2, 0(sp)

    mov     r3, r2
phd_if:
    movi    r2, 9
    ble     r3, r2, phd_else
phd_then:
    subi    r2, r3, 10
    addi    r2, r2, 'A'
    br      phd_end_if
phd_else:
    addi    r2, r3, '0'
phd_end_if:
    call PrintChar

    ldw     r2, 0(sp)
    ldw     r3, 4(sp)
    ldw     ra, 8(sp)
    addi    sp, sp, 12
    ret

#------------------------------------------------------------------------------#

# Assumption: r2 contains a pointer to a null-terminated ascii string.
PrintString:
    subi    sp, sp, 12
    stw     ra, 8(sp)   # There is a nested call to PrintChar.
    stw     r3, 4(sp)
    stw     r2, 0(sp)
    
    mov     r3, r2      # Store the string pointer in r3 since r2 is used for
                            # the argument to PrintChar.
ps_loop:
    ldb     r2, 0(r3)
    beq     r2, r0, ps_end_loop
    call    PrintChar
    addi    r3, r3, 1
    br      ps_loop
ps_end_loop:
    
    ldw     ra, 8(sp)
    ldw     r3, 4(sp)
    ldw     r2, 0(sp)
    addi    sp, sp, 12

    ret

#------------------------------------------------------------------------------#
    
# Assumption: r2 contains an ascii character value.
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
N:      .word   4
LIST:   .byte   0x2C, 0x0, 0xF4, 0x75
TEXT:   .asciz  "Lab 3\n"


.end


