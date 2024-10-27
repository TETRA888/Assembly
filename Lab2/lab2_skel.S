.data

##  Your name and ID etc go here
##  Name: Asad Melibaev
##  ID: 921202848

k: .word 7
A: .word 34, -85, -85, -45, 86, -65, -99 # A [1x7] vector
B: .word -36 55 -41 -33 -87 66 -89, 60 19 -14 43 -70 1 40, -18 69 -90 -71 59 -8 46, 68 -94 19 45 9 60 40, -95 -19 -5 98 -14 -67 60, 52 27 34 52 70 -46 31, -84 39 89 23 64 -89 -2 # B[7x7] matrix stored in row major
C: .word 90, 10, -31, 78, 63, 45, 8 # C[1 x 7] initialized to some random

#1,2,3,4,
#5,6,7,8,
#9,10,11,12
#13,14,15,16

msg1:     .string "C = "
spc:      .string "  "
newln:    .string "\n"


# .text means the rest of the stuff is a program or instructions to the computer
.text
.globl main                         # make main available to all project files

main:                               # There should be one main

la x2, A 
la x3, B 
la x4, C 
lw x5, k      # x5 contains the dimension of your vector/matrix


# Step 1. call the function mvmult
jal x1, mvmult

#  Step 2. call the function printResult
jal x1, printResult



# Exit the program gracefully. Don't modify anything below this.  
   la a1, newln
    li a0, 4
    ecall

exit:
    addi a0, zero, 10 
    ecall


#YOUR CODE GOES HERE

li x31, 0 # initialize i param row
li x23, 0 # initialize new j param coloumn

mvmult:
    beq x23, x5, exitout 
    beq x31, x5, reseti
    slli x30, x31, 2 # off set = 0*4
    add x29, x2, x30 # adding base + offset of vector A
    slli x19, x23, 2 # offset*4
    add x28, x4, x19 # adding base + offset of vector C

    mul x27, x31, x5 # need to calculate the offsets for the matrix location
    add x27, x27, x23 # (i*n +j)
    slli x26, x27, 2 # offset*4

    add x25, x3, x26 # adding the offset to the base address

    lw x6, 0(x29) # 1xk vector
    lw x7, 0(x25) # kxk matrix
    lw x8, 0(x28) # 1xk vector

    mul x22, x6, x7
    add x21, x21, x22

    addi x31, x31, 1 # incrementing i
    j mvmult

reseti:
    sw x21, 0(x28)
    li x21, 0
    li x31, 0
    addi x23, x23, 1 # incrementing j

    j mvmult

exitout:
    jalr x0, 0(x1) 
#END of your CODE

# Don't Touch this (BEGIN)

printResult:
# Code to print "C = "
    la a1, msg1
    li a0, 4
    ecall 

     la x4, C 
     lw x5, k      # x5 contains the dimension of your vector/matrix
      li x6, 0     # forloop index variable
forloop: 
      slli x7, x6, 2         # x7 has the offset
      add  x8, x4, x7       # x8 points to C[i]
      lw a1, 0(x8)          # a1 has element C[i]
      li a0, 1
      ecall                 #print C[i]

      la a1, spc           # print space
      li a0, 4
      ecall 

      addi x6, x6, 1   
      beq  x6, x5, L
      j forloop
L:  jalr x0, 0(x1)

