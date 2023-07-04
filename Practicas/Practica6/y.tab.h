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
#define FOR 266
#define OR 267
#define AND 268
#define GT 269
#define GE 270
#define LT 271
#define LE 272
#define EQ 273
#define NE 274
#define NOT 275
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
