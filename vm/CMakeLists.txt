include_directories(. src)

add_subdirectory(bc-parser)

add_library(CompilerSources OBJECT
        src/empty.cpp # TODO replace with your files
        )

add_library(BytecodeSources OBJECT
        src/empty.cpp # TODO replace with your files
        )

add_executable(mitscriptbc src/bytecode-compiler.cpp)
target_link_libraries(mitscriptbc CompilerSources BC_Parser)

# TODO make sure you rename/comment out your interpreter executable
# add_executable(mitscript ...)

# add InterpreterSources or anything you need from the interpreter directory
# target_link_libraries(mitscript CompilerSources BytecodeSources)

