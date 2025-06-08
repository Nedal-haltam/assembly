
.equ SYS_WRITE, 64
.equ SYS_EXIT, 93

.section .data

msg: 
    .asciz "Hello, world\n"
    .equ msg_length, 13 

.section .text
.globl _start
_start:
    li a7, SYS_WRITE
    li a0, 1
    la a1, msg
    li a2, msg_length
    ecall


    li a7, SYS_EXIT
    li a0, 0
    ecall
