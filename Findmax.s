      .data
welcome:    .asciiz "Welcome to my MIPS Array Program"
newline:    .asciiz "\n"
coma: 		.asciiz ","
minValue: 	.asciiz"The address of the biggest number is(Decimal): "
size:	    .word 10
myarray:     .word 94, 13, 3, 58, 19, 38, 28, 36, 74, 80

        .text
        .globl main
#===================================
#			Find MaxValue function
#================================
findMin:
	#save registers
	addi $sp,$sp,-8
	sw $s1,4($sp)			#this one would be myarray[]
	sw $s0,0($sp)			#this one will help me to get myarray[maxvalue]
	#use registers
	# declare min value variable 
	add $s0,$s0,$0		#I will use s0 as my maxValue
	move $s1,$a0		# it will help me to store the whole myarray into a registers
	#for loop part
	forloop:
	slt $t1,$t0,$a1				#t0=i, a1=size, I will use this to check the condition of the forloop
	beq $t1,$0,Exit1
	#========myarray[i] set up============
	sll $t2, $t0,2				#making i*4
	add $t2,$a0,$t2				#this is the address of the myarray[i]
	lw $t5,0($t2)				#this is my myarray[i]
	#======================================
	#============myarray[minvalue] set up====
	sll $t3,$s0,2			#making maxValue*4
	add $t3,$a0,$t3			#making the [maxValue]	this is myarrray[maxValue] but the address
	lw $t6,0($t3)			#this is myarray[maxValue] But this will take the actual value 
	#=====================================
	#==========if statement=============
	slt $t4,$t6,$t5					#this will check if myarray[i]<myarray[maxvalue]
	beq $t4,$0,exitif			#if that is not true it will break the if statement
	add $s0,$0,$t0				#if if is true, it will do minValue= i
	exitif:
	#====================================
	addi $t0,$t0,1
	j forloop
	Exit1:
		#save return value
		add $v0,$t3,$0
		#restore registers
		lw $s1,4($sp)
		lw $s0,0($sp)
		addi $sp,$sp,8
		jr $ra
	
main: 
	la $a0,myarray
	lw $a1, size
	jal findMin
	move $t0,$v0
	
	li $v0,4
	la, $a0, minValue
	syscall
	
	li $v0,1
	add $a0,$0,$t0
	syscall
	
	