#pragma once
#include "../syntaxtree.hpp"
#include <string>
#include <sstream>

namespace hephaistos {
    class Num : public SyntaxTree{
        public:
            Num(const std::string& val){
                value = std::stoi(val);
            }
            virtual ~Num() = default;
            virtual std::string toCode() const{
                return std::to_string(value);
            }

        private:
            int value;
    };
}