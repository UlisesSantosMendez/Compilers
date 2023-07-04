/*
Santos Mendez Ulises Jesus
Compiladores
Programa YACC donde se definen tokens y tipos
para realizar las producciones
***************************************
Compilacion
***************************************
yacc vector_calc.y
gcc y.tab.c -o calcvect -lm
./calcvect
*/
%{
#include "vector_calc.h"
void yyerror (char *s);
int yylex ();
void warning(char *s, char *t);
%}

%union{
	double num;
	Vector *vect;
}
%token<num> NUMBER
%type<vect> vector
%type<vect> expVectorial
%type<num> expEscalar


%left '+' '-'
%left '*'
%left 'x'
%% 
list:   
	| list '\n'
    | list expVectorial '\n' {imprimeVector($2); }
	| list expEscalar '\n'   {printf("\033[0;36m%f\n\033[0;0m", $2); }
	;    
expVectorial:vector       { $$ = $1; }
    | expVectorial '+' expVectorial  { $$ = sumaVector($1,$3);}
    | expVectorial '-' expVectorial  { $$ = restaVector($1,$3);}
    | expVectorial 'x' expVectorial  { $$ = cruzVector($1,$3);}
    | expEscalar '*' expVectorial    { $$ = multiplicaEscalarVector($1,$3);}
	| expVectorial '*' expEscalar    { $$ = multiplicaEscalarVector($3,$1);}
    | '(' expVectorial ')'     { $$ = $2;}
	;
expEscalar: NUMBER {$$ = $1; }
	| '|' expVectorial '|' {$$ = magnitudVector($2);}
	| '|' expEscalar '|' {$$ = $2; }
	| expVectorial '*' expVectorial {$$ = puntoVector($1,$3);}
	| '(' expEscalar ')' {$$ = $2;}
	;
vector: '['listnum']' {$$ = creaVectorEntrada(); }
	;
listnum:
	| NUMBER listnum {aux=push($1,aux);}
	;
%%

#include <stdio.h>
#include <ctype.h>
#include "Pila.h"

Pila aux; // Pila que permitira llenar el vector
int lineno = 1;

Vector *creaVectorEntrada(){
   int sizeStack=size(aux);
   Vector *vec=creaVector(sizeStack);
   int i=0;
   for(i=0;i<sizeStack;i++){
       vec->vec[i] = top(aux);
       aux=pop(aux);
   }
   return vec;
}

void init(){
	Pila aux=empty();
}

void main (){
	init();
  	yyparse ();
}

//Analizador lexico de YACC
int yylex (){
  	int c;

  	while ((c = getchar ()) == ' ' || c == '\t') 
  		; //enunciado nulo
 	if (c == EOF)                            
    		return 0;
  	if (c == '.' || isdigit (c)) {//NUM
      	        ungetc (c, stdin);
      		scanf ("%lf", &yylval.num);//lexema
	      return NUMBER;//tipo token
    	}
  	if(c == '\n')
		lineno++;
  	return c;  //+, -, *, x, [, ]                            
}
void yyerror(char* s) { 
  printf("\x1b[31m%s\n\x1b[0m", s); 
  return ; 
}