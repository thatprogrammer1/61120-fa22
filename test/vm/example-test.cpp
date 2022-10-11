#include <gtest/gtest.h>

// You can just use TEST(SuiteName, TestName) for simple tests.

TEST(TestMinus, Basic) {
    ASSERT_EQ(5 - 2, 3);
}

// =====================
// Or, if you want to use a class, use the fixture macro (TEST_F):
// =====================

class Example {
public:
    int a;

    int multiply(int b) { return a * b; };
};

class TestExample : public ::testing::Test {
protected:
    Example ex{4};
};

TEST_F(TestExample, Multiply) {
    EXPECT_EQ(ex.multiply(3), 12);
    ASSERT_EQ(Example{-2}.multiply(0), 0);
}


