include_directories(. src)

add_subdirectory(bc-parser)

add_library(CompilerSources OBJECT
        src/empty.cpp # TODO replace with your files
        )

add_library(BytecodeSources OBJECT
        src/empty.cpp # TODO replace with your files
        )

add_executable(mitscriptc src/bytecode-compiler.cpp)
target_link_libraries(mitscriptc CompilerSources BC_Parser)

# If you call this mitscript instead, make sure you rename/comment out your interpreter executable
add_executable(mitscriptbc src/bytecode-interpreter.cpp)

# add InterpreterSources or anything you need from the interpreter directory
target_link_libraries(mitscriptbc CompilerSources BytecodeSources BC_Parser)

