# select.s
# 
# A MIPS program that implements the QuickSelect algorithm
#
# Authors: Eugene Prokopenko and Alexandra Leonidova

.globl main

.data
arr_len:
	.word 7   # length of our array is 7
arr:
	.word 7 5 3 4 1 2 6   # define contents of our array

user_prompt:
	.asciiz "\nEnter n (integer between 1 and 7, inclusive):\n" 

invalid_input_message:
	.asciiz "\nInvalid input. Must be integer between 1 and 7, inclusive. Exiting.\n" 

.text
main:


	
	# prompt user to input n 
	li $v0, 4 # system call code for printing string = 4
	la $a0, user_prompt # load address of string to be printed into $a0
	syscall # call operating system to perform operation

	li   $v0, 5       # system call for reading integer is 5
  	syscall            # Read Int
  	
  	
  	subi $v0, $v0, 1    # subtract 1 from user input to make $v0 hold index value
	add $a3, $zero, $v0 # add "user input - 1" into fourth parameter to "select" function (n, pivot)
	
	slti $t1, $a3, 0  #make sure user input is not smaller than 1 
	bne $t1, $zero, invalidinput
	
	#make sure user input is not larger than 7
	la $t0, arr_len  # get address where arr_len is stored
	lw $a2, 0($t0)  # set 3nd arg as array length...
	slt $t1, $a3, $a2, #make sure user input is not larger than 7 - $a2 holds arr_len value
	beq $t1, $zero, invalidinput



	la $a0, arr  # set first argument as pointer to arr
	la $t0, arr_len  # get address where arr_len is stored
	li $a1, 0  # 2nd arg is 0
	lw $a2, 0($t0)  # set 3nd arg as array length...
	addi $a2, $a2, -1  # ... - 1
	#li $a3, 2  # set 4th arg (i.e. n) to 2 to get 3rd smallest

	
	# extra credit opportunity: allow the user to input value of n 
	#	to be used when calling select
	

	jal select  # call select function
	
	add $a0, $v0, $zero #add return value to a0, so that it will be printed

	li $v0, 1 #service 1 is print integer
    	syscall # print(x);
    		
	# the follow instructions will call exit to terminate the program
	li $v0, 10
	syscall

partition:

	# get the value at the pivot
	sll $t0, $a3, 2  # calculate offset for arr[pivot]
	add $t0, $t0, $a0  # t0 == &arr[pivot]
	lw $t1, 0($t0)   # pivot_val (i.e. t1) = arr[pivot]
	
	# move pivot to end
	sll $t2, $a2, 2  # calculate offset for arr[right]
	add $t2, $t2, $a0 # t2 = &arr[right]
	lw $t3, 0($t2)  # t3 = arr[right]
	sw $t3, 0($t0)  # arr[pivot] = arr[right]
	sw $t1, 0($t2)  # arr[right] = orig value of arr[pivot]
	
	# move t1 to t8 because we use t1 later
	add $t8, $t1, $zero # $t8 holds pivot value now

	move $v0, $a1  # store_index (i.e. t0 ) = left
	
	# TODO: complete code for partition (from for loop to the end)
	add $t4, $zero, $a1 # i = left, i is located in t4
	
        sll $t6, $t4, 2 #calculate offset for arr[i]
        add $t6, $t6, $a0 #t6 = &arr[i]
        lw $t7, 0($t6) #t7 stores arr[i]

loop:
	slt $t5, $t4, $a2 # i < right, then t5 is 1
	beq $t5, $zero, move_pivot # i < right?
	
	#if statement
	slt $t5, $t7, $t8 # if arr[i] < pivot_val, t5 == 1
        beq $t5, $zero, increment # arr[i] < pivot_val? if not, then increment and go back to for-loop
	
	#body of if statement
	sll $t0, $v0, 2  # calculate offset for arr[store_index] (tmp)
        add $t0, $t0, $a0  # t0 == &arr[store_index]
        lw $t1, 0($t0) #t1 stores arr[store_index]
	sw $t7, 0($t0) # arr[store_index] = arr[i]
	sw $t1, 0($t6) # arr[i] = orig value off arr[store_index] (temp)
	
	addi $v0, $v0, 1 #store_index++
	addi $t0, $t0, 4 #point to next elements of arr[store_index]
increment:
	addi $t4, $t4, 1 #i++
	addi $t6, $t6, 4 #point to the next element of arr[i] 
	lw $t7, 0($t6) #t7 stores new arr[i]
	j loop

move_pivot:
        
        lw $t9, 0($t2) #tmp = arr[right], tmp stored in t9
        #new code
	sll $t0, $v0, 2  # calculate offset for arr[store_index] (tmp)
        add $t0, $t0, $a0  # t0 == &arr[store_index]
        #end new code
        lw $t1, 0($t0) # load value of arr[store_index] to t1
        sw $t1, 0($t2) # arr[right]  = arr[store_index], arr[store_index] 
        sw $t9, 0($t0) # arr[store_index] = orig value off arr[right] (temp)	

	jr $ra
	
select:
	addi $sp, $sp, -4 # make room on stack for one int 
	sw $ra, 0($sp) # store return address on stack

	# if (left == right) return arr[left]
	bne $a1, $a2, notdone #othervise, execude the body of select method
	sll $t0, $a1, 2  # calculate offset for a[left]
	add $t0, $t0, $a0  # t0 = &arr[left]
	lw $v0, 0($t0)  # set return val to arr[left]
	jr $ra
	
notdone:
	add $t0, $a1, $a2 # t0 = left + right
	sra $t0, $t0, 1   # pivot_index point (t0) = average (left, right)
	
	# TODO: Finish implementation of select function
	addi $sp, $sp, -8 # make room on stack for two int 
	sw $a3, 4($sp) # save n(a3) on the stack
	sw $ra, 0($sp) # save return address ($ra) on stack
	add $a3, $t0, $zero # overright 4th argument(a3) with pivot_index(t0)before partition function call
	jal partition # call partition function
	add $t0, $v0, $zero #store its return value in pivot_index(t0)
	lw $ra, 0($sp) #restore return address
	lw $a3, 4($sp) #restore n
	addi $sp, $sp, 8 #restore stack pointer sp
	
	bne $a3, $t0, select_elsif
        sll $t1, $a3, 2  # calculate offset for arr[n]
	add $t1, $t1, $a0  # t1 == &arr[n]
        lw $v0, 0($t1)   # set return value as arr[n]
	j select_return
select_elsif:
	slt $t2, $a3, $t0 # if n < pivot_index, t2 = 1
	beq $t2, $zero, select_else
	#return select(arr, left, pivot_index - 1, n);
	addi $t0, $t0, -1 # pivot_index--
	add $a2, $t0, $zero #third argument is pivot_index - 1
	jal select #make a recursive call
	lw $ra, 0($sp) #restore return address (ra)
	addi $sp, $sp, 4 #restore stack pointer (sp)
	j select_return 
select_else:
	#return select(arr, pivot_index + 1, right, n);
	addi $t0, $t0, 1 #pivot_index++
	add $a1, $t0, $zero #store pivot + 1 as a second argument
	jal select #make a recursive call
	lw $ra, 0($sp) #restore return address (ra)
	addi $sp, $sp, 4 #restore stack pointer (sp)
	j select_return #go to select_retrn portion that returns from the method
select_return:	
	jr $ra

invalidinput:

	# prompt user to input n 
	li $v0, 4 # system call code for printing string = 4
	la $a0, invalid_input_message # load address of string to be printed into $a0
	syscall # call operating system to perform operation
	
	# the follow instructions will call exit to terminate the program
	li $v0, 10
	syscall







