%{
    #include <math.h>
    #include <stdio.h>
    #include <stdlib.h>

    int yylex(void);
    void yyerror(char const*);
%}

%token FUNCTION MAIN LEFT_BRACKET RIGHT_BRACKET
%start input

%%

input:
    FUNCTION MAIN LEFT_BRACKET RIGHT_BRACKET

%%

void yyerror(char const* x){
    printf("Error %s! \n",x);
    exit(1);    
}