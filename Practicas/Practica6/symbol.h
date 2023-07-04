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
extern	Inst prog[],*progp, *code();
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
extern void pop1();
extern void whilecode();
extern void ifcode();
extern void prexpresc();
extern void prexprvec();
extern	void gtEE();
extern	void ltEE(); 
extern	void eqEE(); 
extern	void geEE(); 
extern	void leEE(); 
extern	void neEE(); 
extern	void andEE(); 
extern	void orEE();
extern	void notE();
extern	void gtVV();
extern	void ltVV(); 
extern	void eqVV(); 
extern	void geVV(); 
extern	void leVV(); 
extern	void neVV(); 
extern	void andVV(); 
extern	void orVV();
extern	void notV();
extern	void gtEV();
extern	void ltEV(); 
extern	void eqEV(); 
extern	void geEV(); 
extern	void leEV(); 
extern	void neEV(); 
extern	void andEV(); 
extern	void orEV();
extern	void gtVE();
extern	void ltVE(); 
extern	void eqVE(); 
extern	void geVE(); 
extern	void leVE(); 
extern	void neVE(); 
extern	void andVE(); 
extern	void orVE();
extern void forcode();