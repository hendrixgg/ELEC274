.equ STACK_PT_START,    0x7FFFFC

.text
.global _start
.org    0x0000

# Write initial instructions here.
_start:
    movia   sp, STACK_PT_START  # Initialize the stack pointer

_end:
    break
#------------------------------------------------------------------------------#

.org    0x1000
# Write constants and variables here.

.end
