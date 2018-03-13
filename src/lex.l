%option noyywrap

%{
    #include "grammar.tab.h"
%}

%{
    //Functions
%}
FUNCTION                "func"
NAME                    [a-zA-Z][a-zA-Z0-9]+
LEFT_BRACKET            "["
RIGHT_BRACKET           "]"

%{
    //Blocks
%}
END                     "end"

%{
    //Misc
%}
MAIN                    "main"
COMMENT                 \/\/.*
WHITESPACE              [ \r\t\v\f]
FEED                    \n

%%
{MAIN}                  printf("Lex: Main method\n"); return MAIN;
{END}                   printf("Lex: Block-end\n"); return END;

{FUNCTION}              printf("Lex: Function decleration\n"); return FUNCTION;
{NAME}                  printf("Lex: Function name\n"); return NAME;
{LEFT_BRACKET}          printf("Lex: Left bracket\n"); return LEFT_BRACKET;
{RIGHT_BRACKET}         printf("Lex: Right bracket\n"); return RIGHT_BRACKET;

{FEED}                  yylineno++;
{WHITESPACE}
{COMMENT}
%%