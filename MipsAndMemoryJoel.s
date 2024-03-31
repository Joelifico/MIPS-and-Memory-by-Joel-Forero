#=============================================================
#Joel Forero Mejia
#Computer Architecture
#Describtion:In this program. the main goal is to be able to print the array, find the smallest and biggest value of the array and also swap those two of position
#Date: 3/29/2024
#=============================================================
   .data
welcome:    .asciiz "Welcome to my MIPS Array Program"
newline:    .asciiz "\n"
coma: 		.asciiz ","
minValue: 	.asciiz"The address of the biggest number is(Decimal): "
size:	    .word 10
myarray:     .word 94, 13, 3, 58, 19, 38, 28, 36, 74, 80


promptmyarray: 			.asciiz"My array: "
promptMin:		.asciiz "The address of the smallest number in decimal is: "
promptMinValue: 	.asciiz "The smallest number is: "
promptMax:  .asciiz "The address of the biggest number in decimal is: "
promptMaxValue: .asciiz "The biggest number is: "
promptNewArray:		.asciiz "The new array: "
        .text
        .globl main
#========================
#	Print new line
#=========================	
printnewline:
    addi $sp,$sp,-4     #Prepare the stack for use of a register
    sw $ra,($sp)        #Save current return address on the stack

    #print newline
    li $v0, 4           #syscall 4 to print string
    la $a0, newline     #pass newline string
    syscall             #print string

    lw $ra, ($sp)       #Restore return address
    addi $sp,$sp,4      #Restore stack pointer
    jr $ra              #Return
#================================
#	Find Max value address
#============================
findMax:
	#save registers
	addi $sp,$sp,-8
	sw $t0,8($sp)
	sw $s1,4($sp)			#this one would be myarray[]
	sw $s0,0($sp)			#this one will help me to get myarray[maxvalue]
	#use registers
	# declare min value variable 
	addi $t0,$0,0		# clear register t1
	addi $t1,$0,0		# clear register t2				The reason for this is that it was causing a lot of problems
	addi $t2,$0,0		# clear register t3				because in this program I use a lot of the temp registers 
	addi $t3,$0,0		# clear register t3
	addi $t4,$0,0		# clear register t4
	addi $t5,$0,0		#clear register t5
	
	add $s0,$s0,$0		#I will use s0 as my maxValue
	move $s1,$a0		# it will help me to store the whole myarray into a registers
	#for loop part
	addi $a1,$a1,1				#this will make that the loop goes through the whole array
	forloop1:
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
	beq $t4,$0,exitif1			#if that is not true it will break the if statement
	add $s0,$0,$t0				#if if is true, it will do minValue= i
	exitif1:
	#====================================
	addi $t0,$t0,1
	j forloop1
	Exit1:
		#save return value
		add $v0,$t3,$0					# it will return the address of the biggest value
		#restore registers
		lw $s1,4($sp)
		lw $s0,0($sp)
		addi $sp,$sp,8
		jr $ra					#go to main
