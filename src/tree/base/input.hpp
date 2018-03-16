#pragma once
#include "../syntaxtree.hpp"

namespace hephaistos{
    class Input : public SyntaxTree{
        public:
            Input(SyntaxTree* vala, SyntaxTree* valb){
                inputa = vala;
                inputb = valb;
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