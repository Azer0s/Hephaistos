%option noyywrap

%{
    #include "grammar.tab.h"
    #include "../src/tree/syntaxtree.hpp"
    #include "../src/tree/nodes.hpp"
%}

%{
    //Functions
%}
FUNCTION                    func|FUNC
NAME                        [a-zA-Z][a-zA-Z0-9]*
LEFT_BRACKET                "["
RIGHT_BRACKET               "]"

%{
    //Access modifiers
%}
CLOSED                      closed|CLOSED
REACHABLE                   reachable|REACHABLE
GLOBAL                      global|GLOBAl

%{
    //Datatypes
%}
WORD                        word|WORD
NUM                         num|NUM
DEC                         dec|DEC
BIT                         bit|BIT
OBJECT                      object|OBJECT

%{
    //Datatypevalues
%}
WORDVAL                     \'[^\n']*\'
NUMVAL                      [0-9]+
DECVAL                      {NUMVAL}+\.{NUMVAL}+
BITVAL                      TRUE|FALSE|true|false

%{
    //Blocks
%}
WHILE                       while|WHILE
FOR                         for|FOR
IF                          if|IF
ELSE                        else|ELSE
END                         end|END
BREAK                       break|BREAK

%{
    //Misc
%}
AS                          as|AS
COLON                       ":"
COMMA                       ","
COMMENT                     \/\/.*
MULTILINECOMMENT            "/*"
WHITESPACE                  [ \r\t\v\f]
FEED                        \n

%%
{AS}                        return AS;
{COLON}                     return COLON;
{COMMA}                     return COMMA;

{FUNCTION}                  return FUNCTION;
{LEFT_BRACKET}              return LEFT_BRACKET;
{RIGHT_BRACKET}             return RIGHT_BRACKET;

{CLOSED}                    return CLOSED;
{REACHABLE}                 return REACHABLE;
{GLOBAL}                    return GLOBAL;

{WORD}                      return WORD;
{NUM}                       return NUM;
{DEC}                       return DEC;
{BIT}                       return BIT;
{OBJECT}                    return OBJECT;

{WORDVAL}                   return WORDVAL;
{DECVAL}                    return DECVAL;
{NUMVAL}                    return NUMVAL;
{BITVAL}                    return BITVAL;

{WHILE}                     return WHILE;
{FOR}                       return FOR;
{IF}                        return IF;
{ELSE}                      return ELSE;
{END}                       return END;
{BREAK}                     return BREAK;

{NAME}                      return NAME;
{FEED}                      yylineno++;
{WHITESPACE}
{COMMENT}
{MULTILINECOMMENT}          {
    register int c;

    for(;;)
    {
        while ((c = yyinput ()) != '*' && c != EOF){
            /* eat up text of comment. */     

            if(c == '\n'){
                yylineno++;
            }

        }

        if (c == '*')
        {
            while ((c = yyinput ()) == '*'){}

            if (c == '/'){
                break; /* found the end. */
            }
        }

        if (c == EOF){
            printf("Error: EOF in comment.\n");
            break;
        }
    }
}
%%
