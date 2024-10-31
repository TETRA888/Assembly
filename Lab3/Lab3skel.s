##
## Your Name Asad Melibaev
## Last Four Digits of SID 2848
## EEC 170
## Fall 2024
## Lab 3
###

.data
quot:     .string "Quotient =  "
remain:   .string "Remainder = "
dividend: .string "Dividend =  "
divisor:  .string "Divisor =  "
newln:    .string "\n"
spc:      .string "       "
thank:    .string "Thank You\n"

#These are just sample values. Your program should work for all values  0 <= X <=40955 and 0 < Y <= 4095
X:  .word  200         #dividend   
Y:  .word  189         #divisor    


.text
.globl main                         # make main available to all project files

main:                               # There should be one main


    jal printInput
    lw a1, X                        # a3 = X
    lw a2, Y                        # a4 = Y

    # Divisor is a2 and Dividend in a1, ready to go

    jal myDiv

    jal printResults  
       
# Exit Politely with a Thank You Message

    la a1   thank
    li a0, 4
    ecall
    jal zero, exit                  # Exit program

#parameters to myDiv  -- a1 is the dividend and a2 is the divisor
#return the results in registers s2, and s3 to print correctly

#Your myDiv code goes here.  
#This code should be made as efficient as possible.
   
#The code structure should be fairly straight forward, I will essentially just be adding the divisor up until I get to a value where the difference
#between the divisor and the dividend will be negative, at which point, I back track to the sum value before that and then subtract to get the remainder
#I can just keep track of the amount of times im adding up the divor, which will be the quotient. However, this simple strat would not work with signed numbers
myDiv:
    add x31, x31, a2
    blt a1, x31, prepareToPrint
    addi s2, s2, 1
    j myDiv

prepareToPrint:
    sub x31, x31, a2
    sub s3, a1, x31
    jalr x0, 0(x1)

#Make sure you return from the procedure


# Print Routines are provided. Don't Modify!!!

printInput:
        #print dividend=
            li a0, 4
            la a1, dividend
            ecall
            li a0, 1
            lw a1, X
            ecall
            li a0, 4
            la a1, spc
            ecall

        #print divisor=
            li a0, 4
            la a1, divisor
            ecall
            li a0, 1
            lw a1, Y
            ecall
            li a0, 4
            la a1, spc
            ecall
            jalr ra

printResults:
        #print Quotient=
            li a0, 4
            la a1, quot
            ecall
            li a0, 1
            mv a1, s2
            ecall
            li a0, 4
            la a1, spc
            ecall
        #print Remainder=
            li a0, 4
            la a1, remain
            ecall
            li a0, 1
            mv a1, s3
            ecall
            li a0, 4
            la a1, newln    
            ecall
            jalr ra

exit:
    addi a0, zero, 0xA 
    ecall
