#pragma once
#include "../syntaxtree.hpp"

namespace hephaistos {
    class FunctionDecleration : public SyntaxTree{
        public:
            FunctionDecleration(SyntaxTree* val, SyntaxTree* vals){
                name = val;
                inputdecleration = vals;
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