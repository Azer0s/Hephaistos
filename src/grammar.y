%{
    #include <math.h>
    #include <stdio.h>
    #include <stdlib.h>
    #include "../src/tree/nodes.hpp"
    #include <iostream>
    #include <memory>

    using namespace hephaistos;

    int yylex(void);
    void yyerror(char const*);
    extern char* yytext;
    std::unique_ptr<SyntaxTree> root;

    #define YYSTYPE SyntaxTree*
%}

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
    statement statements { $$ = new Statements($1,$2); }
    | %empty
    ;

//Single line of code
statement:
    name COLON name { $$ = new Statement($1, $3); }
    | name COLON wordval { $$ = new Statement($1, $3); }
    | name COLON numval { $$ = new Statement($1, $3); }                                 
    | name COLON decval { $$ = new Statement($1, $3); }
    | name COLON bitval { $$ = new Statement($1, $3); }
    | name COLON LEFT_BRACKET inputvalue RIGHT_BRACKET { $$ = new Statement($1, $4); }
    ;

inputvalue:
    bitval
    | decval
    | numval
    | wordval
    | name
    | statement
    | %empty
    ;

//Multiple inputvalues
inputvalues:
    | inputvalue COMMA inputvalue
    ;

//Function
function:
    functiondecleration block END
    | %empty
    ;

//Function decleration
functiondecleration:
    FUNCTION name LEFT_BRACKET RIGHT_BRACKET
    | FUNCTION name LEFT_BRACKET input RIGHT_BRACKET
    ;

//Input values for functiondecleration
input:
    | NUM name
    | WORD name
    | DEC name
    | BIT name
    | OBJECT name
    | input COMMA input
    ;

//While block
while:
    whiledecleration statements END
    ;

//While decleration
whiledecleration:
    WHILE LEFT_BRACKET bitval RIGHT_BRACKET
    | WHILE LEFT_BRACKET name RIGHT_BRACKET
    | WHILE LEFT_BRACKET statement RIGHT_BRACKET
    ;

name:
    NAME { $$ = new Name(yytext);}
    ;

wordval:
    WORDVAL { $$ = new Word(yytext);}
    ;

decval:
    DECVAL { $$ = new Dec(yytext);}
    ;

numval:
    NUMVAL { $$ = new Num(yytext);}
    ;

bitval:
    BITVAL { $$ = new Bit(yytext);}
    ;
%%

void yyerror(char const* x){
    printf("Error %s! \n",x);
    exit(1);    
}