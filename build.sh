#!/usr/bin/env sh

nasm -f elf64 main.asm -o triangulo.o
gcc triangulo.o round2.o -o triangulo -lm -no-pie -m64
