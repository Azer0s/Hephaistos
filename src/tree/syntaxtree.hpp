#pragma once
#include <vector>
#include <string>
#include <memory>

namespace hephaistos {
    class SyntaxTree {
        public:
            SyntaxTree() = default;
            virtual ~SyntaxTree() = default;
            virtual std::string toCode() const = 0;
    };
}