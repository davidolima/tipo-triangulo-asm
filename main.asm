; Define variables in the data section
section .data
	p1text  db "Insira o primeiro ponto (x1, y1):",10,0
	p1textlen  equ $-p1text
    p2text  db "Insira o segundo ponto (x2, y2):",10,0
	p2textlen  equ $-p2text
    p3text  db "Insira o terceiro ponto (x3, y3):",10,0
	p3textlen  equ $-p3text
    pontosInseridos:  db "Pontos inseridos (p1, p2 e p3, respectivamente):",10,0
	pontosInseridoslen:  equ $-pontosInseridos
    ponto:  db "(%d, %d)",10,0
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

%macro printPonto 2
    mov rdi, ponto
    mov rsi, [%1]
    mov rdx, [%2]
    call printf
%endmacro

%macro lerPonto 3
    mov rdi, %3
    mov rax, 0
    call printf

    mov     rdi, fm
    mov     rsi, %1
    mov     rax, 0
    call    scanf

    mov     rdi, fm
    mov     rsi, %2
    mov     rax, 0
    call    scanf
%endmacro

main:
    ;; Setar o rbp para a base da pilha
    push rbp
    ;;  Stack pointer apontando para a base
    mov rbp, rsp

    ;; Leitura de pontos
    lerPonto x1, y1, p1text    ;; Ponto 1
    lerPonto x2, y2, p2text    ;; Ponto 2
    lerPonto x3, y3, p3text    ;; Ponto 3

    ;; Printar os pontos
    mov rdi, pontosInseridos    ; "Pontos inseridos (p1, p2, p3):"
    mov rax, 0
    call printf

    printPonto x1, y1
    printPonto x2, y2
    printPonto x3, y3

    ;; Finalizar programa
    mov rax, 60
    mov rdi, 0
    syscall
