# $16 = a = 250 = $s0
# $17 = b = 200 = $s1
# $18 = c = 300 = $s2
# $19 = d = 450 = $s3

# 32($a0) = i
# 48($a0) = j

# 64($a0) = f

#if i > j
#	f = b + c - a
#else
#	f = a + b + c - d
.data
smallTable: .word 250, 200, -10, 10, 300, 450 #when testing with mars, change the values for i and j
.text
la $a0, smallTable # Set second argument to 0 when compiling for verilog, to smallTable when compiling for Mars


lw $s0, 0($a0) #a
lw $s1, 4($a0) #b
lw $s2, 16($a0) #c
lw $s3, 20($a0) #d

lw $a1, 8($a0) # i stored at memory [2]
lw $a2, 12($a0) # j stored at memory [3]

slt $t0, $a2, $a1 #Setting value for comparison
beq $t0, $zero, else #Performing comparison between i and j
add $t1, $s1, $s2 # $t1 = b + c
sub $t1, $t1, $s0 # $t1 = $t1 - a (b+c-a)
beq $zero, $zero, exit # Used in place of a jump since the processor cannot do a jump
else:
add $t1, $s0, $s1 # $t1 = a + b
sub $t2, $s2, $s3 # $t2 = (c - d)
add $t1, $t1, $t2 # $t1 = $t1 + $t2 (a+b+c-d)
exit:
sw $t1, 24($a0) #saving data to index 6 in data memory
