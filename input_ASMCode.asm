.data
x_2_main: .word 0
j_3_main: .word 0
newline: .asciiz "\n"
.text
.globl main
main:
L2: li $t0, 4
L3: sw $t0, x_2_main
L4: lw $t0, x_2_main
L5: li $t1, 1
L6: sub $s0, $t0, $t1
     bnez $s0, L11
L7: li $t1, 1
L8: addi $sp, $sp, -8
sw $a0, ($sp)
sw $v0, 4($sp)
li $v0, 1 
move $a0, $t1 
syscall
li $v0, 4
la $a0, newline
syscall
lw $a0, ($sp)
lw $v0, 4($sp)
addi $sp, $sp, 8
L9: b L23
L10: b L13
L11: li $t1, 2
L12: sub $s0, $t0, $t1
     bnez $s0, L16
L13: li $t1, 2
L14: addi $sp, $sp, -8
sw $a0, ($sp)
sw $v0, 4($sp)
li $v0, 1 
move $a0, $t1 
syscall
li $v0, 4
la $a0, newline
syscall
lw $a0, ($sp)
lw $v0, 4($sp)
addi $sp, $sp, 8
L15: b L18
L16: li $t1, 3
L17: sub $s0, $t0, $t1
     bnez $s0, L21
L18: li $t1, 3
L19: addi $sp, $sp, -8
sw $a0, ($sp)
sw $v0, 4($sp)
li $v0, 1 
move $a0, $t1 
syscall
li $v0, 4
la $a0, newline
syscall
lw $a0, ($sp)
lw $v0, 4($sp)
addi $sp, $sp, 8
L20: b L21
L21: li $t1, 5
L22: addi $sp, $sp, -8
sw $a0, ($sp)
sw $v0, 4($sp)
li $v0, 1 
move $a0, $t1 
syscall
li $v0, 4
la $a0, newline
syscall
lw $a0, ($sp)
lw $v0, 4($sp)
addi $sp, $sp, 8
L23: li $t0, 0
L24: sw $t0, x_2_main
L25: lw $t0, x_2_main
L26: li $t1, 3
L27: li $t2, 1
L28: sub $s0, $t0, $t1
     blez $s0, L30
L29: li $t2, 0
L30: li $s0, 0
sub $s0, $t2, $s0
     beqz $s0, L67
L31: li $t0, 0
L32: sw $t0, j_3_main
L33: lw $t0, j_3_main
L34: li $t1, 3
L35: li $t2, 1
L36: sub $s0, $t0, $t1
     bltz $s0, L38
L37: li $t2, 0
L38: li $s0, 0
sub $s0, $t2, $s0
     beqz $s0, L55
L39: b L45
L40: lw $t0, j_3_main
L41: li $t1, 1
L42: add $t2, $t0, $t1
L43: sw $t2, j_3_main
L44: b L33
L45: lw $t0, j_3_main
L46: addi $sp, $sp, -8
sw $a0, ($sp)
sw $v0, 4($sp)
li $v0, 1 
move $a0, $t0 
syscall
li $v0, 4
la $a0, newline
syscall
lw $a0, ($sp)
lw $v0, 4($sp)
addi $sp, $sp, 8
L47: lw $t0, j_3_main
L48: li $t1, 1
L49: li $t2, 1
L50: sub $s0, $t0, $t1
     beqz $s0, L52
L51: li $t2, 0
L52: li $s0, 0
sub $s0, $t2, $s0
     beqz $s0, L40
L53: b L55
L54: b L40
L55: lw $t0, x_2_main
L56: li $t1, 1
L57: add $t2, $t0, $t1
L58: sw $t2, x_2_main
L59: lw $t0, x_2_main
L60: li $t1, 2
L61: li $t2, 1
L62: sub $s0, $t0, $t1
     beqz $s0, L64
L63: li $t2, 0
L64: li $s0, 0
sub $s0, $t2, $s0
     beqz $s0, L25
L65: b L67
L66: b L25
L67: li $t0, 1
L68: move $v0, $t0
jr $ra
L69: jr $ra

