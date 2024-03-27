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

    # Print "Lab 4\n".
    movia   r2, TEXT
    call    PrintString
    
    # Call function.
    movia   r3, N
    ldw     r3, 0(r3)
    movia   r2, LIST
    call    EchoForce
_end:
    break


#------------------------------------------------------------------------------#

# Lab 4 Function
# Assumption: r2 contains a pointer to a list of bytes, 
    # r3 contains the length of the list [r3] > 0.
EchoForce:
    subi    sp, sp, 20
    stw     ra, 16(sp)
    stw     r5, 12(sp)
    stw     r4, 8(sp)
    stw     r3, 4(sp)
    stw     r2, 0(sp)

    # Move the list to r4 since we will need r2 for function calls.
    mov     r4, r2
ef_loop:
    ldbu    r2, 0(r4)   # Get list element in r2 so we can print it with PrintHexByte.
    call    PrintHexByte
    movi    r2, ' '
    call    PrintChar
    call    GetChar
    call    PrintChar
    mov     r5, r2
    movi    r2, '\n'
    call    PrintChar
    mov     r2, r5
ef_if:
    movi    r5, 'z'
    bne     r2, r5, ef_else_if
# If character input was 'z', then set the value in the list to zero.
ef_then:
    stb     r0, 0(r4)
    br      ef_end_if
ef_else_if:
    movi    r5, 'f'
    bne     r2, r5, ef_end_if
# If character input was 'f', then set the value in the list to 0xFF.
ef_else_then:
    movi    r2, 0xFF
    stb     r2, 0(r4)
ef_end_if:
    subi    r3, r3, 1
    addi    r4, r4, 1
    bgt     r3, r0, ef_loop
ef_end_loop:


    ldw     ra, 16(sp)
    ldw     r5, 12(sp)
    ldw     r4, 8(sp)
    ldw     r3, 4(sp)
    ldw     r2, 0(sp)
    addi    sp, sp, 20
    
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

# Assumption: r2 will contain the return value of the function.
GetChar:
    subi    sp, sp, 8
    stw     r4, 4(sp)   # Save value to store the status bit from DATA register.
    stw     r3, 0(sp)   # Save value to store pointer to I/O register.

    movia   r3, JTAG_UART_BASE      # Point to first memory-mapped I/O register.
gc_loop:
    ldwio   r2, DATA_OFFSET(r3)     # Status information in bit 15.
    andi    r4, r2, 0x8000          # Extract bit 15 to check it's value.
    beq     r4, r0, gc_loop         # If value is zero, continue polling.

    andi    r2, r2, 0xFF            # Otherwise, prepare return value from bits 7..0.
    
    ldw     r4, 4(sp)
    ldw     r3, 0(sp)
    addi    sp, sp, 8

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
N:      .word   6
LIST:   .byte   0x11, 0x22, 0x33, 0x44, 0x55, 0x66
TEXT:   .asciz  "Lab 4\n"

.end

