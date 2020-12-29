%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#define YYSTYPE double
#include "diff.tab.h"
extern char gvar[10];
extern double gdig;
%}
VAR [a-zA-Z]+([0-9]|[a-zA-Z])*
DIGIT [0-9]+("."[0-9]+)?

%%
"cos" {return COS;}
"sin" {return SIN;}
"f" {return FUN;}
"(" {return LPR;}
")" {return RPR;}
"ln" {return POW;}
"exp" {return EXP;}
":" {return DEF;}
"=" {return EQU;}
"," {return COMMA;}
"+" {return ADD;}
"-" {return NEG;}
"*" {return MUL;}
"/" {return DIV;}
"^" {return POW;}
"$" {printf("end\n");return END;}
{DIGIT} {
    yylval=atof(yytext);
    gdig=yylval;
    return DIGIT;
}
{VAR} {
    if(!strcmp("f",yytext)){
        return FUN;
    }
    else{
        strcpy(gvar,yytext);
        return VAR;
    }
}
%%
int yywrap(){
    return 1;
}
