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