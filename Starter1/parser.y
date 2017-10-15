%{
/***********************************************************************
 * --YOUR GROUP INFO SHOULD GO HERE Weixin Wu 1000667405 ShunKong Cheung 1000774263--
 * 
 *   Interface to the parser module for CSC467 course project.
 * 
 *   Phase 2: Implement context free grammar for source language, and
 *            parse tracing functionality.
 *   Phase 3: Construct the AST for the source language program.
 ***********************************************************************/

/***********************************************************************
 *  C Definitions and external declarations for this module.
 *
 *  Phase 3: Include ast.h if needed, and declarations for other global or
 *           external vars, functions etc. as needed.
 ***********************************************************************/

#include <string.h>
#include "common.h"
//#include "ast.h"
//#include "symbol.h"
//#include "semantic.h"
#define YYERROR_VERBOSE
#define yTRACE(x)    { if (traceParser) fprintf(traceFile, "%s\n", x); }

void yyerror(const char* s);    /* what to do in case of error              */
int yylex();                    /* procedure for calling lexical analyzer   */
extern int yyline;              /* variable holding current line number     */

%}

/***********************************************************************
 *  Yacc/Bison declarations.
 *  Phase 2:
 *    1. Add precedence declarations for operators (after %start declaration)
 *    2. If necessary, add %type declarations for some nonterminals
 *  Phase 3:
 *    1. Add fields to the union below to facilitate the construction of the
 *       AST (the two existing fields allow the lexical analyzer to pass back
 *       semantic info, so they shouldn't be touched).
 *    2. Add <type> modifiers to appropriate %token declarations (using the
 *       fields of the union) so that semantic information can by passed back
 *       by the scanner.
 *    3. Make the %type declarations for the language non-terminals, utilizing
 *       the fields of the union as well.
 ***********************************************************************/

%{
#define YYDEBUG 1 
%}


// TODO:Modify me to add more data types
// Can access me from flex using yylval

%union {
    int     numint;
    float   numfloat;
    char*   iden;
}
// TODO:Replace myToken with your tokens, you can use these tokens in flex
%token   

// value(s)
TOKEN_VAL_INTEGER
TOKEN_VAL_FLOAT
TOKEN_VAL_IDENTIFIER

// value: true/false
TOKEN_VAL_TRUE
TOKEN_VAL_FALSE

// type: value
TOKEN_TYP_INT
TOKEN_TYP_BOOL
TOKEN_TYP_FLOAT

// type: bool vector
TOKEN_TYP_BVEC2
TOKEN_TYP_BVEC3
TOKEN_TYP_BVEC4

// type: integer vector
TOKEN_TYP_IVEC2
TOKEN_TYP_IVEC3
TOKEN_TYP_IVEC4

// type: float vector
TOKEN_TYP_VEC2
TOKEN_TYP_VEC3
TOKEN_TYP_VEC4

// qualifier
TOKEN_QUA_CONST

// condition
TOKEN_CON_IF
TOKEN_CON_ELSE
TOKEN_CON_WHILE

// comparison: single 
TOKEN_ASSIGN
TOKEN_NOT
TOKEN_GREATER
TOKEN_LESS

// comparison: double
TOKEN_EQUAL
TOKEN_NOT_EQUAL
TOKEN_GREATER_EQUAL
TOKEN_LESS_EQUAL

// math operators
TOKEN_PLUS
TOKEN_MINUS
TOKEN_MULTIPLY
TOKEN_DIVIDE

TOKEN_BIT_AND
TOKEN_BIT_OR
TOKEN_BIT_XOR

TOKEN_AND
TOKEN_OR

// grammatical
TOKEN_GRA_BRACKET_OPEN
TOKEN_GRA_BRACKET_CLOSE

TOKEN_GRA_CURLY_OPEN
TOKEN_GRA_CURLY_CLOSE

TOKEN_GRA_SQUARE_OPEN
TOKEN_GRA_SQUARE_CLOSE

TOKEN_GRA_COMMAR
TOKEN_GRA_COLON

%start    program

%%

/***********************************************************************
 *  Yacc/Bison rules
 *  Phase 2:
 *    1. Replace grammar found here with something reflecting the source
 *       language grammar
 *    2. Implement the trace parser option of the compiler
 *  Phase 3:
 *    1. Add code to rules for construction of AST.
 ***********************************************************************/
