all:
	flex difflex.lex
	bison -d diff.y
	gcc -c lex.yy.c diff.tab.c
	gcc -o diff lex.yy.o diff.tab.o -ll

clean:
	rm lex.yy.o diff.tab.o lex.yy.c diff.tab.c diff.tab.h diff