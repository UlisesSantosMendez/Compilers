#ifndef _yy_defines_h_
#define _yy_defines_h_

#define NUMBER 257
#define PRINT 258
#define VAR 259
#define VARVECTOR 260
#define VARESCALAR 261
#define INDEF 262
#define WHILE 263
#define IF 264
#define ELSE 265
#define OR 266
#define AND 267
#define GT 268
#define GE 269
#define LT 270
#define LE 271
#define EQ 272
#define NE 273
#define NOT 274
#ifdef YYSTYPE
#undef  YYSTYPE_IS_DECLARED
#define YYSTYPE_IS_DECLARED 1
#endif
#ifndef YYSTYPE_IS_DECLARED
#define YYSTYPE_IS_DECLARED 1
typedef union YYSTYPE{
	Symbol *sym;
	Inst *inst;
} YYSTYPE;
#endif /* !YYSTYPE_IS_DECLARED */
extern YYSTYPE yylval;

#endif /* _yy_defines_h_ */
