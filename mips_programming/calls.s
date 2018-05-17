# calls.s
# 
# A MIPS program that implements the following C code:
#
#
#int bar(int x, int y) {
#    return x & y;
#}
#
#int foo(int x) {
#    int tmp = bar(x-1, 10);
#    return tmp + x;
#}
#
#void main() {
#    foo(7); // should return 9
#}
#
# Authors: Eugene Prokopenko, Alexandra Leonidova





.text
main:
	la $a0, 7  # set first argument as pointer to 7
	jal foo # call foo function

	add $t1, $zero, $v0 #put return value into t1 (this should be 9)
	
	# the following instructions will call exit to terminate the program
	li $v0, 10
	syscall

foo:

	
	addi $sp, $sp, -8 # make space on stack to store $a0 and $ra registers
	sw $ra, 4($sp) # save $r0 register on stack
	sw $a0, 0($sp) # save $a0 (x parameter) on stack
	subi $a0, $a0, 1 # decrement $a0 by 1 so as to serve as first parameter to bar
	addi $a1, $zero, 10 #add 10 into a1, the second parameter to bar function
	jal bar # call the bar function
	lw $t0, 0($sp) # load x parameter from stack into temporary register $t0
	add $v0, $v0, $t0 # return tmp + x (set return register $v0 to the return value of bar + x parameter) 
	
	lw $ra, 4($sp) # restore $ra values

	addi $sp, $sp, 8 # deallocate stack space
	jr $ra # return to caller
	

bar:
	and $v0, $a0, $a1 # return x & y;
	jr $ra # return to caller
	




	
