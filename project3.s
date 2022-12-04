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