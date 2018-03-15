%option noyywrap

%{
    #include "grammar.tab.h"
%}

%{
    //Functions
%}
FUNCTION                    func|FUNC
NAME                        [a-zA-Z][a-zA-Z0-9]+
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
WORDVAL                     '[^\n']*'

%{
    //Blocks
%}
WHILE                       while|WHILE
FOR                         for|FOR
IF                          if|IF
ELSE                        else|ELSE
END                         end|END

%{
    //Built-in functions
%}
OUT                         "out"
IN                          "in"

%{
    //Misc
%}
MAIN                        "main"
COLON                       ":"
COMMENT                     \/\/.*
MULTILINECOMMENT            "/*"
WHITESPACE                  [ \r\t\v\f]
FEED                        \n

%%
{MAIN}                      printf("main\n");return MAIN;
{END}                       printf("end\n");return END;
{COLON}                     printf(":\n");return COLON;

{FUNCTION}                  printf("function\n");return FUNCTION;
{LEFT_BRACKET}              printf("lbr\n");return LEFT_BRACKET;
{RIGHT_BRACKET}             printf("rbr\n");return RIGHT_BRACKET;

{WORD}                      printf("word\n");return WORD;
{NUM}                       printf("num\n");return NUM;
{DEC}                       printf("dec\n");return DEC;
{BIT}                       printf("bit\n");return BIT;
{OBJECT}                    printf("object\n");return OBJECT;

%{
    //TODO: Var values
%}
{WORDVAL}                   printf("wordval\n");return WORDVAL;

{WHILE}                     return WHILE;
{FOR}                       return FOR;
{IF}                        return IF;
{ELSE}                      return ELSE;

{OUT}                       printf("out\n");return OUT;
{IN}                        printf("in\n");return IN;

{NAME}                      printf("name\n");return NAME;

{FEED}                       yylineno++;
{WHITESPACE}
{COMMENT}
{MULTILINECOMMENT}      {
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
                                    printf ("Error: EOF in comment.\n");
                                    break;
                                }
                            }
                        }
%%