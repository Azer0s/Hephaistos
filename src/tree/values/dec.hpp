#pragma once
#include "../syntaxtree.hpp"
#include <string>
#include <sstream>

namespace hephaistos {
    class Dec : public SyntaxTree{
        public:
            Dec(const std::string& val){
                value = std::stod(val);
            }
            virtual ~Dec() = default;
            virtual std::string toCode() const{
                return std::to_string(value);
            }

        private:
            double value;
    };
}