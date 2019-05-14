%{ 
#include <stdbool.h>
#include <stdlib.h>
#include <stdio.h>
#include "parse.tab.h"
#include "line.h"
int lines;
void despace(char target[], char input[], int l);
void print_error();
%} 

sp [ \t]*
id [a-zA-Z][a-zA-Z0-9_]*
pnum ([0-9]+)|([0-9]+)"."([0-9]+)
nnum "-"{pnum}
num {nnum}|{pnum}

%% 
{sp}"int"{sp} {return INT;}
{sp}"float"{sp} {return FLT;}
{sp}"void"{sp} {return VOID;}


{sp}"if"{sp} {return IF;}
{sp}"else"{sp} {return ELSE;}

{sp}"for"{sp} {return FORT;}
{sp}"while"{sp} {return WHILET;}
{sp}"return"{sp} {return RET;}
{sp}"switch"{sp} {return SWITCHT;}
{sp}"break"{sp} {return BREAK;}
{sp}"default"{sp} {return DEFAULT;}
{sp}"case"{sp} {return CASET;}




{sp}{id}{sp}   {char input[1000]; despace(input,yytext,strlen(yytext));strcpy(yylval.vp.vali,input);return ID;}
{sp}{num}{sp} {char input[1000]; despace(input,yytext,strlen(yytext));strcpy(yylval.vp.vali,input);return NUM;}


{sp}";"{sp}		{return SC;}
{sp}":"{sp}		{return COLON;}
{sp}","{sp}		{return COMMA;}

{sp}"="{sp} {return EQ;}
{sp}"||"{sp} {return OR;}
{sp}"&&"{sp} {return AND;}
{sp}"!"{sp} {return NOT;}

{sp}"<"{sp} {return LT;}
{sp}"<="{sp} {return LTE;}
{sp}">"{sp} {return GT;}
{sp}">="{sp} {return GTE;}
{sp}"=="{sp} {return EQEQ;}
{sp}"!="{sp} {return NEQ;}

{sp}"+"{sp} {return PLUS;}
{sp}"-"{sp} {return MINUS;}
{sp}"*"{sp} {return MULT;}
{sp}"/"{sp} {return DIV;}
{sp}"%"{sp} {return MOD;}

{sp}"("{sp} {return OPT;}
{sp}")"{sp} {return CPT;}

{sp}"{"{sp} {return OCURLY;}
{sp}"}"{sp} {return CCURLY;}

{sp}"["{sp} {return OSQ;}
{sp}"]"{sp} {return CSQ;}


\n {lines++;}
. {}
%% 

int yywrap(void) {
    return 1;
}

void despace(char target[], char input[], int l){
	int start=0, end=l-1;
	while(input[start]==' ' || input[start]=='\t') start++;
	while(input[end]==' ' || input[end]=='\t') end--;
	int y=0;
	for (int i = start; i <= end; ++i)
	{
		target[y++]=input[i];
	}
	target[y]='\0';
}

void print_error()
{
	printf("Invalid Syntax while lexical analysis.\n");
}