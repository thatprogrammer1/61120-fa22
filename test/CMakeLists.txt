# Set up Googletest
cmake_policy(SET CMP0077 NEW) # for the option
set(BUILD_GMOCK TRUE)
add_subdirectory(googletest)
include_directories(${gtest_SOURCE_DIR}/include ${gtest_SOURCE_DIR} ${gmock_SOURCE_DIR}/include ${gmock_SOURCE_DIR})

# Add tests
add_subdirectory(interpreter)
add_subdirectory(vm)
