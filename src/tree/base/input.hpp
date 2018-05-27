#pragma once
#include "../syntaxtree.hpp"

namespace hephaistos{
    class Input : public SyntaxTree{
        public:
            Input(SyntaxTree* c_inputa, SyntaxTree* c_inputb){
                inputa = c_inputa;
                inputb = c_inputb;
            }
            virtual ~Input(){
                delete inputa;
                delete inputb;
            };
            virtual std::string toCode() const{
                return inputa->toCode() + "," + inputb->toCode();
            }

        private:
            SyntaxTree* inputa;
            SyntaxTree* inputb;
    };
}