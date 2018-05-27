#pragma once
#include <vector>
#include <string>
#include <memory>
#include "../nodes.hpp"

namespace hephaistos {
    class If : public SyntaxTree{
        public:
            If(SyntaxTree* c_condition, SyntaxTree* c_block, SyntaxTree* c_else){
                condition = c_condition;
                block = c_block;
                elseBlock = c_else;
            };
            virtual ~If(){
                delete condition;
                delete block;
                delete elseBlock;
            };
            virtual std::string toCode() const{
                return "if(" + condition->toCode() + ")" + "{\n" + block->toCode() + "}" + "else{\n" + elseBlock->toCode() + "}";
            };
        private:
            SyntaxTree* condition;
            SyntaxTree* block;
            SyntaxTree* elseBlock;
    };
}