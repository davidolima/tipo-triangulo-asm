#include <stdio.h>

double round2(double numero) {
    double arredondado = (int)(numero * 100 + 0.5) / 100.0;
    return arredondado;
}

