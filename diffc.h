#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "diff.tab.h"
#define MAXN 10010
char gvar[10];
double gdig;
struct node{
	int type,v1,v2,tag;
    double val,dif;
};
struct node nl[MAXN];
struct varlist{
    char name[10];
    int npos;
    double val;
};
struct varlist vl[MAXN];
int vtot,ntot;
int root,tot,ptr[MAXN],nxt[MAXN],lst[MAXN],ein[MAXN],eout[MAXN];
void adde(int x,int y){
	ptr[++tot]=y;
	nxt[tot]=lst[x];
    lst[x]=tot;
    ein[y]++;
    eout[x]++;
}
int varpos(char *eid){
    for(int i=vtot;i>0;i--) if(!strcmp(eid,vl[i].name)) return i;
    return 0;
}
void op(int p){
    printf("(");
    switch(nl[p].type){
        case VAR:
            printf(" %s ",vl[nl[p].v1].name);break;
        case DIGIT:
            printf(" %lf ",nl[p].val);break;
        case ADD:
            op(nl[p].v1);
            printf(" + ");
            op(nl[p].v2);break;
        case SUB:
            op(nl[p].v1);
            printf(" - ");
            op(nl[p].v2);break;
        case MUL:
            op(nl[p].v1);
            printf(" * ");
            op(nl[p].v2);break;
        case DIV:
            op(nl[p].v1);
            printf(" * ");
            op(nl[p].v2);break;
        case POW:
            op(nl[p].v1);
            printf(" ^ ");
            op(nl[p].v2);break;
        case NEG:
            printf(" - ");
            op(nl[p].v1);break;
        case SIN:
            printf(" sin( ");
            op(nl[p].v1);
            printf(" ) ");break;
        case COS:
            printf(" cos( ");
            op(nl[p].v1);
            printf(" ) ");break;
        case LN:
            printf(" ln( ");
            op(nl[p].v1);
            printf(" ) ");break;
        case EXP:
            printf(" e^( ");
            op(nl[p].v1);
            printf(" ) ");break;
    }
    printf(")");
}
void elist(){
    for(int i=1;i<=ntot;i++){

        printf("%d. ",i);
    switch(nl[i].type){
        case VAR:
        printf("VAR: %s\n",vl[nl[i].v1].name);break;
        case DIGIT:
        printf("DIG: %lf\n",nl[i].val);break;
        case ADD:
        printf("ADD: %d %d\n",nl[i].v1,nl[i].v2);break;
        case SUB:
        printf("SUB: %d %d\n",nl[i].v1,nl[i].v2);break;
        case MUL:
        printf("MUL: %d %d\n",nl[i].v1,nl[i].v2);break;
        case DIV:
        printf("DIV: %d %d\n",nl[i].v1,nl[i].v2);break;
        case POW:
        printf("POW: %d %d\n",nl[i].v1,nl[i].v2);break;
        case NEG:
        printf("NEG: %d\n",nl[i].v1);break;
        case SIN:
        printf("SIN: %d\n",nl[i].v1);break;
        case COS:
        printf("COS: %d\n",nl[i].v1);break;
        case LN:
        printf("LN: %d\n",nl[i].v1);break;
        case EXP:
        printf("EXP: %d\n",nl[i].v1);break;
    }
    }
}