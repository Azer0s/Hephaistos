%{
    #include <math.h>
    #include <stdio.h>
    #include <stdlib.h>

    int yylex(void);
    void yyerror(char const*);
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

%token MAIN
%token COLON

%start input

%%

input:
    mainmethod

mainmethod:
    FUNCTION MAIN LEFT_BRACKET RIGHT_BRACKET
    END
%%

void yyerror(char const* x){
    printf("Error %s! \n",x);
    exit(1);    
}