program: TOKEN_GRA_CURLY_OPEN 	 TOKEN_GRA_CURLY_CLOSE;
instructions
  :instructions instruction
  |
  ;
// TODO: replace myToken with the token the you defined.
instruction
  :     declaration TOKEN_GRA_COLON 			
  |     assignment  TOKEN_GRA_COLON   			
  |	statement    
  |	loop      
  | 	TOKEN_GRA_COLON
  ;

value
  :	TOKEN_VAL_FLOAT
  |	TOKEN_VAL_TRUE
  |     TOKEN_VAL_FALSE
  |     TOKEN_VAL_INTEGER
  |     TOKEN_VAL_IDENTIFIER	
  ;

type
  :	TOKEN_TYP_INT 	| TOKEN_TYP_BOOL  | TOKEN_TYP_FLOAT
  |     TOKEN_TYP_BVEC2 | TOKEN_TYP_BVEC3 | TOKEN_TYP_BVEC4
  |     TOKEN_TYP_IVEC2 | TOKEN_TYP_IVEC3 | TOKEN_TYP_IVEC4
  |     TOKEN_TYP_VEC2  | TOKEN_TYP_VEC3  | TOKEN_TYP_VEC4
  ;

// TODO: multiple index
index
  : TOKEN_GRA_SQUARE_OPEN TOKEN_VAL_INTEGER TOKEN_GRA_SQUARE_CLOSE index
  |  
  ;

declaration
  :	type TOKEN_VAL_IDENTIFIER
  |     type assignment
  ;

assignment
  : TOKEN_VAL_IDENTIFIER index TOKEN_ASSIGN expression;


// # operator #
expression
  :	value index
  |     expression TOKEN_PLUS expression
  |     expression TOKEN_MINUS expression
  |     expression TOKEN_MULTIPLY expression
  |     expression TOKEN_DIVIDE expression
  ;


statement_if: TOKEN_CON_IF TOKEN_GRA_BRACKET_OPEN condition TOKEN_GRA_BRACKET_CLOSE TOKEN_GRA_CURLY_OPEN instructions TOKEN_GRA_CURLY_CLOSE;

statement_elseif
  :	statement_if TOKEN_CON_ELSE statement_if
  |	statement_elseif TOKEN_CON_ELSE statement_if;

statement
  :	statement_if
  | 	statement_elseif
  |	statement_elseif TOKEN_CON_ELSE TOKEN_GRA_BRACKET_OPEN instructions TOKEN_GRA_CURLY_CLOSE
  |	statement_if TOKEN_CON_ELSE TOKEN_GRA_CURLY_OPEN instructions TOKEN_GRA_CURLY_CLOSE
  ;

loop
  :	TOKEN_CON_WHILE TOKEN_GRA_BRACKET_OPEN condition TOKEN_GRA_BRACKET_CLOSE TOKEN_GRA_CURLY_OPEN instructions TOKEN_GRA_CURLY_CLOSE
  ;

condition 
  :	value
  |     TOKEN_NOT value
  |	value comparison value
  | 	condition TOKEN_AND condition
  |	condition TOKEN_OR condition
  | 	TOKEN_GRA_BRACKET_OPEN condition TOKEN_GRA_BRACKET_CLOSE
  ;  

// TODO: BIT WISE?   
comparison:TOKEN_EQUAL | TOKEN_NOT_EQUAL | TOKEN_GREATER_EQUAL | TOKEN_LESS_EQUAL | TOKEN_GREATER|TOKEN_LESS;	

%%
/***********************************************************************ol
 * Extra C code.
 *
 * The given yyerror function should not be touched. You may add helper
 * functions as necessary in subsequent phases.
 ***********************************************************************/
void yyerror(const char* s) {
  if (errorOccurred)
    return;    /* Error has already been reported by scanner */
  else
    errorOccurred = 1;
        
  fprintf(errorFile, "\nPARSER ERROR, LINE %d",yyline);
  if (strcmp(s, "parse error")) {
    if (strncmp(s, "parse error, ", 13))
      fprintf(errorFile, ": %s\n", s);
    else
      fprintf(errorFile, ": %s\n", s+13);
  } else
    fprintf(errorFile, ": Reading token %s\n", yytname[YYTRANSLATE(yychar)]);
}

