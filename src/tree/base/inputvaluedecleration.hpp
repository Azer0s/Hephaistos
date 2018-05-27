#pragma once
#include "../syntaxtree.hpp"

namespace hephaistos {
    class InputvalueDecleration : public SyntaxTree{
        public:
            InputvalueDecleration(SyntaxTree* c_datatype, SyntaxTree* c_name){
                datatype = c_datatype;
                name = c_name;
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