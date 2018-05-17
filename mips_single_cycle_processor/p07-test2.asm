main:
	ori  $t0, $0,  0x8000
	addi $t1, $0,  -32768
	ori  $t2, $t0, 0x8001
	bne  $t0, $t1, there
	slt  $t3, $t1, $t0
	beq  $t3, $0,  here
	j    there
here:
	sub  $t2, $t2, $t0
	ori  $t0, $t0, 0xFF
there:
	add  $t3, $t3, $t2
	sub  $t0, $t2, $t0
	sw   $t0, 82($t3)
