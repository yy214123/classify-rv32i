.globl dot
.data
Table:
    .byte 0xFF, 0, 0xFF, 15, 0xFF, 1, 28, 0xFF,16, 0xFF, 0xFF, 0xFF, 2, 21, 29, 0xFF,0xFF, 0xFF, 19, 17, 10, 0xFF, 12, 0xFF,0xFF, 3, 0xFF, 6, 0xFF, 22, 30, 0xFF,14, 0xFF, 27, 0xFF, 0xFF, 0xFF, 20, 0xFF,18, 9, 11, 0xFF, 5, 0xFF, 0xFF, 13, 26, 0xFF, 0xFF, 8, 0xFF, 4, 0xFF, 25, 0xFF, 7, 24, 0xFF, 23, 0xFF, 31, 0xF

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
    
    # If 0 appears, jump to the next element
    lw t2, 0(a0)
    beq t2, zero, next
    lw t3, 0(a1)
    beq t3, zero, next
    
    # power of 2
    addi t4, t2, -1
    and t4, t2, t4
    beq t4, zero, call_power_of_2_t2
    
    addi t4, t3, -1
    and t4, t3, t4
    beq t4, zero, call_power_of_2_t3
    
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
    
call_power_of_2_t2:
    mv   a5, t2
    mv   a6, t3     
    j  power_of_2_bitwise

call_power_of_2_t3:
    mv   a5, t3
    mv   a6, t2     
    j  power_of_2_bitwise    

power_of_2_bitwise:
    # log a5 (Harley's algorithm)
    srli t4, a5, 1    
    or   a5, a5, t4
    srli t4, a5, 2    
    or   a5, a5, t4   
    srli t4, a5, 4    
    or   a5, a5, t4   
    srli t4, a5, 8    
    or   a5, a5, t4   
    srli t4, a5, 16   
    or   a5, a5, t4
    slli t4, a5, 3    
    sub  a5, t4, a5   
    slli t4, a5, 8    
    sub  a5, t4, a5   
    slli t4, a5, 8    
    sub  a5, t4, a5   
    slli t4, a5, 8    
    sub  a5, t4, a5
    srli t4, a5, 26     
    la   t5, Table    
    add  t5, t5, t4   
    lb  a5, 0(t5)

    sll  a6, a6, a5
    add t0, t0, a6
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
