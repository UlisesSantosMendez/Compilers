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