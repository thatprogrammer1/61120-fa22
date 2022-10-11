# generate the parser
add_custom_command(
        OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/bc-parser.cpp ${CMAKE_CURRENT_BINARY_DIR}/bc-parser.h
        COMMAND bison -Dapi.prefix={bc} --output=${CMAKE_CURRENT_BINARY_DIR}/bc-parser.cpp --defines=${CMAKE_CURRENT_BINARY_DIR}/bc-parser.h bc-parser.yy
        WORKING_DIRECTORY ${CMAKE_CURRENT_LIST_DIR}
        DEPENDS bc-parser.yy
)

# generate the parser
add_custom_command(
        OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/bc-lexer.cpp ${CMAKE_CURRENT_BINARY_DIR}/bc-lexer.h
        COMMAND flex -P bc --outfile=${CMAKE_CURRENT_BINARY_DIR}/bc-lexer.cpp --header-file=${CMAKE_CURRENT_BINARY_DIR}/bc-lexer.h bc-lexer.lex
        WORKING_DIRECTORY ${CMAKE_CURRENT_LIST_DIR}
        DEPENDS bc-lexer.lex
)

add_library(BC_Parser ${CMAKE_CURRENT_BINARY_DIR}/bc-lexer.cpp ${CMAKE_CURRENT_BINARY_DIR}/bc-parser.cpp utils.cpp)
target_include_directories(BC_Parser PUBLIC ${CMAKE_CURRENT_BINARY_DIR})

add_executable(bc-parser-example bc-parser-driver.cpp)
target_link_libraries(bc-parser-example BC_Parser)
