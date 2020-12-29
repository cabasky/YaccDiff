%{
#include <ctype.h>
#include "diffc.h"
extern int yylex();
extern char* yytext;
int yyerror(char *s)
{
	printf("error: %s\n",s);
	printf("%s",yytext);

	return 0;
}
%}

%token VAR DIGIT EXP LN SIN COS FUN MUL NEG SUB ADD DEF COMMA EQU DIV LPR RPR POW END

%%
rev_autodiff: func_def END{};
func_def:	FUN LPR var_list RPR DEF expr {root=$6;op(root);puts("");elist()}
			;

var_init:	VAR EQU DIGIT	{
								++vtot;
								vl[vtot].val=yylval;
								strcpy(vl[vtot].name,gvar);
								++ntot;
								vl[vtot].npos=ntot;
								nl[ntot].type=VAR;
								nl[ntot].v1=vtot;
								nl[ntot].val=vl[vtot].val;
							}
			;

var_list:	var_init
		|	var_list COMMA var_init
			;

expr:	DIGIT 	{
					$$=++ntot;
					nl[ntot].type=DIGIT;
					nl[ntot].val=gdig;
					nl[ntot].dif=0;
				}
	|	VAR 	{$$=vl[varpos(gvar)].npos;}
	|	expr ADD expr	{
							$$=++ntot;
							nl[ntot].type=ADD;
							nl[ntot].v1=$1;
							nl[ntot].v2=$3;
							adde($1,ntot);
							adde($3,ntot);
						}
	|	expr SUB expr	{
							$$=++ntot;
							nl[ntot].type=SUB;
							nl[ntot].v1=$1;
							nl[ntot].v2=$3;
							adde($1,ntot);
							adde($3,ntot);
						}
	|	expr MUL expr	{
							$$=++ntot;
							nl[ntot].type=MUL;
							nl[ntot].v1=$1;
							nl[ntot].v2=$3;
							adde($1,ntot);
							adde($3,ntot);
						}
	|	expr DIV expr	{
							$$=++ntot;
							nl[ntot].type=DIV;
							nl[ntot].v1=$1;
							nl[ntot].v2=$3;
							adde($1,ntot);
							adde($3,ntot);
						}
	|	NEG	expr	{
							$$=++ntot;
							nl[ntot].type=NEG;
							nl[ntot].v1=$2;
							adde($2,ntot);
						}
	|	LPR	expr RPR	{
							$$=$2;
							nl[$$].tag=1;
						}
	|	expr POW expr	{
							$$=++ntot;
							nl[ntot].type=POW;
							nl[ntot].v1=$1;
							nl[ntot].v2=$3;
							adde($1,ntot);
							adde($3,ntot);
						}
	|	EXP LPR expr RPR	{
							$$=++ntot;
							nl[ntot].type=EXP;
							nl[ntot].v1=$3;
							adde($3,ntot);
						}
	|	LN	LPR expr RPR	{
							$$=++ntot;
							nl[ntot].type=LN;
							nl[ntot].v1=$3;
							adde($3,ntot);
						}
	|	SIN LPR expr RPR	{
							$$=++ntot;
							nl[ntot].type=SIN;
							nl[ntot].v1=$3;
							adde($3,ntot);
						}
	|	COS LPR expr RPR	{
							$$=++ntot;
							nl[ntot].type=COS;
							nl[ntot].v1=$3;
							adde($3,ntot);
						}
	;
%%
int main(){
	yyparse();
}