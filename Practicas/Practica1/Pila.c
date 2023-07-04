//
//Santos Mendez Ulises Jesus
//Compiladores
//Implementacion de la pila en donde se
//van a guardar los datos en el orden que
//se ingrese en el teclado
//***************************************
//                Compilacion
//***************************************
//gcc Pila.c -o pila -lm
//./pila
//

#include "Pila.h"

Pila empty(){
	return NULL;
}

Pila push(double e, Pila p){
	Pila t=(Pila)malloc(sizeof(struct Stack));
	t->dato=e;
	t->sig=p;
	return t;
}

int isEmpty(Pila p){
	return p==NULL;
}

double top(Pila p){
	return p->dato;
}

Pila pop(Pila p){
	return p->sig;
}

int size(Pila p){
	if(isEmpty(p))
		return 0;
	else
		return size(pop(p))+1;
}