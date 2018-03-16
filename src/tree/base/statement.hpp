#pragma once
#include <vector>
#include <string>
#include <memory>
#include "../nodes.hpp"

namespace hephaistos {
    class Statement : public SyntaxTree{
        public:
            Statement(SyntaxTree* val, SyntaxTree* vals){
                nameval = val;
                inputvals = vals;
            }
            virtual ~Statement(){
                delete nameval;
                delete inputvals;
            };
            virtual std::string toCode() const{
                return nameval->toCode() + "(" + inputvals->toCode() + ")";
            };

        private:
            SyntaxTree* nameval;
            SyntaxTree* inputvals;
    };
}