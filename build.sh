# Uncomment if using make
# make -C vm; exit

# CMake build process
: ${CMAKE_DIR:=cmake-build-grading}

cmake -D CMAKE_BUILD_TYPE=Release -S . -B $CMAKE_DIR
cmake --build $CMAKE_DIR

# create symlinks, so that executables are accessible in the source tree
rm vm/mitscriptc vm/mitscript
BUILD_DIR=$(realpath $CMAKE_DIR)
ln -s $BUILD_DIR/vm/mitscriptc vm/mitscriptc
ln -s $BUILD_DIR/vm/mitscriptbc vm/mitscript
