bison -d --warning=none parse.y
flex lexical.l
gcc -c -w lex.yy.c
gcc -c -w parse.tab.c
gcc parse.tab.o lex.yy.o -o ex

rm lex.yy.c
rm lex.yy.o
rm parse.tab.c
rm parse.tab.h
rm parse.tab.o