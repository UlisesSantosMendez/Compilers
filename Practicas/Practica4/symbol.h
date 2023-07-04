#include "vector_calc.h"

typedef struct Symbol{
    char *name;
    short type;
    union {
        double varEscalar;
        Vector *varVector;
    }u;
    struct Symbol *next;
} Symbol;

Symbol *install(char *s,int t, double d), *lookup(char *s);

typedef union Datum {   /* tipo de la pila del interprete */
   double num;
   Vector *vect;
   Symbol *sym;
} Datum; 

extern Datum pop();
typedef void (*Inst)(void);  /* instruccion de maquina */ 

#define STOP    (Inst) 0
extern	Inst prog[];
extern void numpush();
extern void vectorpush();
extern void escalarpush();
extern void varpush();
extern void evalEscalar();
extern void evalVector();
extern void assignEscalar();
extern void assignVector();
extern void add();
extern void sub(); 
extern void cruz(); 
extern void multiEscalarVect(); 
extern void multiVectEscalar(); 
extern void magnitude(); 
extern void punto(); 
extern void printVector();
extern void printEscalar();