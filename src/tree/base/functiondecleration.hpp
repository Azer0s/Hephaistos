#pragma once
#include "../syntaxtree.hpp"

namespace hephaistos {
    class FunctionDecleration : public SyntaxTree{
        public:
            FunctionDecleration(SyntaxTree* c_name, SyntaxTree* c_inputdecleration){
                name = c_name;
                inputdecleration = c_inputdecleration;
            }
            virtual ~FunctionDecleration(){
                delete name;
                delete inputdecleration;
            };
            virtual std::string toCode() const{
                return "\nauto " + name->toCode() + " (" + inputdecleration->toCode() + ")";
            }

        private:
            SyntaxTree* name;
            SyntaxTree* inputdecleration;
    };
}