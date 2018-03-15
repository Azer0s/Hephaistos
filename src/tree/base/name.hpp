#pragma once
#include "../syntaxtree.hpp"

namespace hephaistos {
    class Name : public SyntaxTree{
        public:
            Name(const std::string& name) : name(name){}
            virtual ~Name() = default;
            virtual std::string toCode() const{
                return name;
            }

        private:
            std::string name;
    };
}