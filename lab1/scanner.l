%{
/**********************************************************************
 *
 * --YOUR GROUP INFO SHOULD GO HERE Weixin Wu 1000667405 ShunKong Cheung 1000774263--
 *
 *  Interface to the scanner module for CSC467 course project
 **********************************************************************/


#include "common.h"
#include "parser.tab.h"
#include "string.h"

#define YY_USER_INIT { yyin = inputFile; }
#define	yyinput      input
#define yTRACE()    { if (traceScanner) fprintf(traceFile, "TOKEN %3d : %s\n", yyline, yytext); }

int yyline = 1;

// return the error number line if exist or else return -1
int processComment(const char *str);

%}
%option noyywrap

DIGIT           [0-9]
CHAR		[a-zA-Z]

WS          	[ \t]
NEWLINE		[\n]
COMMENT		"/*"

INTEGER		(({DIGIT}+)|("-"{DIGIT}+))
FLOAT		({DIGIT}+"."{DIGIT}+)|("-"{DIGIT}+"."{DIGIT}+)
IDENTIFIER	({CHAR}|"_")({CHAR}|"_"|{DIGIT})*

%%
{INTEGER}	{yTRACE(); yylval.numint=atoi(yytext); return TOKEN_VAL_INTEGER;}
{FLOAT}		{yTRACE(); yylval.numfloat=atof(yytext); return TOKEN_VAL_FLOAT;}
{IDENTIFIER}	{yTRACE(); yylval.iden=yytext; return TOKEN_VAL_IDENTIFIER;}


"int"		{yTRACE();return TOKEN_TYP_INT;}
"float"		{yTRACE();return TOKEN_TYP_FLOAT;}
"bool"		{yTRACE();return TOKEN_TYP_BOOL;}

"bvec2"		{yTRACE();return TOKEN_TYP_BVEC2;}
"bvec3"		{yTRACE();return TOKEN_TYP_BVEC3;}
"bvec4"		{yTRACE();return TOKEN_TYP_BVEC4;}

"ivec2"		{yTRACE();return TOKEN_TYP_IVEC2;}
"ivec3"		{yTRACE();return TOKEN_TYP_IVEC3;}
"ivec4"		{yTRACE();return TOKEN_TYP_IVEC4;}

"vec2"		{yTRACE();return TOKEN_TYP_VEC2;}
"vec3"		{yTRACE();return TOKEN_TYP_VEC3;}
"vec4"		{yTRACE();return TOKEN_TYP_VEC4;}

"true"		{yTRACE(); yylval.numint = 1; return TOKEN_VAL_TRUE;}
"false"		{yTRACE(); yylval.numint = 0; return TOKEN_VAL_FALSE;}

"const"		{yTRACE();return TOKEN_QUA_CONST;}

"if"		{yTRACE();return TOKEN_CON_IF;}
"else"		{yTRACE();return TOKEN_CON_ELSE;}
"while"		{yTRACE();return TOKEN_CON_WHILE;}

"="		{yTRACE();return TOKEN_ASSIGN;}
"!"		{yTRACE();return TOKEN_NOT;}
">"		{yTRACE();return TOKEN_GREATER;}
"<"		{yTRACE();return TOKEN_LESS;}

"=="		{yTRACE();return TOKEN_EQUAL;}
"!="		{yTRACE();return TOKEN_NOT_EQUAL;}
">="		{yTRACE();return TOKEN_GREATER_EQUAL;}
"<="		{yTRACE();return TOKEN_LESS_EQUAL;}

"+"		{yTRACE();return TOKEN_PLUS;}
"-"		{yTRACE();return TOKEN_MINUS;}
"*"		{yTRACE();return TOKEN_MULTIPLY;}
"/"		{yTRACE();return TOKEN_DIVIDE;}

"&"		{yTRACE();return TOKEN_BIT_AND;}
"|"		{yTRACE();return TOKEN_BIT_OR;}
"^"		{yTRACE();return TOKEN_BIT_XOR;}

"&&"		{yTRACE();return TOKEN_AND;}
"||"		{yTRACE();return TOKEN_OR;}
          
"("		{yTRACE();return TOKEN_GRA_BRACKET_OPEN;}
")"		{yTRACE();return TOKEN_GRA_BRACKET_CLOSE;}

"{"		{yTRACE();return TOKEN_GRA_CURLY_OPEN;}
"}"		{yTRACE();return TOKEN_GRA_CURLY_CLOSE;}

"["		{yTRACE();return TOKEN_GRA_SQUARE_OPEN;}
"]"		{yTRACE();return TOKEN_GRA_SQUARE_CLOSE;}

","		{yTRACE();return TOKEN_GRA_COMMAR;}
";"		{yTRACE();return TOKEN_GRA_COLON;}
  
{WS}            {/*do nothing*/}
{NEWLINE}       {yyline++;}
{COMMENT}       { if( processComment(yytext) == 0 ) return 0; }
<<EOF>>		{yyterminate();}
.               {fprintf(errorFile, "\nLEXICAL ERROR, LINE %d: Undefined Token %s\n", yyline, yytext); errorOccurred = TRUE; yyterminate();}


%%
/**********************************************************************
 * FOOTER FILE
 **********************************************************************/
int processComment(const char *str){
    int c1      = 0;
    int c2      = yyinput();
    int curline = yyline;

    while(!(c1 == '*' && c2 == '/')) {
        /* if next char is EOF, no closing is found, error occur*/
        if (c2 == EOF) {	
	    fprintf(errorFile, "\nLEXICAL ERROR, LINE %d: Unmatch /*\n", curline); errorOccurred = TRUE; yyterminate();
        }

        /* indent to next pair of chars*/
        c1 = c2;
        c2 = yyinput();

        /* if it is a next line, indent yyline count */
        if (c1 == '\n' && c2 != EOF){
            yyline++;
        }
    }
    return 1;
}

