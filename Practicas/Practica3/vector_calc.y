/*
Santos Mendez Ulises Jesus
Compiladores
Programa YACC donde se definen tokens y tipos
para realizar las producciones
***************************************
Compilacion
***************************************
yacc -d vector_calc.y
gcc y.tab.c init.c Pila.c symbol.c vector_calc.c -o executable -lm
./calcvect
*/
%{
#include "vector_calc.h"
#include "symbol.h"
void yyerror (char *s);
int yylex ();
void warning(char *s, char *t);
%}

%union{
	double num;
	Vector *vect;
	Symbol *sym;
}
%token<num> NUMBER
%token<sym> VAR VARVECTOR VARESCALAR INDEF
%type<vect> vector
%type<vect> expVectorial asgnVector
%type<num> expEscalar asgnEscalar


%left '+' '-'
%left '*'
%left 'x'
%% 
list:   
	| list '\n'
	| list asgnVector '\n'   {imprimeVector($2);}
	| list asgnEscalar '\n'  {printf("\033[0;36m%f\n\033[0;0m", $2);}
    | list expVectorial '\n' {imprimeVector($2); }
	| list expEscalar '\n'   {printf("\033[0;36m%f\n\033[0;0m", $2); }
	;   
asgnVector: VAR '=' expVectorial {$$= $1->u.varVector = $3; $1->type=VARVECTOR;} //Declaracion
	| VARESCALAR '=' expVectorial {$$= $1->u.varVector = $3; $1->type=VARVECTOR;} //Redefiniciones
	| VARVECTOR '=' expVectorial {$$= $1->u.varVector = $3; $1->type=VARVECTOR;}
	;
asgnEscalar: '#' VAR '=' expEscalar {$$= $2->u.varEscalar = $4; $2->type=VARESCALAR;} //Declaracion
	| '#' VARESCALAR '=' expEscalar {$$= $2->u.varEscalar = $4; $2->type=VARESCALAR;} //Redefiniciones
	| '#' VARVECTOR '=' expEscalar {$$= $2->u.varEscalar = $4; $2->type=VARESCALAR;}
	;
expVectorial:vector       { $$ = $1; }
	| VAR {printf("\x1b[31mVariable no definida: %s\x1b[0m\n",$1->name);$$=NULL;}
	| VARVECTOR {$$=$1-> u.varVector;}
    | expVectorial '+' expVectorial  {$$ = ($1==NULL || $3==NULL)?NULL:sumaVector($1,$3);}
    | expVectorial '-' expVectorial  { $$ = ($1==NULL || $3==NULL)?NULL:restaVector($1,$3);}
    | expVectorial 'x' expVectorial  { $$ = ($1==NULL || $3==NULL)?NULL:cruzVector($1,$3);}
    | expEscalar '*' expVectorial    { $$ = ($3=NULL)?NULL:multiplicaEscalarVector($1,$3);}
	| expVectorial '*' expEscalar    { $$ = ($1=NULL)?NULL:multiplicaEscalarVector($3,$1);}
    | '(' expVectorial ')'     { $$ = $2;}
	;
expEscalar: NUMBER {$$ = $1; }
	| VARESCALAR {$$=$1->u.varEscalar;}
	| '|' expVectorial '|' {$$ =($2=NULL)?0:magnitudVector($2);}
	| '|' expEscalar '|' {$$ = $2; }
	| expVectorial '*' expVectorial {$$ = ($1==NULL || $3==NULL)?0:puntoVector($1,$3);}
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
	initConstants();
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
  	if(isalpha(c) && c!=120){//ID & diferente de x
		Symbol *s;
		char sbuf[200], *p=sbuf;
		do {
			*p++=c;
		} while ((c=getchar())!=EOF && isalnum(c));
		ungetc(c, stdin);
		*p='\0';
		if((s=lookup(sbuf))==(Symbol *)NULL)
			s=install(sbuf, INDEF, 0.0);
		yylval.sym=s;   
      if(s->type == INDEF){
         return VAR; //VAR SIN DEFINIR
      } else {
         return s->type;//VARESCALAR o VARVECTORIAL
      }
	}
	if(c=='\n')
		lineno++;
	return c;
}
                          
void yyerror(char* s) { 
  printf("\x1b[31m%s\n\x1b[0m", s); 
  return ; 
}