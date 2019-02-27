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
start:#程序开始
	la $a0, starttext
	li $v0, 4
	syscall	

inputstr:#字符串输入
	la $a0, buffer
	li $a1, 1000
	li $v0, 8
	syscall
	
inputchar:#字符输入
	li $v0, 12
	syscall
	add $s0,$v0,0  #字符串储存至$s0

check:#检查是否为问号
	li $t0, '?'
	beq $v0, $t0, end

find:#在字符串中查找字符
	la $t0, 0      #计数器
	la $t1, buffer #缓冲区头地址
	li $a0, '\0'   #尾标志
	
loop: #循环：遍历字符串。直至找到字符为止。
	add $t2, $t1, $t0  #$t2为字符串中的一个字符
	lbu $t3, ($t2)
	beq $t3, $s0, success #若当前字符与目标字符相等，跳转	
	beq $t3, $a0, fail #若当前位置为字符串末端，但仍未跳出循环，则查找失败
	addi $t0, $t0, 1  #计数器加一
	j loop	
	
	
	

success:#成功输出
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

fail:#失败输出
	la $a0, failtext
	li $v0, 4
	syscall
	j inputchar

end: #程序结束
	la $a0, endtext
	li $v0, 4
	syscall
