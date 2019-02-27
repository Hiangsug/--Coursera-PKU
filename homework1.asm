#____________________________________
# name:  Hiangsug
# email: lxsh1111@163.com
# date:  2019/02/27
#------------------------------------
.data
starttext: .asciiz "\nStart:\n"
endtext:   .asciiz "\nThanks for using."

#����ʹ��
smalltext: .asciiz "\tsmall\n"
bigtext: .asciiz "\tbig\n"
numtext: .asciiz "\tnum\n"
nonetext: .asciiz "\t*\n"

#���list
keyC: .word A, BB, C, D, E, F, G, H, I, JJ, K, L, M, N, O, P ,Q, R, S, T, U, V, W, X, Y, Z
A:	.asciiz "Alpha" 
BB:	.asciiz "Bravo"
C:	.asciiz "China"
D:	.asciiz "Delta"
E:	.asciiz "Echo"
F:	.asciiz "Foxtrot"
G:	.asciiz "Golf"
H:	.asciiz "Hotel"
I:	.asciiz "India"
JJ:	.asciiz "Juliet"
K:	.asciiz "Kilo"
L:	.asciiz "Lima"
M:	.asciiz "Mary"
N:	.asciiz "November"
O:	.asciiz "Oscar"
P:	.asciiz "Paper"
Q:	.asciiz "Quebec"
R:	.asciiz "Research"
S:	.asciiz "Sierra"
T:	.asciiz "Tango"
U:	.asciiz "Uniform"
V:	.asciiz "Victor"
W:	.asciiz "Whisky"
X:	.asciiz "X-ray"
Y:	.asciiz "Yankee"
Z:	.asciiz "Zulu"

key: .word a, bb, c, d, e, f, g, h, i, jj, k, l, m, n, o, p ,q, r, s, t, u, v, w, x, y, z
a:	.asciiz "alpha" 
bb:	.asciiz "bravo"
c:	.asciiz "china"
d:	.asciiz "delta"
e:	.asciiz "echo"
f:	.asciiz "foxtrot"
g:	.asciiz "golf"
h:	.asciiz "hotel"
i:	.asciiz "india"
jj:	.asciiz "juliet"
k:	.asciiz "kilo"
l:	.asciiz "kima"
m:	.asciiz "mary"
n:	.asciiz "november"
o:	.asciiz "oscar"
p:	.asciiz "paper"
q:	.asciiz "quebec"
r:	.asciiz "research"
s:	.asciiz "sierra"
t:	.asciiz "tango"
u:	.asciiz "uniform"
v:	.asciiz "victor"
w:	.asciiz "whisky"
x:	.asciiz "x-ray"
y:	.asciiz "yankee"
z:	.asciiz "zulu"


#����ת��
number: .word zero, one, two, three, four, five, six, seven, eight, nine
one:	.asciiz "First"
two:	.asciiz "Second"
three:	.asciiz "Third"
four:	.asciiz "Fourth"
five:	.asciiz "Fifth"
six:	.asciiz "Sixth"
seven:	.asciiz "Seventh"
eight:	.asciiz "Eighth"
nine:	.asciiz "Ninth"
zero:  .asciiz "zero"

tab:   .asciiz "\t"
enter: .asciiz "\n"

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
	beq $t0, $s0, dispalphac
	
	#�ж��Ƿ�ΪСд��ĸ
	slt $t0, $v0, $s5    #if($v0<'a'):$t0 = 1;else: $t0 = 0;
	beq $t0, $s0, dispnone
	add $t1, $s6, 1
	slt $t0, $v0, $t1    #if($v0<='z'):$t0 = 1;else: $t0 = 0;
	beq $t0, $s0, dispalpha
	
	
	#�޷�ʶ������dispnone
	j dispnone
	
	
dispnum:
	sub $v0, $v0, $s1 #v0 -= '0'
	sll $v0, $v0, 2
	la $t0, number
	add $t0, $t0, $v0
	j output

dispalpha:
	sub $v0, $v0, $s5 #v0 -= 'a'
	sll $v0, $v0, 2
	la $t0, key
	add $t0, $t0, $v0
	j output

dispalphac:
	sub $v0, $v0, $s3 #v0 -= 'A'
	sll $v0, $v0, 2
	la $t0, keyC
	add $t0, $t0, $v0
	j output
	
output:
#�ָ���
	la $a0,tab
	li $v0, 4
	syscall
	
#ת�����	
	lw $a0, ($t0)
	li $v0, 4
	syscall
	
#�س�
	la $a0,enter
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
