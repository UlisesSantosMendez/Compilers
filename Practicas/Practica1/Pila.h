/*
Santos Mendez Ulises Jesus
Compiladores
Cabecera que incluye las funciones para hacer
push y pop con la pila
***************************************
Compilacion
***************************************
gcc Pila.h -lm
*/
#ifndef PILA_H
#define PILA_H

#include <stdlib.h>

typedef struct Stack{
	double dato;
	struct Stack *sig;
}*Pila;

Pila empty();

Pila push(double e, Pila p);

int isEmpty(Pila p);

double top(Pila p);

Pila pop(Pila p);

int size(Pila p);

#endif