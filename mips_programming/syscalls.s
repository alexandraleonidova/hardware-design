Authors: Eugene Prokopenko and Alexandra Leonidova

.text
main:
    li $v0, 9 #service 9 is allocate heap memory
    addi $a0, $zero, 16 # store 16 in a0 to indicate that 16 bytes need to be allocated on a heap
    syscall #call malloc(16) # int *arr = malloc(16);
    add $t0, $v0, $zero # *arr = malloc(16), store the beginning address of allocated memory in t0
    add $t1, $zero, $zero #i = 0, i stored in t1
    addi $t2, $zero, 4 #store 4 in t2 for comparison statement in for loop
loop:
    li $v0, 41 #service 41 is random int 
    li $a0, 0 # add a seed to random number generator
    syscall # int x = rand(); value is returned into register $a0
    add $t3, $zero, $a0 # store x in a temporary register
    sw $t3, 0($t0) # arr[i] = x;
    li $v0, 34 #service 34 is print integer in hex; $a0 already contains x
    syscall # print(x);
    addi $t1, $t1, 1 # increment i
    addi $t0, $t0, 4 #increment array pointer, $t0, to next byte
    bne $t1, $t2, loop

    # the following instructions will call exit to terminate the program
    li $v0, 10
    syscall
