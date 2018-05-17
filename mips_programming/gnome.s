# gnome.s
# 
# A MIPS program that implements the Gnome Sort algorithm
#
# Authors: Eugine Prokopenko and Alexandra Leonidova

.globl main

.data
arr_len:
        .word 7   # length of our array is 7
arr:
        .word 20 52 8 17 25 3 20   # define contents of our array

.text
main:
        la $a0, arr # set first argument as pointer to arr
        la $t0, arr_len # get address where arr_len is stored
        jal gnome_sort # call gnome sort

        # the following instructions will call exit to terminate the program
        li $v0, 10
        syscall


gnome_sort:
        lw $a1, 0($t0) # set 2nd arg as array length
        addi $t0, $zero, 1  # initialize pos (stored in $t0) to 1
loop:
        slt $t1, $t0, $a1  # t1 == 1 iff pos < len
        beq $t1, $zero, done  # if t1 == 0, that means pos >= len, so we're done

        #body of while loop
        lw $t3, 0($a0) #t3 stores a[pos-1]
        lw $t4, 4($a0) #t4 stores a[pos]
        slt $t2, $t4, $t3 #t2 == 1 if a[pos] < a[pos-1]=> go to else, t2 == 0 if a[pos] >= a[pos-1]
        addi $t6, $zero, 1 # t6 holds 1 for if comparison
        beq $t2, $t6, else # if t2 != 0, the condition wasnt satisfyed => go to else
        #body of first if
        addi $t0, $t0, 1 #pos++
        addi $a0, $a0, 4 #increment the pointer to array arr so thet it points to the next element 
        j loop
else:
        add $t5, $t4, $zero  # int tmp = a[pos], tmp stored at t5
        add $t4, $t3, $zero  # a[pos] = a[pos-1]
        add $t3, $t5, $zero  # a[pos-1] = tmp
        sw $t3, 0($a0) #save new value of a[pos-1]
        sw $t4, 4($a0) #save new value of a[pos] 
        addi $t6, $zero, 1 # t6 holds 1 for if comparison
        slt $t7, $t6, $t0 # t7 == 1 if 1 < pos
        beq $t7 $zero loop #go back to beginning of loop if pos <= 1
        addi $t0, $t0, -1 #pos--
        addi $a0, $a0, -4 #decrement the pointer to array arr so thet it points to the next element 
        j loop

done:
        jr $ra # return to caller (i.e. done with function)
