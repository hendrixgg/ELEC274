.text
.global _start
.org    0x0000

_start:
# Write initial instructions here.
IF:
    ldw     r2, A(r0)       # Read value of A from memory.
    bne     r2, r0, ELSE    # Branch to ELSE task if A not equal 0.
THEN:                       # Optional label; marks the start of the Then block.
    movi    r3, 1           # The Then task (for when A equals 0)
    stw     r2, B(r0)       #   which sets B to 1.
    br      END_IF          # Skip Else task and go to the end of If.
ELSE:
    movi    r3, 2           # The Else task (for when A not equal 0)
    stw     r3, C(r0)       #   which sets C to 2.
END_IF:
# Put subsequent instructions here.

_end:
    br _end
#------------------------------------------------------------------------------#

        .org    0x1000
# Write constants and variables here.


