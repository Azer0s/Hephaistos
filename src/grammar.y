%{
    #include <math.h>
    #include <stdio.h>
    #include <stdlib.h>
    #include "../src/tree/nodes.hpp"
    #include <iostream>
    #include <vector>
    #include <memory>

    int yylex(void);
    void yyerror(char const*);
    extern char* yytext;
    hephaistos::SyntaxTree* root;
    hephaistos::SyntaxTree* p;
    std::vector<hephaistos::SyntaxTree*> mainobject;
    #define YYSTYPE hephaistos::SyntaxTree*
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

%token COLON
%token COMMA

%start input

%%

input:
    program { root = new hephaistos::Program(mainobject,$1); }
    ;

program:
    block program { mainobject.push_back($1); $$ = $2; }
    | function program { $$ = new hephaistos::Statements($1,$2);}
    | %empty { $$ = new hephaistos::Empty();}
    ;

//Multiple statements with loops and conditions, todo implement loops
block:
    statements { $$ = $1; }
    | while
    | %empty
    ;

//Multiple statements together
statements:
    statement statements { $$ = new hephaistos::Statements($1,$2); }
    | %empty { $$ = new hephaistos::Empty(); }
    ;

//Single line of code
statement:
    name COLON name { $$ = new hephaistos::Statement($1, $3); }
    | name COLON wordval { $$ = new hephaistos::Statement($1, $3); }
    | name COLON numval { $$ = new hephaistos::Statement($1, $3); }                                 
    | name COLON decval { $$ = new hephaistos::Statement($1, $3); }
    | name COLON bitval { $$ = new hephaistos::Statement($1, $3); }
    | name COLON LEFT_BRACKET inputvalues RIGHT_BRACKET { $$ = new hephaistos::Statement($1, $4); }
    ;

inputvalue:
    bitval
    | decval { $$ = $1;}
    | numval { $$ = $1;}
    | wordval { $$ = $1;}
    | name { $$ = $1;}
    | statement { $$ = $1;}
    | %empty { $$ = new hephaistos::Empty(); }
    ;

//Multiple inputvalues
inputvalues:
    | inputvalue COMMA inputvalues { $$ = new hephaistos::Input($1,$3); }
    | inputvalue { $$ = $1;}
    ;

//Function
function:
    functiondecleration block END { $$ = new hephaistos::Function($1,$2); }
    | %empty { $$ = new hephaistos::Empty(); }
    ;

//Function decleration
functiondecleration:
    FUNCTION name LEFT_BRACKET RIGHT_BRACKET { $$ = new hephaistos::FunctionDecleration($2,new hephaistos::Empty());}
    | FUNCTION name LEFT_BRACKET input RIGHT_BRACKET { $$ = new hephaistos::FunctionDecleration($2,$4);}
    ;

//Input values for functiondecleration
input:
    | num name { $$ = new hephaistos::InputvalueDecleration($1,$2); }
    | word name { $$ = new hephaistos::InputvalueDecleration($1,$2); }
    | dec name { $$ = new hephaistos::InputvalueDecleration($1,$2); }
    | bit name { $$ = new hephaistos::InputvalueDecleration($1,$2); }
    | object name { $$ = new hephaistos::InputvalueDecleration($1,$2); }
    | input COMMA input { $$ = new hephaistos::Input($1,$3); }
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
    NAME { $$ = new hephaistos::Name(yytext); }
    ;

wordval:
    WORDVAL { $$ = new hephaistos::Word(yytext); }
    ;

decval:
    DECVAL { $$ = new hephaistos::Dec(yytext); }
    ;

numval:
    NUMVAL { $$ = new hephaistos::Num(yytext); }
    ;

bitval:
    BITVAL { $$ = new hephaistos::Bit(yytext); }
    ;

word:
    WORD {$$ = new hephaistos::Name("std::string"); }
    ;

dec:
    DEC {$$ = new hephaistos::Name("double");}
    ;

num:
    NUM {$$ = new hephaistos::Name("int");}
    ;

bit:
    BIT {$$ = new hephaistos::Name("bool");}
    ;

object:
    OBJECT {$$ = new hephaistos::Name("");}
    ;
%%

void yyerror(char const* x){
    printf("Error %s! \n",x);
    exit(1);    
}
