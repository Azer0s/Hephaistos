#include <iostream>

extern int yyparse();
extern int yylex();

int main(){
    int result = yyparse();

    if(result == 0){
        std::cout << "Input is valid!" << std::endl;
    }else{
        std::cout << "Input invalid!" << std::endl;
    }

    return result;
}