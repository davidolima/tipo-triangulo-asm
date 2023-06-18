section .data
    p1text db "Insira o primeiro ponto (x1, y1): ",0

    p2text db "Insira o segundo ponto (x2, y2): ",0
    flag db "Dois lados iguais", 0, 10
    p3text db "Insira o terceiro ponto (x3, y3): ",0
 

    pontosInseridos db "Pontos inseridos (p1, p2 e p3, respectivamente):",10,0
    pontosInseridoslen equ $-pontosInseridos

    equilatero db "Os pontos formam um triângulo equilatero.",10,0    
    escaleno db "Os pontos formam um triângulo escaleno.",10,0   
    isosceles db "Os pontos formam um triângulo isosceles.",10,0
    

    formatacao_exibe_distancia db "Distância: %lf", 10 ,0    

    formatacao_exibe_ponto db "(%lf, %lf)",10,0    

    formatacao_entrada db "%lf %lf",0

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
extern printf, scanf
extern round2

%macro print 1
    mov rdi, %1
    call printf
%endmacro

%macro printDist 1
    ;; %1 -> valor
    mov rdi, formatacao_exibe_distancia
    movsd xmm0, qword [%1]
    
    call printf
%endmacro

%macro arredondaResultado 1
    movq xmm0, [%1]
    call round2
    movq [%1], xmm0
%endmacro

%macro printPonto 2
    mov rdi, formatacao_exibe_ponto
    movsd xmm0, qword [%1]
    movsd xmm1, qword [%2]
    call printf
%endmacro

%macro lerPonto 3
    print %3

    mov rdi, formatacao_entrada
    mov rsi, %1
    mov rdx, %2
    call scanf
%endmacro

main:
    ;; Setar o rbp para a base da pilha
    push rbp
    ;;  Stack pointer apontando para a base
    mov rbp, rsp

    ;; Leitura de pontos
    lerPonto x1, y1, p1text ;; Ponto 1
    lerPonto x2, y2, p2text ;; Ponto 2
    lerPonto x3, y3, p3text ;; Ponto 3

    ;; Printar os pontos
    print pontosInseridos ;; "Pontos inseridos (p1, p2, p3):"

    printPonto x1, y1
    printPonto x2, y2
    printPonto x3, y3

    ;; Calcular distância

    movsd xmm0, qword [x1]
    movsd xmm1, qword [x2]
    movsd xmm2, qword [y1]
    movsd xmm3, qword [y2]
    call calcularDistancia
    movsd qword [d12], xmm0
    arredondaResultado d12

    movsd xmm0, qword [x1]
    movsd xmm1, qword [x3]
    movsd xmm2, qword [y1]
    movsd xmm3, qword [y3]
    call calcularDistancia
    movsd qword [d13], xmm0
    arredondaResultado d13

    movsd xmm0, qword [x2]
    movsd xmm1, qword [x3]
    movsd xmm2, qword [y2]
    movsd xmm3, qword [y3]
    call calcularDistancia
    movsd qword [d23], xmm0
    arredondaResultado d23      
   
    printDist d12
    printDist d13
    printDist d23  

    ;; Avaliar tipo do triângulo
    movsd xmm0, [d12]
    movsd xmm1, [d13]
    movsd xmm2, [d23]   

    comisd xmm0, xmm1
    je doisLadosIguais    
    jmp doisLadosDiferentes

doisLadosIguais:    
    comisd xmm0, xmm2
    je isEquilatero
    jmp isIsosceles

doisLadosDiferentes:
    comisd xmm0, xmm2
    je isIsosceles    

    comisd xmm1, xmm2
    jne isEscaleno
    jmp isIsosceles

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
    subsd xmm0, xmm1
    mulsd xmm0, xmm0

    subsd xmm2, xmm3
    mulsd xmm2, xmm2

    addsd xmm0, xmm2

    sqrtsd xmm0, xmm0
    ret

finalizar:
    ;; Finalizar programa
    mov rax, 0
    mov rbx, 0
    leave
    ret