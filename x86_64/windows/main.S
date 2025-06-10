section .text
    global main
    extern GetStdHandle
    extern WriteConsoleA
    extern ExitProcess

main:
    ; Align the stack to 16 bytes before call
    sub rsp, 40

    mov ecx, -11
    call GetStdHandle
    mov rbx, rax                   ; store handle

    ; WriteConsoleA(handle, msg, len, &written, NULL)
    mov rcx, rbx                   ; hConsole
    lea rdx, [rel msg]         ; lpBuffer
    mov r8d, msg_len               ; nNumberOfCharsToWrite
    sub rsp, 8                     ; allocate 8 bytes for lpNumberOfCharsWritten
    lea r9, [rsp]                  ; lpNumberOfCharsWritten
    xor r10, r10                   ; lpReserved = NULL
    call WriteConsoleA
    add rsp, 8                     ; restore stack

    ; ExitProcess(0)
    mov ecx, 1234
    call ExitProcess

section .data
    msg     db "Hello, World!", 0x0A
    msg_len equ $ - msg
