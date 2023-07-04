/*
Santos Mendez Ulises Jesus
Compiladores
Programa YACC donde se definen tokens y tipos
para realizar las producciones
***************************************
Compilacion
***************************************
yacc -d vector_calc.y
gcc y.tab.c init.c symbol.c vector_calc.c -o executable -lm
./calcvect
*/
%{
#include "symbol.h"
void yyerror (char *s);
int yylex ();
void warning(char *s, char *t);
#define code2(c1,c2)	 code(c1); code(c2);
#define code3(c1,c2,c3) code(c1); code(c2); code(c3);
%}

%union{
	Symbol *sym;
	Inst *inst;
}

%token<sym>  NUMBER PRINT VAR VARVECTOR VARESCALAR INDEF WHILE IF ELSE
%type   <inst>  stmt asgnVector asgnEscalar expVectorial expEscalar stmtlist cond while if end
%right '='
%left OR
%left AND
%left GT GE LT LE EQ NE
%left '+' '-'
%left '*'
%left 'x'
%left NOT
%right
%% 
list:   
	| list '\n'
	| list asgnVector '\n'   {code2(printVector, STOP); return 1; }
	| list asgnEscalar '\n'  {code2(printEscalar, STOP); return 1;}
    | list expVectorial '\n' {code2(printVector, STOP); return 1; }
	| list expEscalar '\n'   {code2(printEscalar, STOP); return 1;}
	| list stmt '\n'	{ code(STOP); return 1; }
	;   
asgnVector: VAR '=' expVectorial {$$=$3; code3(varpush, (Inst)$1, assignVector);} //Declaracion
	| VARESCALAR '=' expVectorial {$$=$3; code3(varpush, (Inst)$1, assignVector);} //Redefiniciones
	| VARVECTOR '=' expVectorial {$$=$3; code3(varpush, (Inst)$1, assignVector);}
	;
asgnEscalar: '#' VAR '=' expEscalar {$$=$4; code3(varpush, (Inst)$2, assignEscalar);} //Declaracion
	| '#' VARESCALAR '=' expEscalar {$$=$4; code3(varpush, (Inst)$2, assignEscalar);} //Redefiniciones
	| '#' VARVECTOR '=' expEscalar {$$=$4; code3(varpush, (Inst)$2, assignEscalar);}
	;
expVectorial:vector
	| VARVECTOR {$$=code3(varpush, (Inst)$1, evalVector);}
    | expVectorial '+' expVectorial  {code(add);}
    | expVectorial '-' expVectorial  {code(sub);}
    | expVectorial 'x' expVectorial  {code(cruz);}
    | expEscalar '*' expVectorial    {code(multiEscalarVect);}
	| expVectorial '*' expEscalar    {code(multiVectEscalar);}
    | '(' expVectorial ')'			 {$$ = $2;} 
	;
expEscalar: NUMBER {$$=code2(escalarpush, (Inst)$1);}
	| VARESCALAR {$$=code3(varpush, (Inst)$1, evalEscalar);}
	| '|' expVectorial '|' {code(magnitude);}
	| '|' expEscalar '|'   { $$ = $2; } 
	| expVectorial '*' expVectorial {code(punto);}
	| '(' expEscalar ')'   { $$ = $2; }
	;
//ESCALAR-ESCALAR 
    | expEscalar GT expEscalar          { code(gtEE); } 
	| expEscalar GE expEscalar          { code(geEE); }
	| expEscalar LT expEscalar          { code(ltEE); }
	| expEscalar LE expEscalar          { code(leEE); }
	| expEscalar EQ expEscalar          { code(eqEE); }
	| expEscalar NE expEscalar          { code(neEE); }
	| expEscalar AND expEscalar         { code(andEE); }
	| expEscalar OR expEscalar          { code(orEE); }
	| NOT expEscalar                    { $$ = $2; code(notE); } 
//VECTOR-VECTOR
    | expVectorial GT expVectorial      { code(gtVV); }
	| expVectorial GE expVectorial      { code(geVV); }
	| expVectorial LT expVectorial      { code(ltVV); }
	| expVectorial LE expVectorial      { code(leVV); }
	| expVectorial EQ expVectorial      { code(eqVV); }
	| expVectorial NE expVectorial      { code(neVV); }
	| expVectorial AND expVectorial     { code(andVV); }
	| expVectorial OR expVectorial      { code(orVV); }
	| NOT expVectorial                  { $$ = $2; code(notV); }
//ESCALAR-VECTOR
    | expEscalar GT expVectorial      { code(gtEV); }
	| expEscalar GE expVectorial      { code(geEV); }
	| expEscalar LT expVectorial      { code(ltEV); }
	| expEscalar LE expVectorial      { code(leEV); }
	| expEscalar EQ expVectorial      { code(eqEV); }
	| expEscalar NE expVectorial      { code(neEV); }
	| expEscalar AND expVectorial     { code(andEV); }
	| expEscalar OR expVectorial      { code(orEV); }
