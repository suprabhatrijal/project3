.data
input: .space 1001
.text
############################# main program starts #######################################
main:
# get input string from the user
li $v0, 8
la $a0, input
li $a1, 1001
syscall

j exit


exit:
# exit
li $v0, 10
syscall

############################# main program ends #######################################

###### sub program sub_a starts #################################
sub_a:
#
lw $s0, 0($sp) # the address of the string
li $s1, 1 # the comma character encountered flag
li $s6, 0 # the comma character encountered flag

j sub_a_loop

sub_a_loop:

lb $t0, 0($s0) 
li $t1, 44
beq $t0, $t1, commaEncountered 


j rebranch_1

rebranch_1:

li $t0, 1
# if current char is the first character after a comma, branch out
beq $s1, $t0, firstCharTrue 



j rebranch_2

rebranch_2:
li $s6, 1
addi $s0, $s0, 1

li $t0, 0
li $t1, 10
lb $t2, 0($s0)

seq $t0, $t2, $t0 # $s4 == NULL
seq $t1, $t2, $t1 # $s4 == ENTER

or $t0, $t0, $t1 # $s4 == NULL or $s4 == ENTER
li $t1, 1
bne $t1, $t0 sub_a_loop # if not ($s4 == NULL or $s4 == ENTER)then loop


li $t0, 1
beq $s1, $t0, printInvalidExit

j rebranch_3

rebranch_3:
jr $ra
firstCharTrue:
# call the sub_b function 
# lb $a0, 0($s0)
# li $v0, 11
# syscall
li $s1, 0


# reserve space for return address
addi $sp, $sp, -4
# save the return address in the stack
sw $ra,  0($sp)

# reserve space for saving $s registers
addi $sp, $sp, -12

# save the state of all s registers used in the stack
sw $s0, 0($sp)
sw $s1, 4($sp)
sw $s6, 8($sp)


# pass the address of the substring to sub_b
# reserve safe of return values in the stack
addi $sp, $sp, -12
sw $s0, 0($sp)
jal sub_b
# save the return value
lw $s2, 4($sp)
lw $s3, 8($sp)
# restore stack to before passing arguments and return values
addi $sp, $sp, 12
# restore all the s registers to the previous state
lw $s0, 0($sp)
lw $s1, 4($sp)
lw $s6, 8($sp)

# restore the stack to before saving s registers
addi $sp, $sp, 12



# restore return address to $ra
lw $ra, 0($sp)


# restore the stack to before saving return address
addi $sp, $sp, 4

# if the function returns -1 print invalid input
li $t1, -1
beq $s2, $t1, printInvalid
# if $s1 is less than 1 handle edge case
slti $t1, $s3, 1
li $t2, 1
beq $t2, $t1 oneChar

j fixedEdgeCase

fixedEdgeCase:
# first character has been encountered print comma
li $t0, 1
beq $s6, $t0, printComma

j rebranch_4