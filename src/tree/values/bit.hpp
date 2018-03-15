#pragma once
#include "../syntaxtree.hpp"

namespace hephaistos {
    class Bit : public SyntaxTree{
        public:
            Bit(const std::string& val){
                if(val == "true" || val == "TRUE"){
                    value = true;
                }else{
                    value = false;
                }
            }
            virtual ~Bit() = default;
            virtual std::string toCode() const{
                return value ? "true" : "false";;
            }

        private:
            bool value;
    };
}