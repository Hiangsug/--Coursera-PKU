#____________________________________
# name:  Hiangsug
# email: lxsh1111@163.com
# date:  2019/02/27
#------------------------------------

.data
starttext: .asciiz "\nStart:\n"
endtext:   .asciiz "\nThanks for using."
successtext:	.asciiz "\r\nSuccess!!! Location: "
failtext:	.asciiz "\r\nFail!!!\r\n"
buffer: .word 0:1024
enter:  .asciiz "\n"


.text
.globl main
main:
start:#����ʼ
	la $a0, starttext
	li $v0, 4
	syscall	

inputstr:#�ַ�������
	la $a0, buffer
	li $a1, 1000
	li $v0, 8
	syscall
	
inputchar:#�ַ�����
	li $v0, 12
	syscall
	add $s0,$v0,0  #�ַ���������$s0

check:#����Ƿ�Ϊ�ʺ�
	li $t0, '?'
	beq $v0, $t0, end

find:#���ַ����в����ַ�
	la $t0, 0      #������
	la $t1, buffer #������ͷ��ַ
	li $a0, '\0'   #β��־
	
loop: #ѭ���������ַ�����ֱ���ҵ��ַ�Ϊֹ��
	add $t2, $t1, $t0  #$t2Ϊ�ַ����е�һ���ַ�
	lbu $t3, ($t2)
	beq $t3, $s0, success #����ǰ�ַ���Ŀ���ַ���ȣ���ת	
	beq $t3, $a0, fail #����ǰλ��Ϊ�ַ���ĩ�ˣ�����δ����ѭ���������ʧ��
	addi $t0, $t0, 1  #��������һ
	j loop	
	
	
	

success:#�ɹ����
	la $a0, successtext
	li $v0, 4
	syscall
	add $a0, $t0, 0
	li $v0, 1
	syscall
	la $a0, enter
	li $v0, 4	
	syscall
	j inputchar

fail:#ʧ�����
	la $a0, failtext
	li $v0, 4
	syscall
	j inputchar

end: #�������
	la $a0, endtext
	li $v0, 4
	syscall
