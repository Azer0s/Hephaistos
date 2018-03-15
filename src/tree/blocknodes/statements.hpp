#pragma once
#include <vector>
#include <string>
#include <memory>
#include "../nodes.hpp"

namespace hephaistos {
    class Statements : public SyntaxTree{
        public:
            Statements(SyntaxTree* tree, SyntaxTree* subtree){
                children.push_back(tree);
                children.push_back(subtree);
            };
            virtual ~Statements(){};
            virtual std::string toCode() const{
                std::string code;
                for(SyntaxTree* node : children){
                    code += node->toCode();
                }
                return code;
            };
    };
}