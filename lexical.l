%{ 
#include "parse.tab.h"

#include <stdbool.h>
#include <stdlib.h>
#include <stdio.h>
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




{sp}{id}{sp}   {strcpy(yylval.vali,yytext);return ID;}
{sp}{num}{sp} {strcpy(yylval.vali,yytext);return NUM;}


{sp}";"{sp}		{return SC;}
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











\n {}
%% 

int yywrap(void) {
    return 1;
}

void print_error()
{
	printf("Invalid Syntax while lexical analysis.\n");
}