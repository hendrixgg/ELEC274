.text
.global _start
.org    0x0000

_start:                         # == INITIALIZATION ==
    ldw     r2, N(r0)           # r2 contains the number of elements in the list.
    slli    r2, r2, 2           # left shift by 2 (multiply by 4) so that r2 
                                #   is the number of bytes the list takes up.
    addi    r2, r2, LIST        # r2 is now pointing to one after the last 
                                #   element in LIST.
    movi    r3, LIST            # r3 points to the first element in LIST.
    movi    r4, 0               # r4 accumulates the sum.
LOOP:
    ldw     r5, 0(r3)           # Got next element from LIST.
    add     r4, r4, r5          # Add element to accumulating sum in r4.
    addi    r3, r3, 4           # Advance the LIST pointer.
    bne     r3, r2, LOOP        # Branch if not at end of list.

    stw     r4, SUM(r0)         # Write final accumulated value to memory.
_end:
    br      _end

#------------------------------------------------------------------------------#

        .org    0x1000
SUM:    .skip   4               # Reserve 4 bytes of space for the final sum.
N:      .word   5               # Indicate that there are N=5 items in LIST.
LIST:   .word   12, 0xFFFFFFFE, 7, -1, 2    # Hex value is -2 in two's-complement. 

        .end
