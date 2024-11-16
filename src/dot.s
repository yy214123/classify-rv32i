.globl dot

.text
# =======================================================
# FUNCTION: Strided Dot Product Calculator
#
# Calculates sum(arr0[i * stride0] * arr1[i * stride1])
# where i ranges from 0 to (element_count - 1)
#
# Args:
#   a0 (int *): Pointer to first input array
#   a1 (int *): Pointer to second input array
#   a2 (int):   Number of elements to process
#   a3 (int):   Skip distance in first array
#   a4 (int):   Skip distance in second array
#
# Returns:
#   a0 (int):   Resulting dot product value
#
# Preconditions:
#   - Element count must be positive (>= 1)
#   - Both strides must be positive (>= 1)
#
# Error Handling:
#   - Exits with code 36 if element count < 1
#   - Exits with code 37 if any stride < 1
# =======================================================
dot:
    li t0, 1
    blt a2, t0, error_terminate  
    blt a3, t0, error_terminate   
    blt a4, t0, error_terminate  

    li t0, 0            
    li t1, 0         

loop_start:
    bge t1, a2, loop_end
    # TODO: Add your own implementation
    lw t2, 0(a0)
    lw t3, 0(a1)
    
    srli t4, t2, 31
    srli t5, t3, 31
    bne t4, t5, decrement_cumulatively
accumulate:
    srai t4, t2, 31
    xor t2 ,t2 ,t4
    sub t2, t2, t4
    
    srai t5, t3, 31
    xor t3 ,t3 ,t5
    sub t3, t3, t5
    
    add t0,t0,t2
    addi t3, t3, -1
    bne t3, zero, accumulate
    j next
decrement_cumulatively:
    srai t4, t2, 31
    xor t2 ,t2 ,t4
    sub t2, t2, t4
    
    srai t5, t3, 31
    xor t3 ,t3 ,t5
    sub t3, t3, t5
    
    sub t0,t0,t2
    addi t3, t3, -1
    bne t3, zero, decrement_cumulatively
    j next
next:    
    slli t3, a3, 2
    add a0, a0, t3
    slli t3, a4, 2
    add a1, a1, t3
    
    addi t1, t1, 1
    j loop_start
    
loop_end:
    mv a0, t0
    jr ra

error_terminate:
    blt a2, t0, set_error_36
    li a0, 37
    j exit

set_error_36:
    li a0, 36
    j exit