#===================================
#			Find min function
#================================
findMin:
	#save registers
	addi $sp,$sp,-8
	sw $s1,4($sp)			#this one would be myarray[]
	sw $s0,0($sp)			#this one will help me to get myarray[minvalue]
	#use registers
	# declare min value variable 
	addi $t0,$0,0		# clear register t1
	addi $t1,$0,0		# clear register t2
	addi $t2,$0,0		# clear register t3
	addi $t3,$0,0		# clear register t3
	addi $t4,$0,0		# clear register t4
	
	add $s0,$s0,$0		#I will use s0 as my minValue
	move $s1,$a0		# it will help me to store the whole myarray into a registers
	#for loop part
	addi $a1,$a1,1				#this will make that the loop goes through the whole array
	forloop2:
	slt $t1,$t0,$a1				#t0=i, a1=size, I will use this to check the condition of the forloop
	beq $t1,$0,Exit2
	#========myarray[i] set up============
	sll $t2, $t0,2				#making i*4
	add $t2,$a0,$t2				#this will help me to iterate through the array
	lw $t5,0($t2)				#this is my myarray[i]
	#======================================
	#============myarray[minvalue] set up====
	sll $t3,$s0,2			#making minValue*4
	add $t3,$a0,$t3			#making the [minValue]
	lw $t6,0($t3)			#this is myarray[minValue]
	#=====================================
	#==========if statement=============
	
	slt $t4,$t5,$t6				#this will check if myarray[i]<myarray[minvalue]
	beq $t4,$0,exitif2			#if that is not true it will break the if statement
	move $s0,$t0				#if if is true, it will do minValue= i
	exitif2:
	#====================================
	addi $t0,$t0,1
	j forloop2
	Exit2:
		#save return value
		add $v0,$t3,$0						#it will return the address of the smallest value in the array
		#restore registers
		lw $s1,4($sp)
		lw $s0,0($sp)
		addi $sp,$sp,8
		jr $ra							#go to main
#===========================================
#		Print values at address
#==========================================
printValues:
	# save registers
	addi $sp,$sp,-4
	sw $s0,0($sp)
	#use registers
	lw $s0, 0($a0)         # it will save the value that is in the address of the array and because its using a lw, it will save the actual value , not the address
	#print the value that the address holds
    li $v0, 1              
    add $a0,$s0,$0          # it will use the number selected to print
    syscall	
	#restore registers
	lw $s0,0($sp)
	addi $sp,$sp,4				
	jr $ra			#go to main
#====================================================================
# 							Swap values procedure
#==================================================================
swapvalues:
	#save registers
	addi $sp,$sp, -8
	sw $s2,4($sp)		#first address to swap 
	sw $s0,0($sp)		#second address to swap
	#use register
	
	addi $t0,$0,0
	addi $t1,$0,0
	addi $t2,$0,0			#clear all the temp registers in order to be used, I could've done in another way'
	addi $t3,$0,0			#but this was the only solution I was able to come up. It's not the greatest but my program works 
	addi $t4,$0,0		
	
	#Calculate address at the given values to swap
	add $s0,$a1,$s0			# as we are just swaping I'm just putting the first address into s0
	add $s2,$a2,$s2			# and s2, in this way I'm able to make changes related to the address
	
	lw $t0,0($s0)			#this will save the actual value into t0 for me to be able to swap it 
	lw $t1,0($s2)			#this will save the actual value into t1 for me to be able to swap it
	
	move $t2,$t0			#it will save the value of the second value to swap in a temp variable
	move $t0,$t1			#then it will put the first value into the position of the second value
	move $t1,$t2			#after that it will put the second value into the original position of the first value

	sw $t0,0($s0)			#After the swap is done, these sw instructions will modify the original addresses
	sw $t1,0($s2)			#and will swap the positions	
	#restore registers
	lw $s2,4($sp)		
	lw $s0,0($sp)			#restore the registers used in the swap
	addi $sp,$sp,8
	jr $ra					#go to main
#========================================
#			Print the array
#=========================================
printarray:
	#save register							#note: when I was printing the last array I encounter a problem
	addi $sp,$sp,-4							#that was not letting me print the array and the reason for that was
	sw $s0, 0($sp)							# My $t2 had an address used in my swap, therefore, it was creating conflicts 
	#use register							#with my printing function, So i used the pseudoinstruction move to clear it 
	move $s0,$a0							#					  ^
	move $t2,$0								# Explanation of this |
	forloop:
		slt $t1,$t2,$a1				# check condition of the for loop,
		beq $t1,$0,exit
		#arrange for index
		sll $t3,$t2,2			#i*4
		add $t4,$s0,$t3		# this will fix the value of the index for i iterations in the array in order words, is making the [i]
		lw $a0,0($t4)			# This will load the actual value of the index. in order words is making the myarray[i]
		#print integers of the Array===========
		li $v0,1
		la $t4,myarray				#This will print the values of the array
		syscall
		# print coma====================
		li  $v0,4		#
		la $a0,coma					#This will print the , to separate the values of the array
		syscall
		addi $t2,$t2,1		#i++ no need to explain this
		j forloop
	exit:
		#restore registers===========================
		lw $s0,0($sp)
		addi $sp,$sp,4
		jr $ra
