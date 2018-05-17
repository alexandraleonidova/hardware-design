# unit8.asm
# test of LW -> SW dependency (forwarding, no stallling)
addi $2, $0, 7 #store 7 at R[2]
sw $2, 80($0)   # Mem[80] = R[2] = 7
lw $1, 80($0)   # R[1] = Mem[80]
sw $1, 84($0)   # Mem[84] = R[1] = Mem[80]
# nops to avoid fetching illegal instructions
add $0, $0, $0
add $0, $0, $0
add $0, $0, $0
add $0, $0, $0
add $0, $0, $0

