%{
    #include <math.h>
    #include <stdio.h>
    #include <stdlib.h>

    int yylex(void);
    void yyerror(char const*);
%}

%token NAME
%token FUNCTION
%token MAIN
%token LEFT_BRACKET
%token RIGHT_BRACKET
%token END
%start input

%%

input:
    FUNCTION MAIN LEFT_BRACKET RIGHT_BRACKET END
%%

void yyerror(char const* x){
    printf("Error %s! \n",x);
    exit(1);    
}