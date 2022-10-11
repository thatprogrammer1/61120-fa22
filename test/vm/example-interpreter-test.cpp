#include "bytecode/instructions.h"
#include "bytecode/types.h"
#include <gtest/gtest.h>

TEST(TestMinus, Add) {

    std::stringstream capturedCout;
    Function function{};
    function.constants_ = {new Constant::Integer(2), new Constant::Integer(3)};
    function.instructions = {
        Instruction{Operation::LoadConst, 0},
        Instruction{Operation::LoadConst, 1},
        Instruction{Operation::Add, 0},
        Instruction{Operation::StoreLocal, 0},
        // TODO print the variable
    };

    // TODO
    // bytecode::Interpreter interpreter{capturedCout};
    // interpreter.interpret(function);

    ASSERT_EQ(capturedCout.str(), "5");

}