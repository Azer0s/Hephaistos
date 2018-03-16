#pragma once
#include "../syntaxtree.hpp"

namespace hephaistos {
    class InputvalueDecleration : public SyntaxTree{
        public:
            InputvalueDecleration(SyntaxTree* val, SyntaxTree* vals){
                datatype = val;
                name = vals;
            }
            virtual ~InputvalueDecleration(){
                delete datatype;
                delete name;
            };
            virtual std::string toCode() const{
                return datatype->toCode() + " " + name->toCode();
            }

        private:
            SyntaxTree* datatype;
            SyntaxTree* name;
    };
}