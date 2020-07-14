
cmake_minimum_required(VERSION 3.0.0)

project(vscode-example VERSION 0.1.0)

include(CTest)
enable_testing()

include_directories(src/lib)

add_subdirectory(src/lib)
add_subdirectory(src/bin)

set(CPACK_PROJECT_NAME ${PROJECT_NAME})
set(CPACK_PROJECT_VERSION ${PROJECT_VERSION})
include(CPack)
