%{
    #include <math.h>
    #include <stdio.h>
    #include <stdlib.h>
    #include "../src/tree/syntaxtree.hpp"
    #include <iostream>

    using namespace hephaistos;

    int yylex(void);
    void yyerror(char const*);
%}

%define api.value.type {void*}

%token FUNCTION
%token NAME
%token LEFT_BRACKET
%token RIGHT_BRACKET

%token WORD
%token NUM
%token DEC
%token BIT
%token OBJECT

%token WORDVAL
%token NUMVAL
%token DECVAL
%token BITVAL

%token WHILE
%token FOR
%token IF
%token ELSE
%token END

%token OUT
%token IN

%token COLON
%token COMMA

%start input

%%

input:
    program
    ;

program:
    block program
    | function program
    | %empty
    ;

//Multiple statements with loops and conditions, todo implement loops
block:
    statements
    | while
    | %empty
    ;

//Multiple statements together
statements:
    statement statements
    | out statements
    | in statements
    | %empty
    ;

//Single line of statement
statement:
    NAME COLON NAME
    | NAME COLON WORDVAL
    | NAME COLON NUMVAL                                     
    | NAME COLON DECVAL
    | NAME COLON BITVAL
    | NAME COLON LEFT_BRACKET inputvalue RIGHT_BRACKET
    ;

inputvalue:
    BITVAL
    | DECVAL
    | NUMVAL
    | WORDVAL
    | NAME
    | statement
    | %empty
    ;

//Multiple inputvalues
inputvalues:
    | inputvalue COMMA inputvalue
    ;

//Built in 'out' function
out:
    OUT COLON OUT
    | OUT COLON WORDVAL
    | OUT COLON NUMVAL                                     
    | OUT COLON DECVAL
    | OUT COLON BITVAL
    | OUT COLON LEFT_BRACKET inputvalue RIGHT_BRACKET
    ;

//Built in 'in' function
in:
    IN COLON LEFT_BRACKET RIGHT_BRACKET
    ;

//Function
function:
    functiondecleration block END
    | %empty
    ;

//Function decleration
functiondecleration:
    FUNCTION NAME LEFT_BRACKET RIGHT_BRACKET
    | FUNCTION NAME LEFT_BRACKET input RIGHT_BRACKET
    ;

//Input values for functiondecleration
input:
    | NUM NAME
    | WORD NAME
    | DEC NAME
    | BIT NAME
    | OBJECT NAME
    | input COMMA input
    ;

//While block
while:
    whiledecleration statements END
    ;

//While decleration
whiledecleration:
    WHILE LEFT_BRACKET BITVAL RIGHT_BRACKET
    | WHILE LEFT_BRACKET NAME RIGHT_BRACKET
    | WHILE LEFT_BRACKET statement RIGHT_BRACKET
    ;
%%

void yyerror(char const* x){
    printf("Error %s! \n",x);
    exit(1);    
}