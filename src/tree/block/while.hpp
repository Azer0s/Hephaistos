#pragma once
#include <vector>
#include <string>
#include <memory>
#include "../nodes.hpp"

namespace hephaistos {
    class While : public SyntaxTree{
        public:
            While(SyntaxTree* c_condition, SyntaxTree* c_block){
                condition = c_condition;
                block = c_block;
            };
            virtual ~While(){
                delete condition;
                delete block;
            };
            virtual std::string toCode() const{
                return "while(" + condition->toCode() + ")" + "{\n" + block->toCode() + "\n}";
            };
        private:
            SyntaxTree* condition;
            SyntaxTree* block;
    };
}