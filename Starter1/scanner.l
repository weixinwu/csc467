%{
/**********************************************************************
 *
 * **YOUR GROUP INFO SHOULD GO HERE Weixin Wu 1000667405	ShunKong Cheung	1000774263**
 *
 *  Interface to the scanner module for CSC467 course project
 **********************************************************************/


#include "common.h"
#include "parser.tab.h"
#include "string.h"


#define YY_USER_INIT { yyin = inputFile; }
#define	yyinput      input
#define yTRACE(x)    { if (traceScanner) fprintf(traceFile, "TOKEN %3d : %s\n", x, yytext); }
#define yERROR(x)    { fprintf(errorFile, "\nLEXICAL ERROR, LINE %d: %s\n", yyline, x); errorOccurred = TRUE; yyterminate(); }


int CheckInt(void);
int yyline = 1;

void processInt(const char *str);
void processFloat(const char *str);

void processIdentifier(const char *str);

void processSingleOp(const char *str);
void processDoubleOp(const char *str);

void processComment(const char *str);


%}
%option noyywrap

INI_DIGIT	[1-9]
ALL_DIGIT	[0-9]
CHAR		[a-z A-Z]

MATHOP		[- * / +]
COMPOP		[= ! > < & | ^]

WS          	[ \t]
NEWLINE		[\n]
COMMENT		[/*]

%%

({ALL_DIGIT})|("-"{ALL_DIGIT})|({INI_DIGIT}{ALL_DIGIT}*)|("-"{INI_DIGIT}{ALL_DIGIT}*)		{processInt(yytext);}
({ALL_DIGIT}+"."{ALL_DIGIT}+)|({ALL_DIGIT}+"."{ALL_DIGIT}+)					{processFloat(yytext);}
({CHAR}|"_")({CHAR}|"_"|{ALL_DIGIT})* 								{processIdentifier(yytext);}
{COMPOP}											{processDoubleOp(yytext);}




{WS}	    		{/*do nothing*/}
{NEWLINE}    		{yyline++;}
{COMMENT}       	{
				int c1      = 0;
			  	int c2      = yyinput();
			  	int curline = yyline;

			      while(!(c1 == '*' && c2 == '/')) {
					/* if next char is EOF, no closing is found, error occur*/
					if (c2 == EOF) {	
						fprintf(errorFile, "\nLEXICAL ERROR, LINE %d: Unmatched /*\n", curline);
						errorOccurred = TRUE;
						yyterminate();
					}
		
					/* indent to next pair of chars*/
					c1 = c2;
					c2 = yyinput();

					/* if it is a next line, indent yyline count */
					if (c1 == '\n' && c2 != EOF){
						yyline++;
			
					}
				}

			}


.           		{ yERROR("Unknown token"); }



%%
/**********************************************************************
 * FOOTER FILE
 **********************************************************************/
void processInt(const char *str){
	printf("integer: %s \n", str);
}
void processFloat(const char *str){
	printf("float: %s \n", str);
}
void processIdentifier(const char *str){
	printf("char: %s \n", str);
}
void processSingleOp(const char *str){
	printf("single: %s \n", str);
}
void processDoubleOp(const char *str){
	printf("double: %s \n", str);
}

void processComment(const char *str){
	
}