#=========================================
#		Main 
#=====================================
main:	
	addi $sp,$sp,-12
	sw $s1,8($sp)
	sw $s3,4($sp)				#make space in memory to put my main part of the program
	sw $ra,0($sp)
	#===============
	#print the array
	#==================
	li $v0,4
	la $a0,promptmyarray			# This will prompt "myArray: "
	syscall 
	la $a0,myarray					# by putting the array and the and the size as parameters
	lw $a1,size						#I'm able to print everything out
	jal printarray					#call the function
	#======================
	jal printnewline
	#==========================================================================
	#use findMinAddress() and printValueAtAddress() 
	#to print the address and value of the smallest number in the array
	#======================================================================
	li $v0,4						#Prompt of the min value address
	la $a0,promptMin
	syscall
	la $a0,myarray			#pass the array as one of the parameters
	lw $a1,size				# pass the size of the array as the other parameter
	jal findMin				# call the function
	move $s3,$v0			#  store the return value in $t0
	add $t0,$s3,$0				#Save the address 
	li $v0,1	# this is to print the address of the value
	la $a0,0($t0)
	syscall
	jal printnewline
	li $v0,4
	la $a0,promptMinValue		#This is will print "The smallest number is: "
	syscall
	la $a0,myarray			#pass the array as a parameter
	move $a0,$t0		#store the return address from findMinaddress into a0 and print the value
	jal printValues
	jal printnewline
	#==================== =============================================
	#Use findMaxAddress() and printValueAtAddress()
	#to print the address and value of the largest number in the array
	#============================================================
	li $v0,4
	la $a0,promptMax			# prompt of the max value address
	syscall
	la $a0,myarray				#pass the arrazy and the size of the array as 
	lw $a1,size					#parameters to be able to find the address of the biggest value
	jal findMax					#jump to the procedure
	move $s1,$v0				#the return value will be store in $s1
	add $t1,$s1,0				# at the same time, I will store that value into a temp register in order to manipulate
								# the value without affecting the real one. Its like a copy
	li $v0,1					# this will print the actual address of the biggest value in decimal	
	la $a0,0($t1)				# as we are dealing with address, I used la and $a0,0($t1) to be able to pass the address as the parameter
	syscall						# for the syscall to be able to print the value
	jal printnewline			# "\n"
	li $v0,4					# prompt the biggest value
	la $a0,promptMaxValue	
	syscall
	la $a0, myarray
	move $a0,$t1,				# in order to print the biggest value I will pass the address of the
	jal printValues				#the biggest value in my printvalue function
	jal printnewline
	#===========================================================
	#				Swap values
	#===================================================
	la $a0,myarray
	move $a1,$s1				#Once I found the smallest and the biggest value,I will pass the addresses
	move $a2,$s3				#to my swap value function and then it will be called
	jal swapvalues
	li $v0, 4				
	la $a0 , promptNewArray   #prompt the new array with the biggest and smallest value changes in position
	syscall
	la $a0,myarray
	lw  $a1,size				#Once the swap is done, I will print out the new array with the biggest and smallest value interchanging positions
	jal printarray
	lw $s1,8($sp)
	lw $s3,4($sp)				# restoring the registers used in this program
	lw $ra,0($sp)
	addi $sp,$sp,12				#fix the stack
	# Explanation of why lw $a0, size:
	# Basically this works because size is an address in memory where is stored the size of the array. With Lw ,Lb, and similars. the format is 
	# instruction destination, address in memory. For address in memory we use 0($register) to access the first item in the memory. But we can also use lw $register, label where is store what want
	# at the end, its using that label as our address

