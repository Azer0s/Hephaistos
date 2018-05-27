#pragma once
#include <vector>
#include <string>
#include <memory>
#include "../nodes.hpp"

namespace hephaistos {
    class Statements : public SyntaxTree{
        public:
            Statements(SyntaxTree* c_tree, SyntaxTree* c_subtree){
                tree = c_tree;
                subtree = c_subtree;
            };
            virtual ~Statements(){
                delete tree;
                delete subtree;
            };
            virtual std::string toCode() const{
                return tree->toCode() + ";\n" + subtree->toCode();
            };

        private:
            SyntaxTree* tree;
            SyntaxTree* subtree;
    };
}