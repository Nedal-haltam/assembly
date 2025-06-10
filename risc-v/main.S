.equ SYS_WRITE, 64
.equ SYS_EXIT, 93

num:
	.word 123456789
newline:
	.string "\n"
msg:
	.string "Hello, world, my name is nedal\n"

.section .bss
buffer:     
	.space 32

.section .text
.globl _start

_start:
    la a1, msg
	call strlen
	mv a2, a0	
    li a0, 1
	call write

    # Load number and convert it to string
    la a0, buffer        # buffer address
    la t0, num
    lw a1, 0(t0)         # load integer into a1
    call itoa            # convert to string

    # Calculate string length
    mv a1, a0            # a0 = pointer to string; move to a1
    call strlen
    mv a2, a0            # a2 = length
    li a0, 1             # stdout
    li a7, SYS_WRITE
    la a1, buffer        # buffer contains the string
    ecall

    # Print newline
    li a0, 1
    la a1, newline
    li a2, 1
    call write

    # Exit
    li a0, 0
	call exit

# --------------------------------------
# itoa: converts integer in a1 to string in buffer at a0
# inputs: a0 = buffer address, a1 = integer to convert
# outputs: a0 = pointer to string in buffer
itoa:
    addi sp, sp, -8
    sw ra, 8(sp)

    mv t1, a1            # number to convert
    addi t2, a0, 11      # write digits from end
    sb zero, 0(t2)       # null terminator

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
    mv a0, t2            # a0 = pointer to start of string
    # Copy result to beginning of buffer
    la t3, buffer
copy_loop:
    lbu t4, 0(a0)
    beqz t4, copy_done
    sb t4, 0(t3)
    addi a0, a0, 1
    addi t3, t3, 1
    j copy_loop
copy_done:
    sb zero, 0(t3)

    lw ra, 8(sp)
    addi sp, sp, 8
    la a0, buffer        # return buffer pointer
    ret


# --------------------------------------
# strlen: calculates length of string in a1
# returns length in a0
strlen:
    mv t0, a1
    li a0, 0
strlen_loop:
    lbu t1, 0(t0)
    beqz t1, strlen_done
    addi a0, a0, 1
    addi t0, t0, 1
    j strlen_loop
strlen_done:
    ret


write:
    li a7, SYS_WRITE
    ecall
	ret

exit:
	li a7, SYS_EXIT
	ecall
	ret
