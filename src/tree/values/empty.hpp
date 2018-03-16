#pragma once
#include "../syntaxtree.hpp"
#include <string>
#include <sstream>

namespace hephaistos {
    class Empty : public SyntaxTree{
        public:
            Empty(){}
            virtual ~Empty() = default;
            virtual std::string toCode() const{
                return "";
            }
    };
}