//VECTOR-ESCALAR
    | expVectorial GT expEscalar      { code(gtVE); }
	| expVectorial GE expEscalar      { code(geVE); }
	| expVectorial LT expEscalar      { code(ltVE); }
	| expVectorial LE expEscalar      { code(leVE); }
	| expVectorial EQ expEscalar      { code(eqVE); }
	| expVectorial NE expEscalar      { code(neVE); }
	| expVectorial AND expEscalar     { code(andVE); }
	| expVectorial OR expEscalar      { code(orVE); }
   ;
vector: '['listnum']' {code(vectorpush); }
	;
listnum:
	| NUMBER listnum {code2(numpush, (Inst)$1);}
	;
stmt:   asgnEscalar                   { code(pop1); }
    | asgnVector                   { code(pop1); }
	| PRINT expEscalar                { code(prexpresc); $$ = $2;}
	| PRINT expVectorial              { code(prexprvec); $$ = $2;}
	| while cond stmt end             { ($1)[1] = (Inst)$3;     /* cuerpo de la iteracion */ 
		                                 ($1)[2] = (Inst)$4; }   /* terminar si la condicion no se cumple */
	| if cond stmt end                {    /* proposicion if que no emplea else */ 
		                                 ($1)[1] = (Inst)$3;     /* parte then */ 
		                                 ($1)[3] = (Inst)$4;
                                     }   /* terminar si la condicion no se cumple */ 
	| if cond stmt end ELSE stmt end  {  /* proposicion if con parte else */
                                       ($1)[1]   =   (Inst)$3;	/*  parte then  */
                                       ($1)[2]   =   (Inst)$6;	/* parte else   */
                                       ($1)[3]   =   (Inst)$7;   } /*   terminar si la condicion no se cumple  */
	|   '{'   stmtlist   '}'          {   $$  =  $2;   }
   ;
cond:	'('   expEscalar   ')'    {   code(STOP);  $$  =  $2;   }
   ;
while:	WHILE   {   $$ = code3(whilecode,STOP,STOP); }
	;
if:     IF   { $$=code(ifcode); code3(STOP, STOP, STOP); }
	;
end:      /* nada */{ code(STOP); $$ = progp; }
	;
stmtlist: /* nada */	{ $$ = progp; }
	| stmtlist '\n' 
	| stmtlist stmt
	;   
%%

#include <stdio.h>
#include <ctype.h>
#include <setjmp.h>

jmp_buf begin;

int lineno = 1;

void init(){
	initConstants();
}

void main (){
	init();
	setjmp(begin);
  	for(initcode(); yyparse (); initcode())
		execute(prog);
}

//Analizador lexico de YACC
int yylex (){
  	int c;

  	while ((c = getchar ()) == ' ' || c == '\t') 
  		; //enunciado nulo
 	if (c == EOF)                            
    	return 0;
  	if (c == '.' || isdigit (c)) {//NUM
		double d;
    	ungetc (c, stdin);
      	scanf ("%lf", &d);//lexema
		yylval.sym=install("",NUMBER,d);
	    return NUMBER;//tipo token
    }
  	if(isalpha(c) && c!=120){//ID & diferente de x
		Symbol *s;
		char sbuf[200], *p=sbuf;
		do {
			if(p >= sbuf + sizeof(sbuf)-1){
				*p = '\0';
				printf("\x1b[31m%s\n\x1b[0m", "name too long");
			}
		*p++ = c;
		} while ((c=getc(stdin)) != EOF && isalnum(c));
		ungetc(c, stdin);
		*p='\0';
		if((s=lookup(sbuf))==(Symbol *)NULL)
			s=install(sbuf, INDEF, 0.0);
		yylval.sym=s;  
		return s->type==INDEF ? VAR : s->type; 
	}
	switch (c) {
      case '>':                return follow('=', GE, GT);
      case '<':                return follow('=', LE, LT);
      case '=':                return follow('=', EQ, '=');
      case '!':                return follow('=', NE, NOT);
      case '|':                return follow('|', OR, '|');
      case '&':                return follow('&', AND, '&');
      case '\n':              lineno++; return '\n';
      default:                  return c; 
      }
}
follow(int expect,   int ifyes,   int ifno){  /*   buscar  >=, etc.   */ 
   int c  = getchar();
   if  (c  ==  expect)
   return ifyes; 
   ungetc(c,   stdin); 
   return  ifno;
}                       
void yyerror(char* s) { 
  printf("\x1b[31m%s\n\x1b[0m", s); 
  /* longjmp(begin, 0); */
  return ; 
}
