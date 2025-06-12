.equ SYS_WRITE, 64
.equ SYS_EXIT, 93
.section .text
.globl main
main:
# begin scope
    la a0, StringLits0
    addi sp, sp, -16
    sw a0, 0(sp)
    sw a1, 8(sp)
    ADDI a0, zero, 123
    ADDI a1, zero, 456
    call foo
    lw a1, 8(sp)
    lw a0, 0(sp)
    addi sp, sp, 16
    mv a1, s0
    call printf
    call Print10sMultiple
# end scope
    ADDI a0, zero, 0
    call exit
foo:
    addi sp, sp, -8
    sw ra, 0(sp)
# begin scope
########## b
    mv t0, a1
    addi sp, sp, -8
    sw t0, 0(sp)
########## a
    mv s0, a0
    lw t1, 0(sp)
    addi sp, sp, 8
    ADD s0, s0, t1
    lw ra, 0(sp)
    addi sp, sp, 8
    ret
# end scope
    li s0, 0
    lw ra, 0(sp)
    addi sp, sp, 8
    ret
Print10sMultiple:
    addi sp, sp, -8
    sw ra, 0(sp)
# begin scope
    ADDI t0, zero, 1
    addi sp, sp, -8
    sw t0, 0(sp)
    ADDI t0, zero, 0
    addi sp, sp, -8
    sw t0, 0(sp)
    ADDI t0, zero, 1000
    addi sp, sp, -8
    sw t0, 0(sp)
# begin forloop
# begin scope
# begin init
    ADDI t0, zero, 1
    addi sp, sp, -8
    sw t0, 0(sp)
# end init
# begin condition
TEMP_LABEL0_START:
    ADDI t0, zero, 1
    addi sp, sp, -8
    sw t0, 0(sp)
########## bound
    LW t0, 16(sp)
    lw t1, 0(sp)
    addi sp, sp, 8
    ADD t0, t0, t1
    addi sp, sp, -8
    sw t0, 0(sp)
########## i
    LW t0, 8(sp)
    lw t1, 0(sp)
    addi sp, sp, 8
    SLT t0, t0, t1
    BEQ t0, zero, TEMP_LABEL1_END
# end condition
# begin scope
    addi sp, sp, -8
    sw a0, 0(sp)
    addi sp, sp, -8
    sw a0, 0(sp)
########## x
    LW a0, 40(sp)
    call itoa
    lw a0, 0(sp)
    addi sp, sp, 8
    mv a0, s0
    call strlen
    lw a0, 0(sp)
    addi sp, sp, 8
    mv t0, s0
    addi sp, sp, -8
    sw t0, 0(sp)
LABEL3_START:
########## len
    LW t0, 0(sp)
    addi sp, sp, -8
    sw t0, 0(sp)
########## count
    LW t0, 32(sp)
    lw t1, 0(sp)
    addi sp, sp, 8
    XOR t0, t0, t1
    SNEZ t0, t0
    BEQ t0, zero, LABEL5_elifs
# begin scope
    la a0, StringLits1
########## x
    LW a1, 32(sp)
    call printf
    la a0, StringLits2
########## x
    LW a1, 32(sp)
    call printf
    la a0, StringLits3
########## len
    LW a1, 0(sp)
    call printf
########## len
    LW t0, 0(sp)
    SW t0, 24(sp)
# end scope
LABEL5_elifs:
LABEL4_END:
    ADDI t0, zero, 1
    addi sp, sp, -8
    sw t0, 0(sp)
########## x
    LW t0, 40(sp)
    lw t1, 0(sp)
    addi sp, sp, 8
    ADD t0, t0, t1
    SW t0, 32(sp)
# end scope
    ADDI sp, sp, 8
# begin update
TEMP_LABEL2_START:
    ADDI t0, zero, 1
    addi sp, sp, -8
    sw t0, 0(sp)
########## i
    LW t0, 8(sp)
    lw t1, 0(sp)
    addi sp, sp, 8
    ADD t0, t0, t1
    SW t0, 0(sp)
# end update
    J TEMP_LABEL0_START
TEMP_LABEL1_END:
# end scope
    ADDI sp, sp, 8
# end forloop
# end scope
    ADDI sp, sp, 24
    li s0, 0
    lw ra, 0(sp)
    addi sp, sp, 8
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
    .string "return of foo is : %d\n"
StringLits1:
    .string "number = %d\n"
StringLits2:
    .string " number = %d\n"
StringLits3:
    .string "new len = %d\n"
.section .bss
itoaTempBuffer:     
    .space 32
.extern printf
