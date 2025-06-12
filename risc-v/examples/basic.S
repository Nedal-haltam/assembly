.equ SYS_WRITE, 64
.equ SYS_EXIT, 93
.section .text
.globl main
main:
# begin scope
    la a0, StringLits0
    call printf
    ADDI t0, zero, 123
    addi sp, sp, -8
    SD t0, 0(sp)
    ADDI t0, zero, 465
    addi sp, sp, -8
    SD t0, 0(sp)
    la a0, StringLits1
########## x
    LD a1, 8(sp)
    call printf
    la a0, StringLits2
########## y
    LD a1, 0(sp)
    call printf
    la a0, StringLits3
########## y
    LD t0, 0(sp)
    addi sp, sp, -8
    SD t0, 0(sp)
########## x
    LD a1, 16(sp)
    LD t1, 0(sp)
    addi sp, sp, 8
    ADD a1, a1, t1
    call printf
    la a0, StringLits4
    call printf
# end scope
    ADDI sp, sp, 16
    ADDI a0, zero, 0
    call exit
exit:
    li a7, SYS_EXIT
    ecall
    ret
strlen:
    mv t0, a0
    li s0, 0
strlen_loop:
    lbu t1, 0(t0)
    beqz t1, strlen_done
    addi s0, s0, 1
    addi t0, t0, 1
    j strlen_loop
strlen_done:
    ret
itoa:
    mv t1, a0
    la t2, itoaTempBuffer
    addi t2, t2, 32
    sb zero, 0(t2)
itoa_loop:
    beqz t1, itoa_done
    li t3, 10
    rem t4, t1, t3
    addi t4, t4, '0'
    addi t2, t2, -1
    sb t4, 0(t2)
    div t1, t1, t3
    j itoa_loop
itoa_done:
    mv s0, t2
    ret
.section .data
StringLits0:
    .string "Hello, World!\n"
StringLits1:
    .string "x = %d\n"
StringLits2:
    .string "y = %d\n"
StringLits3:
    .string "x + y = %d\n"
StringLits4:
    .string "Good Bye\n"
.section .bss
itoaTempBuffer:     
    .space 32
.extern printf
