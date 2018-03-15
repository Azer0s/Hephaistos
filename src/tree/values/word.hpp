#pragma once
#include "../syntaxtree.hpp"
#include <string>
#include <sstream>

void find_and_replace(std::string& source, std::string const& find, std::string const& replace)
{
    for(std::string::size_type i = 0; (i = source.find(find, i)) != std::string::npos;)
    {
        source.replace(i, find.length(), replace);
        i += replace.length();
    }
}

namespace hephaistos {
    class Word : public SyntaxTree{
        public:
            Word(const std::string &val){
                value = val;
                find_and_replace(value,"'","\"");
            }
            virtual ~Word() = default;
            virtual std::string toCode() const{
                return value;
            }

        private:
            std::string value;
    };
}