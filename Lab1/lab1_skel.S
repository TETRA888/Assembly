.data

# we are declaring a bunch of strings, using the .string directive
# for example the first declaration,  says welcome is a pointer to a string that is initiatlized to something.

welcome:     .string "Welcome to EEC 170, Fall 2024 \n"
msg1:        .string "X = "
msg2:        .string "Y = "
msg3:        .string "X+Y ="
newln:       .string "\n"
thank:       .string "Thanks. We are done.\n \n \n"

# we are declaring variables X and Y as integers and initializing 
# So this is like  int X =130  int Y = 15
X:  .word  130         
Y:  .word   15   


# we are declaring a str.  This is same as char *str[100]
str:  .string  "The goal of this lab is to learn RISC-V Assembly Language aaa"
# this is same as char ch in C
ch:   .string     "a"  
msg4:  .string "The character "
msg5:  .string "   appears  "
msg6:  .string "   times in the string --- "


# .text means the rest of the stuff is a program or instructions to the computer
.text
.globl main                         # make main available to all project files

########  PART 1  BEGIN #############

#In assembly language to print something like an string or integer you have to use a system call, basically
# a request to the operating system (much like printf in C)
# In RISC-V Assembly, you pass the pointer to the string or the value to be printed in register a1 or x11 
# and a code, what to print - whether it is integer, string, character, etc. in register a0 or x10
# This is followed by the command  ecall.

# Here are a bunch of examples
# the following 3 lines, print the message "Welcome to EEC 170, Fall 2023" via a system call
# here the pointer to the string welcome is passed in register a1 via a command "la" (we'll learn more about these commands or instructions in Chapter 2)
# and the code 4 in register a0, which is the request to print a integer.

    la a1, welcome
    li a0, 4
    ecall

# Similarly next 3 lines, print "X ="  via  system call. 
	la a1, msg1
    li a0, 4
    ecall

# Next 3 lines, print the value X, which happens to be 130. Note the value X is loaded into register a1 with the lw command 
#register a0 has the value 1, which means we want to print an integer.
    lw a1, X
    li a0, 1
    ecall 
    
    la a1, newln
    li a0, 4
    ecall
    
    la a1, msg2
    li a0, 4
    ecall
    lw a1, Y
    li a0, 1
    ecall 

    la a1, newln
    li a0, 4
    ecall
    
    la a1, msg3
    li a0, 4
    ecall

# performing the computation X+Y
    lw a1, X
    lw a2, Y 
    add a1, a1, a2
    
# a1 has the result, which we will print next

    li a0, 1
    ecall 

 la a1, newln
    li a0, 4
    ecall

 la a1, newln
    li a0, 4
    ecall


########  PART 1  END  #############


########  PART 2  BEGIN #############
la x5, str       # x5 = &str[0]
li x6, 0         # x6 =0  or count initialized to 0
la x7, ch        # x7 = &ch   address of ch is in register x7
lbu x7, 0(x7)    #  x7 = ch  the character ch is in register x7
li x8, 0        # x8 = 0  x8 is the index variable of the for loop i, which is set to 0

#your code goes here.  Call your function countOccurences

countOccurences:
    lb x9, 0(x5) # x9 = str[0]
    beq x9, zero, printCount # if str[0] = /0 end loop
    beq x9, x7, matchincrement # if str[0] == ch counter ++ else continue
    addi x5, x5, 1

    j countOccurences # jump back to start

matchincrement:
    addi x6, x6, 1
    addi x5, x5, 1
    j countOccurences

# Print routine is given for you.  So, don't have to modify anything, below this

printCount: 
            la a1, msg4
            li a0, 4
            ecall

la a1, ch
li a0, 4
ecall

la a1, msg5
li a0, 4
ecall

add a1, x6, x0
li a0, 1
 ecall

la a1, msg6
li a0, 4
ecall

la a1, str
li a0, 4
ecall

la a1, newln
    li a0, 4
    ecall

########  PART 2  END #############

la a1, newln
    li a0, 4
    ecall

    la a1, newln
    li a0, 4
    ecall

    la a1, thank
    li a0, 4
    ecall

# this is a system call to exit the program gracefully. The code is 10 in register a0. Nothing is required in a1.
exit:
    addi a0, zero, 10 
    ecall