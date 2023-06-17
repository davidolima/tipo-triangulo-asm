section .data
    p1text      db "Insira o primeiro ponto (x1, y1):",10,0
    p1textlen   equ $-p1text
    p2text      db "Insira o segundo ponto (x2, y2):",10,0
    p2textlen   equ $-p2text
    p3text      db "Insira o terceiro ponto (x3, y3):",10,0
    p3textlen   equ $-p3text
    ponto       db "(%lf, %lf):",10,0
    pontotlen   equ $-ponto
    fm          db "%lf",10,0

section .bss
    x1 resq 1
    y1 resq 1
    x2 resq 1
    y2 resq 1
    x3 resq 1
    y3 resq 1
    d12 resq 1
    d23 resq 1
    d13 resq 1

section .text
    global main
    extern printf, scanf, sqrt

main:
    push rbp
    mov rbp, rsp

    ;; Ponto 1
    mov rdi, p1text
    mov rax, 0
    call printf

    mov rdi, fm
    mov rsi, x1
    mov rax, 0
    call scanf

    mov rdi, fm
    mov rsi, y1
    mov rax, 0
    call scanf

    ;; Ponto 2
    mov rdi, p2text
    mov rax, 0
    call printf

    mov rdi, fm
    mov rsi, x2
    mov rax, 0
    call scanf

    mov rdi, fm
    mov rsi, y2
    mov rax, 0
    call scanf

    ;; Ponto 3
    mov rdi, p3text
    mov rax, 0
    call printf

    mov rdi, fm
    mov rsi, x3
    mov rax, 0
    call scanf

    mov rdi, fm
    mov rsi, y3
    mov rax, 0
    call scanf

    ;; Calcular distâncias
    movsd xmm0,  [x2]
    subsd xmm0,  [x1]
    mulsd xmm0, xmm0
    movsd  [d12], xmm0

    movsd xmm0,  [y2]
    subsd xmm0,  [y1]
    mulsd xmm0, xmm0
    addsd xmm0,  [d12]
    movsd  [d12], xmm0

    movsd xmm0,  [x3]
    subsd xmm0,  [x2]
    mulsd xmm0, xmm0
    movsd  [d23], xmm0

    movsd xmm0,  [y3]
    subsd xmm0,  [y2]
    mulsd xmm0, xmm0
    addsd xmm0,  [d23]
    movsd  [d23], xmm0

    movsd xmm0,  [x3]
    subsd xmm0,  [x1]
    mulsd xmm0, xmm0
    movsd  [d13], xmm0

    movsd xmm0,  [y3]
    subsd xmm0,  [y1]
    mulsd xmm0, xmm0
    addsd xmm0,  [d13]
    movsd  [d13], xmm0

    ;; Calcular raiz quadrada das distâncias
    movsd xmm0,  [d12]
    sqrtsd xmm0, xmm0
    movsd  [d12], xmm0

    movsd xmm0,  [d23]
    sqrtsd xmm0, xmm0
    movsd  [d23], xmm0

    movsd xmm0,  [d13]
    sqrtsd xmm0, xmm0
    movsd  [d13], xmm0

    ;; Classificar triângulo
    mov rdi, ponto
    mov rax, 0
    mov rax, 1
    movsd xmm0,  [x1]
    movsd xmm1,  [y1]
    call printf

    mov rdi, ponto
    mov rax, 0
    mov rax, 1
    movsd xmm0,  [x2]
    movsd xmm1,  [y2]
    call printf

    mov rdi, ponto
    mov rax, 0
    mov rax, 1
    movsd xmm0,  [x3]
    movsd xmm1,  [y3]
    call printf

    mov rdi, fm
    mov rax, 0
    mov rax, 1
    movsd xmm0,  [d12]
    movsd xmm1,  [d12+8]
    call printf

    mov rdi, fm
    mov rax, 0
    mov rax, 1
    movsd xmm0, [d23]
    movsd xmm1, [d23+8]
    call printf

    mov rdi, fm
    mov rax, 0
    mov rax, 1
    movsd xmm0,  [d13]
    movsd xmm1,  [d13+8]
    call printf

    ;; Finalizar programa
    mov rax, 0
    xor rdi, rdi
    mov rsp, rbp
    pop rbp
    ret
