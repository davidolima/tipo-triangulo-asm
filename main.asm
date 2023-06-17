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

    equilatero  db "Os pontos formam um triângulo equilatero.",10,0
	equilaterolen  equ $-equilatero
    escaleno  db "Os pontos formam um triângulo escaleno.",10,0
	escalenolen  equ $-escaleno
    isosceles  db "Os pontos formam um triângulo isosceles.",10,0
	isosceleslen  equ $-isosceles

    dist:  dw "Distância: %f",10,0
    distlen: equ $-dist

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
    d12: resq 1
    d23: resq 1
    d13: resq 1
    r:   resq 1

section .text
	global main
    extern printf, scanf, sqrt

%macro print 1
    mov rdi, %1
    mov rax, 0
    call printf
%endmacro

%macro printDist 1
    ;; %1 -> valor
    mov rdi, dist
    movsd xmm0, [%1]
    call printf
%endmacro

%macro printPonto 2
    mov rdi, ponto
    mov rsi, [%1]
    mov rdx, [%2]
    call printf
%endmacro

%macro lerPonto 3
    print %3
    
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
    print pontosInseridos    ; "Pontos inseridos (p1, p2, p3):"

    printPonto x1, y1
    printPonto x2, y2
    printPonto x3, y3

    ;; Calcular distância

    mov r8, [x1]
    mov r9, [y1]
    mov r10, [x2]
    mov r11, [y2]
    call calcularDistancia
    printDist r
    movq xmm0, [r]
    movq [d12], xmm0

    mov r8, [x1]
    mov r9, [y1]
    mov r10, [x3]
    mov r11, [y3]
    call calcularDistancia
    movq xmm0, [r]
    movq [d13], xmm0

    mov r8, [x2]
    mov r9, [y2]
    mov r10, [x3]
    mov r11, [y3]
    call calcularDistancia
    movq xmm0, [r]
    movq [d23], xmm0

    printDist d12
    printDist d13
    printDist d23

    ;; Avaliar tipo do triângulo
    mov rax, [d12]
    mov rbx, [d13]

    cmp rax, rbx                ; d12 == d13?
    jne doisLadosDiferentes

    mov rbx, [d23]

    cmp rax, rbx                ; d12 == d23?
    je  isEquilatero            ; d12 == d13 == d23

    jmp isIsosceles             ; d12 == d13 != d23

doisLadosDiferentes:            ; d12 != d13
    mov rcx, [d23]
    cmp rax, rcx
    jne d12_ne_d13_ne_d23

    jmp isIsosceles             ; d13 != d12 == d23

d12_ne_d13_ne_d23:
    cmp rbx, rcx                ; d13 == d23?
    jne isEscaleno              ; d12 != d13 != d23

isEscaleno:
    print escaleno
    jmp finalizar

isIsosceles:
    print isosceles
    jmp finalizar

isEquilatero:
    print equilatero
    jmp finalizar

calcularDistancia:
    ;; espera que x1 esteja em r8 e y1 em r9
    ;; espera que x2 esteja em r10 e y2 em r11
    ;; sqrt((x2-x1)^2+(y2-y1)^2)
    ;; mov dword [r], 0          ; zerar r

    ;; sub r8, r9                  ;x2-x1
    ;; sub r10, r11                ;y2-y1

    ;; imul r8, r8                 ;(x2-x1)^2
    ;; imul r10, r10               ;(y2-y1)^2

    ;; add r8, r10                 ;(x2-x1)^2+(y2-y1)^2
    ;; mov [r], r8

    ;; fld qword [r]
    ;; fsqrt                       ;sqrt((x2-x1)^2+(y2-y1)^2)
    ;; fstp qword [r]

    ;; ;; retorna em r
    ;; ret
    fld qword [r8]
    fsub qword [r10]
    fld qword [r9]
    fsub qword [r11]
    fmulp st1, st0
    fmul st0, st0
    fld1
    faddp st1, st0
    fsqrt

    fstp qword [r]
    ret

finalizar:
    ;; Finalizar programa
    mov rdi, [r]
    mov rax, 60
    syscall
