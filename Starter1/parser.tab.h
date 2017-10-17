/* A Bison parser, made by GNU Bison 3.0.4.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015 Free Software Foundation, Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

#ifndef YY_YY_Y_TAB_H_INCLUDED
# define YY_YY_Y_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 1
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    TOKEN_VAL_INTEGER = 258,
    TOKEN_VAL_FLOAT = 259,
    TOKEN_VAL_IDENTIFIER = 260,
    TOKEN_VAL_TRUE = 261,
    TOKEN_VAL_FALSE = 262,
    TOKEN_TYP_INT = 263,
    TOKEN_TYP_BOOL = 264,
    TOKEN_TYP_FLOAT = 265,
    TOKEN_TYP_BVEC2 = 266,
    TOKEN_TYP_BVEC3 = 267,
    TOKEN_TYP_BVEC4 = 268,
    TOKEN_TYP_IVEC2 = 269,
    TOKEN_TYP_IVEC3 = 270,
    TOKEN_TYP_IVEC4 = 271,
    TOKEN_TYP_VEC2 = 272,
    TOKEN_TYP_VEC3 = 273,
    TOKEN_TYP_VEC4 = 274,
    TOKEN_QUA_CONST = 275,
    TOKEN_CON_IF = 276,
    TOKEN_CON_ELSE = 277,
    TOKEN_CON_WHILE = 278,
    TOKEN_ASSIGN = 279,
    TOKEN_NOT = 280,
    TOKEN_GREATER = 281,
    TOKEN_LESS = 282,
    TOKEN_EXPONENT = 283,
    TOKEN_EQUAL = 284,
    TOKEN_NOT_EQUAL = 285,
    TOKEN_GREATER_EQUAL = 286,
    TOKEN_LESS_EQUAL = 287,
    TOKEN_PLUS = 288,
    TOKEN_MINUS = 289,
    TOKEN_MULTIPLY = 290,
    TOKEN_DIVIDE = 291,
    TOKEN_AND = 292,
    TOKEN_OR = 293,
    TOKEN_GRA_BRACKET_OPEN = 294,
    TOKEN_GRA_BRACKET_CLOSE = 295,
    TOKEN_GRA_CURLY_OPEN = 296,
    TOKEN_GRA_CURLY_CLOSE = 297,
    TOKEN_GRA_SQUARE_OPEN = 298,
    TOKEN_GRA_SQUARE_CLOSE = 299,
    TOKEN_GRA_COMMAR = 300,
    TOKEN_GRA_COLON = 301,
    NEG = 302
  };
#endif
/* Tokens.  */
#define TOKEN_VAL_INTEGER 258
#define TOKEN_VAL_FLOAT 259
#define TOKEN_VAL_IDENTIFIER 260
#define TOKEN_VAL_TRUE 261
#define TOKEN_VAL_FALSE 262
#define TOKEN_TYP_INT 263
#define TOKEN_TYP_BOOL 264
#define TOKEN_TYP_FLOAT 265
#define TOKEN_TYP_BVEC2 266
#define TOKEN_TYP_BVEC3 267
#define TOKEN_TYP_BVEC4 268
#define TOKEN_TYP_IVEC2 269
#define TOKEN_TYP_IVEC3 270
#define TOKEN_TYP_IVEC4 271
#define TOKEN_TYP_VEC2 272
#define TOKEN_TYP_VEC3 273
#define TOKEN_TYP_VEC4 274
#define TOKEN_QUA_CONST 275
#define TOKEN_CON_IF 276
#define TOKEN_CON_ELSE 277
#define TOKEN_CON_WHILE 278
#define TOKEN_ASSIGN 279
#define TOKEN_NOT 280
#define TOKEN_GREATER 281
#define TOKEN_LESS 282
#define TOKEN_EXPONENT 283
#define TOKEN_EQUAL 284
#define TOKEN_NOT_EQUAL 285
#define TOKEN_GREATER_EQUAL 286
#define TOKEN_LESS_EQUAL 287
#define TOKEN_PLUS 288
#define TOKEN_MINUS 289
#define TOKEN_MULTIPLY 290
#define TOKEN_DIVIDE 291
#define TOKEN_AND 292
#define TOKEN_OR 293
#define TOKEN_GRA_BRACKET_OPEN 294
#define TOKEN_GRA_BRACKET_CLOSE 295
#define TOKEN_GRA_CURLY_OPEN 296
#define TOKEN_GRA_CURLY_CLOSE 297
#define TOKEN_GRA_SQUARE_OPEN 298
#define TOKEN_GRA_SQUARE_CLOSE 299
#define TOKEN_GRA_COMMAR 300
#define TOKEN_GRA_COLON 301
#define NEG 302

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED

union YYSTYPE
{
#line 57 "parser.y" /* yacc.c:1909  */

    int     numint;
    float   numfloat;
    char*   iden;

#line 154 "y.tab.h" /* yacc.c:1909  */
};

typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_Y_TAB_H_INCLUDED  */
