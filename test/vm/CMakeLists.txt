include_directories(../../vm/src)

add_executable(bc-compiler-tests ../run-unit-tests.cpp
        example-test.cpp
        # TODO add more tests
        )

add_test(bc-compiler-tests bc-compiler-tests)
target_link_libraries(bc-compiler-tests
        gtest gtest_main gmock
        CompilerSources
        )

add_executable(bc-interpreter-tests ../run-unit-tests.cpp
        example-interpreter-test.cpp
        # TODO add more tests
        )
add_test(bc-interpreter-tests bc-interpreter-tests)

target_link_libraries(bc-interpreter-tests
        gtest gtest_main gmock
        BytecodeSources
        )