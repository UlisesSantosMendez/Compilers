/*
Santos Mendez Ulises Jesus
Compiladores
Cabecera que incluye las funciones para realizar
las operaciones con vectores
***************************************
Compilacion y ejecucion
***************************************
gcc vector_calc.h -lm
./calculadora
*/

#ifndef VECTOR_H
#define VECTOR_H
#include<stdio.h>
#include<math.h>
#include<stdlib.h>

struct vector {
	char name;
	int n;
	double *vec;
};
typedef struct vector Vector;
Vector *creaVector(int n);
void imprimeVector(Vector *a);
int vectoresIguales(Vector *a, Vector *b);
Vector *sumaVector(Vector *a, Vector *b);
Vector *restaVector(Vector *a, Vector *b);
Vector *cruzVector(Vector *a, Vector *b);
double puntoVector(Vector *a, Vector *b);
Vector *multiplicaEscalarVector(double num, Vector *a);
double magnitudVector(Vector *a);


#endif
