section .data
    formato_entrada: dq "%lf %lf", 0
    formato_saida2: dq "%lf", 0
    formato_saida: db "%s", 0    
    msg_coordenadas_ponto_1: db "Digite as coordenadas do primeiro ponto (x,y): ", 0
    msg_coordenadas_ponto_2: db "Digite as coordenadas do segundo ponto (x,y): ", 0
    msg_coordenadas_ponto_3: db "Digite as coordenadas do terceiro ponto (x,y): ", 0
    msg_distancia_1: db "Primeira distância: %.2f", 10, 0
    msg_distancia_2: db "Segunda distância: %.2f", 10, 0
    msg_distancia_3: db "Terceira distância: %.2f", 10, 0
    msg_equilatero: db "O triângulo é equilátero.", 10, 0
    msg_isosceles: db "O triângulo é isósceles.", 10, 0
    msg_escaleno: db "O triângulo é escaleno.", 10, 0

section .bss
    x1: resq 1
    y1: resq 1
    x2: resq 1
    y2: resq 1
    x3: resq 1
    y3: resq 1
    distancia1: resq 1
    distancia2: resq 1
    distancia3: resq 1

section .text
    extern printf
    extern scanf   

global main
main:       
    push rbp
    mov rbp, rsp

    ; Primeiro Ponto    
    lea rdi, [msg_coordenadas_ponto_1]
    call printf

    
    lea rdi, [formato_entrada]
    lea rsi, [x1]
    lea rdx, [y1]
    call scanf

    ; Segundo Ponto  
    lea rdi, [msg_coordenadas_ponto_2]
    call printf

    
    lea rdi, [formato_entrada]
    lea rsi, [x2]
    lea rdx, [y2]
    call scanf

    ; Terceiro Ponto
    
    lea rdi, [msg_coordenadas_ponto_3]
    call printf

    
    lea rdi, [formato_entrada]
    lea rsi, [x3]
    lea rdx, [y3]
    call scanf

    ; Exibe valor do X1
    mov rdi, formato_saida2
    movq xmm0, [y1]
    call printf

    leave