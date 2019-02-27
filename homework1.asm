#____________________________________
# name:  Hiangsug
# email: lxsh1111@163.com
# date:  2019/02/27
#------------------------------------
.data
starttext: .asciiz "\nStart:\n"
endtext:   .asciiz "\nThanks for using."
smalltext: .asciiz "\tsmall\n"
bigtext: .asciiz "\tbig\n"
numtext: .asciiz "\tnum\n"
nonetext: .asciiz "\t*\n"


.text
.globl main
main:	
	li $s0, 1   # True Flag
	li $s1, '0'
	li $s2, '9'
	li $s3, 'A'
	li $s4, 'Z'
	li $s5, 'a'
	li $s6, 'z' 


start:
	la $a0,starttext
	li $v0, 4
	syscall

input: #从键盘读入一个字符，储存在$v0
	li $v0, 12
	syscall
	
compare:
	#判断是否为问号：如果是问号则跳至end，否则继续执行下一步判断
	li $t0, '?'
	beq $v0, $t0, end
	
	#判断是否为数字
	slt $t0, $v0, $s1    #if($v0<'0'):$t0 = 1;else: $t0 = 0;
	beq $t0, $s0, dispnone
	add $t1, $s2, 1
	slt $t0, $v0, $t1    #if($v0<='9'):$t0 = 1;else: $t0 = 0;
	beq $t0, $s0, dispnum
	
	#判断是否为大写字母
	slt $t0, $v0, $s3    #if($v0<'A'):$t0 = 1;else: $t0 = 0;
	beq $t0, $s0, dispnone
	add $t1, $s4, 1
	slt $t0, $v0, $t1    #if($v0<='Z'):$t0 = 1;else: $t0 = 0;
	beq $t0, $s0, dispbig
	
	#判断是否为小写字母
	slt $t0, $v0, $s5    #if($v0<'a'):$t0 = 1;else: $t0 = 0;
	beq $t0, $s0, dispnone
	add $t1, $s6, 1
	slt $t0, $v0, $t1    #if($v0<='z'):$t0 = 1;else: $t0 = 0;
	beq $t0, $s0, dispsmall
	
	
	#无法识别：跳至dispnone
	j dispnone
	

dispsmall:
	la $a0,smalltext
	li $v0, 4
	syscall
	j input

dispbig:
	la $a0,bigtext
	li $v0, 4
	syscall
	j input

dispnum:
	la $a0,numtext
	li $v0, 4
	syscall
	j input

dispnone:
	la $a0,nonetext
	li $v0, 4
	syscall
	j input

end:
	la $a0,endtext
	li $v0, 4
	syscall