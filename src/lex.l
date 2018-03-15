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
    //Datatypes
%}
WORD                        "word"
NUM                         "num"
DEC                         "dec"
BIT                         "bit"
OBJECT                      "object"

%{
    //Datatypevalues
%}
WORDVAL                     \'[^\n']*\'
NUMVAL                      [0-9]+
DECVAL                      {NUMVAL}+\.{NUMVAL}+
BITVAL                      TRUE|FALSE|true|false

%{
    //Built-in functions
%}
OUT                         "out"
IN                          "in"

%{
    //Blocks
%}
WHILE                       while|WHILE
FOR                         for|FOR
IF                          if|IF
ELSE                        else|ELSE
END                         end|END

%{
    //Misc
%}
COLON                       ":"
COMMA                       ","
COMMENT                     \/\/.*
MULTILINECOMMENT            "/*"
WHITESPACE                  [ \r\t\v\f]
FEED                        \n

%%
{COLON}                     printf("Colon\n");return COLON;
{COMMA}                     return COMMA;

{FUNCTION}                  printf("Function\n");return FUNCTION;
{LEFT_BRACKET}              printf("lbr\n");return LEFT_BRACKET;
{RIGHT_BRACKET}             printf("rbr\n\n");return RIGHT_BRACKET;

{WORD}                      printf("Word\n");return WORD;
{NUM}                       printf("Num\n");return NUM;
{DEC}                       printf("Dec\n");return DEC;
{BIT}                       printf("Bit\n");return BIT;
{OBJECT}                    printf("Object\n");return OBJECT;

{WORDVAL}                   printf("Wordv\n");yylval = reinterpret_cast<void*>(new hephaistos::Word(yytext));return WORDVAL;
{DECVAL}                    printf("Decv\n");yylval = reinterpret_cast<void*>(new hephaistos::Dec(yytext));return DECVAL;
{NUMVAL}                    printf("Numv\n");yylval = reinterpret_cast<void*>(new hephaistos::Num(yytext));return NUMVAL;
{BITVAL}                    printf("Bitv\n");yylval = reinterpret_cast<void*>(new hephaistos::Bit(yytext));return BITVAL;

{WHILE}                     printf("While\n");return WHILE;
{FOR}                       return FOR;
{IF}                        return IF;
{ELSE}                      return ELSE;
{END}                       printf("End\n\n");return END;

{OUT}                       printf("Out\n");return OUT;
{IN}                        printf("In\n");return IN;

{NAME}                      printf("Name\n");yylval = reinterpret_cast<void*>(new hephaistos::Name(yytext)); return NAME;
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