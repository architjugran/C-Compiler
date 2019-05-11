%{
#include <stdbool.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
extern FILE * yyin;
void yyerror(char *s);
%}

%start	START


%token	SELECT
%token	INT
%token	FLT
%token	ID

%token 	SC
%token 	SP
%token COMMA

%token EQ
%token OR
%token AND
%token NOT

%token LT
%token LTE
%token GT
%token GTE
%token EQEQ
%token NEQ

%token PLUS
%token MINUS
%token MULT
%token DIV
%token MOD

%token OPT
%token CPT
%token OCURLY
%token CCURLY
%token IF
%token ELSE
%token FORT
%token WHILET
%token VOID
%token RET



%token NUM

%%

%union
{
  char vali[1000];
};

START : INPUT
		;

INPUT : FUNC_DECL INPUT
		| FUNC_DECL
		;

FUNC_DECL : FUNC_HEAD BODY
		    ;
FUNC_HEAD : RESULT_ID OPT DECLISTE CPT
			;
RESULT_ID : RESULT ID
			;
RESULT : INT
		| FLT
		| VOID
		;
DECLISTE : DECLIST
		| ;
DECLIST : DECLIST COMMA DEC
			| DEC
			;
DEC : TYPE ID
		;

BODY : OCURLY SLIST CCURLY  {printf("BODY 2\n");}
		;
SLIST : SLIST MSLIST S
		| S
		;
MSLIST : ;

S:      VAR_DECL {printf("DECL!!\n");}
		| ASSIGN {printf("ASSIGN\n");}
		| IFELSE {printf("IFELSE\n");}
		| FOR    {printf("FOR\n");}
		| WHILE  {printf("WHILE\n");}
		| BODY	{printf("BODY\n");}
		| FUNC_CALL SC {printf("KAUL\n");}
		| RETURN SC {printf("RETURN\n");}
		; 

RETURN : RET 
		| RET COR
		;

FUNC_CALL : ID OPT PARAMLIST CPT
			;
PARAMLIST : PLIST
			| ;
PLIST : PLIST COMMA COR 
		| COR
		;



WHILE : WHILEXP BODY
		;
WHILEXP : WHILET MWHILE OPT COR CPT
		;
MWHILE : ;



FOR : FOREXP BODY
		;
FOREXP : FORT OPT ASSIGN MFOR COR SC NFOR FORASSIGN CPT
		;
MFOR : ;
NFOR : ;



IFELSE : IFEXP BODY
		| IFEXP BODY NIF ELSE MIF BODY
		;
NIF : ;
MIF : ;
IFEXP : IF OPT COR CPT
		;



VAR_DECL : TYPE L SC
		;
TYPE : INT  
	| FLT  
	;
L : L COMMA ID
	| ID               
	;



FORASSIGN : ID EQ COR 
ASSIGN : ID EQ COR SC
COR	: COR OR CAND
		| CAND
CAND : CAND AND CNOT
		| CNOT
CNOT : ECOMP
		| NOT ECOMP
ECOMP : ECOMP LT E
		| ECOMP LTE E
		| ECOMP GT E
		| ECOMP GTE E
		| ECOMP NEQ E
		| ECOMP EQEQ E
		| E
E : E PLUS T
	| E MINUS T
	| T
T : T MULT F
	| T DIV F
	| T MOD F
	| F
F : ID
	| NUM
	| FUNC_CALL     {printf("FDF\n");}
	| OPT COR CPT


%%

void yyerror (char *s) {
	printf("Invalid Syntax while parsing.\n");
	exit(1);
}

int main()
{
	FILE*fil=fopen("input.c","r");
	yyin=fil;
	yyparse();

	return 0;
}