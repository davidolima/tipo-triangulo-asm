; Define variables in the data section
section .data
	p1text  db "Insira o primeiro ponto (x1, y1):",10,0
	p1textlen  equ $-p1text
    p2text  db "Insira o segundo ponto (x2, y2):",10,0
	p2textlen  equ $-p2text
    p3text  db "Insira o terceiro ponto (x3, y3):",10,0
	p3textlen  equ $-p3text
    ponto:  db "(%d, %d):",10,0
	pontotlen:  equ $-p3text

    fm:  db "%d",0

section .bss
    x1:  resb 8
    y1:  resb 8
    x2:  resb 8
    y2:  resb 8
    x3:  resb 8
    y3:  resb 8
    d12:  resb 8
    d23:  resb 8
    d13:  resb 8

section .text
	global main
    extern printf, scanf, pow

%macro calcDist 2
    mov rdi, %1
    mov rsi, %2
    call pow
%endmacro

main:
    push rbp
    mov rbp, rsp

    ;; Ponto 1
    mov rdi, p1text
    mov rax, 0
    call printf

    mov     rdi, fm
    mov     rsi, x1
    mov     rax, 0
    call    scanf

    mov     rdi, fm
    mov     rsi, y1
    mov     rax, 0
    call    scanf

    ;; Ponto 2
    mov rdi, p2text
    mov rax, 0
    call printf

    mov     rdi, fm
    mov     rsi, x2
    mov     rax, 0
    call    scanf

    mov     rdi, fm
    mov     rsi, y2
    mov     rax, 0
    call    scanf

    ;; Ponto 3
    mov rdi, p3text
    mov rax, 0
    call printf

    mov     rdi, fm
    mov     rsi, x3
    mov     rax, 0
    call    scanf

    mov     rdi, fm
    mov     rsi, y3
    mov     rax, 0
    call    scanf

    ;; Calcular distancias
    calcDist([x1],[y1])

    ;; Finalizar programa
    mov rax, 60
    mov rdi, 0
    syscall
