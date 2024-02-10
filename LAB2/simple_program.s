.text
.global _start
.org    0x0000

_start:
    movia   sp, 0x7FFFFC    # Initialize stack pointer.
    # average = calculate_average(list_begin, list_end, number_of_elements)
    movia   r2, LIST        # r2 stores the list_begin.
    movia   r4, N           # Could just do ldw r4, N(r0) since N fits in 16 bits as ensured by the .org directive below.
    ldw     r4, 0(r4)       # r4 stores the number of elements in list.
    slli    r4, r4, 2           # r4 stores the number of bytes in list.
    add     r3, r2, r4      # r3 stores the list_end.
    srli    r4, r4, 2           # r4 stores the number of elements in list.
    call    calculate_average # r2 stores the average.
    movia   r5, AVERAGE     # Could just be doing stw r2, AVERAGE(r0) since AVERAGE fits in 16 bits as ensured by the .org directive below.
    stw     r2, 0(r5)       # Store the output of calculate_average in memory.
    # n_less_than = count_less_than(list_begin, list_end, average)
    mov     r4, r2          # r4 stores the average.
    movia   r2, LIST        # r2 stores the list_begin.
    call    count_less_than # r2 stores the number of elements less than average.
    movia   r3, N_LT        # Could just do stw r2, N_LT(r0) since the .org below ensures the actual value of N_LT to fit in 16 bits.
    stw     r2, 0(r3)       # Store number of elements less than average in memory.
    # n_not_less_than = n - n_less_than
    movia   r4, N
    ldw     r4, 0(r4)       # r4 is number of elements in the list.
    sub     r2, r4, r2      # r2 is number of elements not less than average.
    movia   r3, N_NOT_LT    
    stw     r2, 0(r3)       # Store number of elements not less than average in memory.
_end:
    break

#------------------------------------------------------------------------------#

# Assume:
    # list_begin < list_end so that there is at least one element.
    # each list_element is a number represented as an unsigned integer.
    # number of elements > 0. for division by zero error.
# r2: list_begin; r3: list_end; r4: number of elements; 
# r2: return value (average);
calculate_average:
    # r3 is not changed.
    # Save overwritten registers: r4, r5
    subi    sp, sp, 8
    stw     r4, 0(sp)   # original num_elems
    stw     r5, 4(sp)   # used for local sum

    mov     r5, r0      # r5 stores the sum.
    calculate_average_loop:
        ldw     r4, 0(r2)   # r4 stores the current element.
        add     r5, r5, r4  # Add element to the sum.
        addi    r2, r2, 4   # Increment list pointer by one word.
        bne     r2, r3, calculate_average_loop # Loop if not at end.

    ldw     r4, 0(sp)   # r4 stores the number of elements.
    divu    r2, r5, r4  # r2 stores the average. divu since integers are non-negative.
    # Restore overwritten register.
    ldw     r5, 4(sp)
    addi    sp, sp, 8
    ret

#------------------------------------------------------------------------------#
# Assume:
    # list_begin < list_end so that there is at least one element.
    # each list_element is a number represented as an unsigned integer.
# r2: list_begin; r3: list_end; r4: compare_value;
# r2: return value (count_less_than compare_value);
count_less_than:
    # r3, r4 are not changed.
    # Save overwritten registers: r5
    subi    sp, sp, 8
    stw     r5, 0(sp)   # count_less_than
    stw     r6, 4(sp)   # current element, and comparison result.
    
    mov     r5, r0  # r5 stores the count_less_than
    count_less_than_loop:
        ldw     r6, 0(r2)
        cmpltu  r6, r6, r4  # less_than = list[i] < compare_value, cmpltu since unsigned.
        add     r5, r5, r6  # count = count + less_than
        addi    r2, r2, 4   # Increment list_begin.
        bne     r2, r3, count_less_than_loop
    
    mov     r2, r5  # r2 stores the return value.
    # Restore overwritten registers.
    ldw      r5, 0(sp)
    ldw      r6, 4(sp)
    addi     sp, sp, 8
    ret



#------------------------------------------------------------------------------#

            .org    0x1000
# Write constants and variables here.
N:          .word   6       # Number of items in LIST.
LIST:       .word   44, 52, 67, 74, 82, 93 # Defining elements in LIST.
AVERAGE:    .skip   4       # Reserve one word for average of list elements.
N_LT:       .skip   4       # Reserve one word for number of elements less than average
N_NOT_LT:   .skip   4       # Reserve one word for number of elements not less than average.

.end
