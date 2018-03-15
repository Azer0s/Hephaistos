#pragma once
#include <vector>
#include <string>
#include <memory>
#include "../nodes.hpp"

namespace hephaistos {
    class Statement : public SyntaxTree{
        public:
            Statement(SyntaxTree* name, SyntaxTree* input){
                nameval = reinterpret_cast<Name*>(name);
                inputvals.push_back(input);
            }
            virtual ~Statement(){
                
            };
            virtual std::string toCode() const{
                std::string inputstr;

                for(SyntaxTree* node : inputvals){
                    inputstr += node->toCode();
                    inputstr += ",";
                }

                inputstr = inputstr.substr(0,inputstr.size() - 1);

                return nameval->toCode() + "(" + inputstr + ")";
            };

        private:
            Name* nameval;
            std::vector<SyntaxTree*> inputvals;
    };
}