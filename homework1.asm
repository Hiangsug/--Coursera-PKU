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

input: #�Ӽ��̶���һ���ַ���������$v0
	li $v0, 12
	syscall
	
compare:
	#�ж��Ƿ�Ϊ�ʺţ�������ʺ�������end���������ִ����һ���ж�
	li $t0, '?'
	beq $v0, $t0, end
	
	#�ж��Ƿ�Ϊ����
	slt $t0, $v0, $s1    #if($v0<'0'):$t0 = 1;else: $t0 = 0;
	beq $t0, $s0, dispnone
	add $t1, $s2, 1
	slt $t0, $v0, $t1    #if($v0<='9'):$t0 = 1;else: $t0 = 0;
	beq $t0, $s0, dispnum
	
	#�ж��Ƿ�Ϊ��д��ĸ
	slt $t0, $v0, $s3    #if($v0<'A'):$t0 = 1;else: $t0 = 0;
	beq $t0, $s0, dispnone
	add $t1, $s4, 1
	slt $t0, $v0, $t1    #if($v0<='Z'):$t0 = 1;else: $t0 = 0;
	beq $t0, $s0, dispbig
	
	#�ж��Ƿ�ΪСд��ĸ
	slt $t0, $v0, $s5    #if($v0<'a'):$t0 = 1;else: $t0 = 0;
	beq $t0, $s0, dispnone
	add $t1, $s6, 1
	slt $t0, $v0, $t1    #if($v0<='z'):$t0 = 1;else: $t0 = 0;
	beq $t0, $s0, dispsmall
	
	
	#�޷�ʶ������dispnone
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