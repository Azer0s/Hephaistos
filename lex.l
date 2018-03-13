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
WHITESPACE              [ \r\t\v\f]
FEED                    \n

%%
{FUNCTION}              return FUNCTION;
{NAME}                  return NAME;
{LEFT_BRACKET}          return LEFT_BRACKET;
{RIGHT_BRACKET}         return RIGHT_BRACKET;


{MAIN}                  return MAIN;
{FEED}                  yylineno++;
{WHITESPACE}
%%