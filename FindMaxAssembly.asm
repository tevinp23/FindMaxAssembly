.globl main

.data
      array: .space 400 
      max: .space 4

.text
main:
	# Tests simple looping behaviour
	li t0, 101 #if left at 100 it'll branch at 100 instead of adding 100
	li t1, 0
	la t2, max
	la t3, array 
generate:
	beq t1, t0, reset
	li a0, 0  # for random number seed
	li a1, 100 # range of random number
	li a7, 42 # rand code
	ecall # call random number generator to generate a random number stored in a0
	slli t4, t1, 4 #calculate the offset
	add t4, t3, t4 #calculate the current memory address
	sw a0, 0(t4)#store random into array at specific point in memory
	addi t1, t1, 1 # i++
	j generate
	
reset: 
	li t1, 0 #reset to 0 to reuse
	lw t6, 0(t3) # load the first element into t6
maximum: 
	beq t1, t0, success
	slli t4, t1, 4 #calculate the offset
	add t4, t3, t4 #calculate the current memory address3
	lw t5, 0(t4) #load the number at t4 into t5
	blt t5, t6, notmax
	add t6, x0, t5 #t6 is equal to the max number
notmax: 
	addi t1, t1, 1# i++
	j maximum
failure:
	li a0, 0
	li a7, 93 
	ecall
success:
	sw t6, 0(t2) # store t6 into t2
	lw a0, 0(t2) #print t2
	li a7, 1 
	ecall
	li a7, 10 #got rid of the dropped off bottom by issuing an explict exit
	ecall
	
