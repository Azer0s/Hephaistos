#pragma once
#include <vector>
#include <string>
#include <memory>
#include "../nodes.hpp"

namespace hephaistos {
    class Function : public SyntaxTree{
        public:
            Function(SyntaxTree* c_decleration, SyntaxTree* c_block){
                decleration = c_decleration;
                block = c_block;
            };
            virtual ~Function(){
                delete decleration;
                delete block;
            };
            virtual std::string toCode() const{
                return decleration->toCode() + "{\n" + block->toCode() + "}";
            };
        private:
            SyntaxTree* decleration;
            SyntaxTree* block;
    };
}