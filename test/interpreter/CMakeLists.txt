include_directories(
        ../../interpreter
        ../../interpreter/src
)

add_executable(parser-tests ../run-unit-tests.cpp
        example-test.cpp
        # TODO add more tests
        )

add_test(parser-tests parser-tests)
target_link_libraries(parser-tests gtest gtest_main gmock)

# link to MITScriptGrammar which will
# - add antlr
# - add grammar
# - add include_dirs
target_link_libraries(parser-tests MITScriptGrammar ParserSources)

add_executable(interpreter-tests ../run-unit-tests.cpp
        example-test.cpp
        # TODO add more tests
        )
add_test(interpreter-tests interpreter-tests)

target_link_libraries(interpreter-tests gtest gtest_main gmock)

# link to MITScriptGrammar which will
# - add antlr
# - add grammar
# - add include_dirs
target_link_libraries(interpreter-tests MITScriptGrammar InterpreterSources)