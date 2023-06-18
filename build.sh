#!/usr/bin/env sh

nasm -g -f elf64 -F dwarf main.asm -o triangulo.o
gcc triangulo.o -o triangulo -lm -no-pie -m64
