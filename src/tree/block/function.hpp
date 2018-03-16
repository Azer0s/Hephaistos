#pragma once
#include <vector>
#include <string>
#include <memory>
#include "../nodes.hpp"

namespace hephaistos {
    class Function : public SyntaxTree{
        public:
            Function(SyntaxTree* val, SyntaxTree* vals){
                decleration = val;
                block = vals;
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