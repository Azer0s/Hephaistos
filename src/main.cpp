#include <iostream>

extern int yyparse();
extern int yylex();
extern int yylineno;

int main(){
    int result = yyparse();
    
    if(result == 0){
        std::cout << "Input is valid!" << std::endl;
    }else{
        std::cout << "Input invalid!" << std::endl;
    }

    std::cout << "Lines in source file: " << yylineno << std::endl;

    return result;
}