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
#define yERROR(msg,line)    { fprintf(errorFile, "\nLEXICAL ERROR, LINE %d: %s\n", line, msg); errorOccurred = TRUE; yyterminate(); }


int CheckInt(void);
int yyline = 1;

int processInt(const char *str);
int processFloat(const char *str);

int processIdentifier(const char *str);


int processMathOp(const char *str);
int processSingleOp(const char *str);
void processDoubleOp(const char *str);

// return the error number line if exist or else return -1
int processComment(const char *str);

%}
%option noyywrap

DIGIT           [0-9]
CHAR		[a-zA-Z]

MATHOP		[-*+/]
SINGLEOP	[!=><&|^]
DOUBLEOP        "=="|"!="|"<="|">="|"&&"|"||"

WS          	[ \t]
NEWLINE		[\n]
COMMENT		"/*"

%%

(({DIGIT}+)|("-"{DIGIT}+))                      {processInt(yytext);}
({DIGIT}+"."{DIGIT}+)|("-"{DIGIT}+"."{DIGIT}+)	{processFloat(yytext);}
({CHAR}|"_")({CHAR}|"_"|{DIGIT})* 		{processIdentifier(yytext);}

{MATHOP}                                        {processMathOp(yytext);}
{SINGLEOP}					{processSingleOp(yytext);}  
{DOUBLEOP}					{processDoubleOp(yytext);}   

            
{WS}                                            {/*do nothing*/}
{NEWLINE}                                       {yyline++;}
{COMMENT}                                       { if( processComment(yytext) == 0 ) return 0; }

.                                               {
                                                    char errmsg [] = "Undefine token _";
                                                    strncpy(errmsg +15, yytext, strlen(errmsg));
                                                    
                                                    yERROR(errmsg,yyline); 
                                                }



%%
/**********************************************************************
 * FOOTER FILE
 **********************************************************************/
int processInt(const char *str){
        yylval.numint = atoi(str);
        return T_INTEGER;
}
int processFloat(const char *str){
        yylval.numfloat = atof(str);
        return T_FLOAT;
}
int processIdentifier(const char *str){
        
        // get length + 1
        unsigned int ilen = yyleng + 1;

        // allocate memory
        char* ival = (char*)malloc( ilen * sizeof(char));

        // copy value
        memset(ival, 0, ilen);
        strncpy(ival, str, ilen-1);

        // output
        yylval.iden = ival;
        return T_IDENTIFIER;
}
int processMathOp(const char *str){

    // error
    char errmsg [] = "Undefine token k";

    // handling
    switch (str[0]){
        case '+':return T_PLUS;
        case '-':return T_MINUS;
        case '*':return T_MULTIPLY;
        case '/':return T_DIVIDE;
        default: break;
    }

    // return
    errmsg[ strlen(errmsg)-1] = str[0];
    yERROR(errmsg, yyline);        
}
int processSingleOp(const char *str){
     // error
    char errmsg [] = "Undefine token k";

    // handling
    switch (str[0]){
        case '!':return T_NOT;
        case '=':return T_ASSIGN;
        case '>':return T_GREATER;
        case '<':return T_LESS;
        case '&':return T_BAND;
        case '|':return T_BOR;
        case '^':return T_BXOR;
       
        default: break;
    }

    // return
    errmsg[ strlen(errmsg)-1] = str[0];
   yERROR(errmsg, yyline); 
}
void processDoubleOp(const char *str){
    printf("Double: %s \n", str);
}

int processComment(const char *str){
    int c1      = 0;
    int c2      = yyinput();
    int curline = yyline;

    while(!(c1 == '*' && c2 == '/')) {
        /* if next char is EOF, no closing is found, error occur*/
        if (c2 == EOF) {	
            yERROR("Unmatch /*", curline);
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

