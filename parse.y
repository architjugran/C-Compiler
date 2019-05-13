%{
#include <stdbool.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
extern FILE * yyin;
void yyerror(char *s);

bool tempreg[10];
FILE *fp;
struct varrecord
{
	char varname[100];
	char vartype[100];
	bool tag;
	int level;
};
struct funcrecord
{
	char name[100];
	char type[100];
	struct varrecord paramtable[100];
	struct varrecord vartable[100];
	int paramcount;
	int varcount;  
};
struct funcrecord functable[1000];
int funccount=0;
int actfuncindex=0;
int globallevel=0;
void releasetemp(int i);
int newtemp();
bool InArr(struct varrecord arr[],int size,char finder[]);
bool CheckVar (struct varrecord arr[],int size,char finder[],int level);
void PrintVars(struct varrecord a);
void PrintFuncs(struct funcrecord a);
void PrintFuncTable();

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
  char type[1000];

};

START : INPUT
		;

INPUT : FUNC_DECL INPUT
		| FUNC_DECL
		;

FUNC_DECL : FUNC_HEAD BODY { actfuncindex++; globallevel=0;}
		    ;
FUNC_HEAD : RESULT_ID OPT DECLISTE CPT  {

										globallevel++;	

										}
			;
RESULT_ID : RESULT ID { functable[actfuncindex].paramcount=0;
						functable[actfuncindex].varcount=0;
						globallevel++;
						// Copy ID.name and RESULT.type
						strcpy(functable[actfuncindex].name,$<vali>2);
					  }
			;
RESULT : INT       {strcpy(functable[actfuncindex].type,"int");}
		| FLT	   {strcpy(functable[actfuncindex].type,"float");}
		| VOID     {strcpy(functable[actfuncindex].type,"void");}
		;
DECLISTE : DECLIST
		| ;
DECLIST : DECLIST COMMA DEC
			| DEC
			;
DEC : TYPE ID 				{
								if(InArr(functable[actfuncindex].paramtable,functable[actfuncindex].paramcount,$<vali>2))
								{
								printf("Parameter name already used.\n");
								}
								else
								{
									struct varrecord new_record;
									strcpy(new_record.varname,$<vali>2);
									strcpy(new_record.vartype,$<vali>1);
									new_record.tag=false;
									new_record.level = globallevel;
									functable[actfuncindex].paramtable[functable[actfuncindex].paramcount++]=new_record;
								}
								
							}
		;

BODY : OCURLY SLIST CCURLY  {printf("BODY 2\n");globallevel--;}
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
		| INCRLEVEL BODY	{printf("BODY\n");}
		| FUNC_CALL SC {printf("KAUL\n");}
		| RETURN SC {printf("RETURN\n");}
		; 

INCRLEVEL :  {globallevel++;}
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
WHILEXP : WHILET MWHILE OPT COR CPT { globallevel++;}
		;
MWHILE : ;



FOR : FOREXP BODY
		;
FOREXP : FORT OPT ASSIGN MFOR COR SC NFOR FORASSIGN CPT { globallevel++;}
		;
MFOR : ;
NFOR : ;



IFELSE : IFEXP BODY
		| IFEXP BODY NIF ELSE MIF BODY
		;
NIF : ;
MIF :  {globallevel++;}
		;
IFEXP : IF OPT COR CPT  { globallevel ++;}
		;



VAR_DECL : TYPE L SC 				{
										int i;
										for(i=0;i<functable[actfuncindex].varcount;i++)
										{
											if(!strcmp(functable[actfuncindex].vartable[i].vartype,"-1"))
											{
												printf("I PO\n");
												strcpy(functable[actfuncindex].vartable[i].vartype,$<type>1);
											}
										}
									}		
		;
TYPE : INT  {strcpy($<type>$,"int");}
	| FLT  	{strcpy($<type>$,"float");}
	;
L : L COMMA IDS
	| IDS               
	;
IDS : ID 	{
				if(InArr(functable[actfuncindex].paramtable,functable[actfuncindex].paramcount,$<vali>1) && globallevel==2)
				{
					printf("Parameter with this name already exists.\n");
				}
				else if(CheckVar(functable[actfuncindex].vartable,functable[actfuncindex].varcount,$<vali>1,globallevel))
				{
					printf("Variable with this name already exists in current scope.\n");
				}
				else
				{
					printf("INSERT\n");
					struct varrecord new_record;
					strcpy(new_record.varname,$<vali>1);
					strcpy(new_record.vartype,"-1");
					new_record.tag=true;
					new_record.level = globallevel;
					functable[actfuncindex].vartable[functable[actfuncindex].varcount++]=new_record;

				}
			}
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

bool InArr (struct varrecord arr[],int size,char finder[])
{
	int i=0;
	for(i=0;i<size;i++)
	{
		if(!strcmp(arr[i].varname,finder))
			return true;

	}
	return false;
}

bool CheckVar (struct varrecord arr[],int size,char finder[],int level)
{
	int i=0;
	for(i=0;i<size;i++)
	{
		if(!strcmp(arr[i].varname,finder) && arr[i].level==level)
			return true;

	}
	return false;
}

void PrintVars(struct varrecord a)
{
	printf("%s %s",a.varname,a.vartype);
	if(a.tag)
	printf(" %s ","1");
	else
	printf(" %s ","0");
	printf("%d\n",a.level);
}

void PrintFuncs(struct funcrecord a)
{
	printf("%s %s\n",a.name,a.type);
	int i=0;

	printf("Parameters %d\n",a.paramcount);
	for(i=0;i<a.paramcount;i++)
		PrintVars(a.paramtable[i]);
	printf("==============================================\n");
	printf("Variables %d\n",a.varcount);
	for(i=0;i<a.varcount;i++)
		PrintVars(a.vartable[i]);
}

void PrintFuncTable()
{
	int i=0;
	for(i=0;i<actfuncindex;i++)
		PrintFuncs(functable[i]);
}

void yyerror (char *s) {
	printf("Invalid Syntax while parsing.\n");
	exit(1);
}
int newtemp()
{
	for(int i=0;i<10;i++)
	{
		if(!tempreg[i])
			{tempreg[i]=true;return i;}
	}
	return -1;
}
void releasetemp(int i)
{
	if(i!=-1)
	tempreg[i]=false;
}
int main()
{
	FILE*fil=fopen("input.c","r");
	yyin=fil;
	int i=0;
	for(i=0;i<10;i++)
		tempreg[i]=false;
	fp=fopen("iccode.txt","r");

	yyparse();
	printf("FUNC TABLE :\n\n\n\n");
	PrintFuncTable();

	return 0;
}