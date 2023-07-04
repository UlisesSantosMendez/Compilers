#ifndef _yy_defines_h_
#define _yy_defines_h_

#define NUMBER 257
#define VAR 258
#define VARVECTOR 259
#define VARESCALAR 260
#define INDEF 261
#ifdef YYSTYPE
#undef  YYSTYPE_IS_DECLARED
#define YYSTYPE_IS_DECLARED 1
#endif
#ifndef YYSTYPE_IS_DECLARED
#define YYSTYPE_IS_DECLARED 1
typedef union YYSTYPE{
	double num;
	Vector *vect;
	Symbol *sym;
} YYSTYPE;
#endif /* !YYSTYPE_IS_DECLARED */
extern YYSTYPE yylval;

#endif /* _yy_defines_h_ */
