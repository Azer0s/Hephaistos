#pragma once
#include <vector>
#include <string>
#include <memory>
#include "../nodes.hpp"

namespace hephaistos {
    class Function : public SyntaxTree{
        public:
            Function(SyntaxTree* name, SyntaxTree* statements){
                children.push_back(name);
                children.push_back(statements);
            };
            virtual ~Function(){};
            virtual std::string toCode() const{
                std::string code;
                for(SyntaxTree* node : children){
                    code += node->toCode();
                }
                return code;
            };
    };
}