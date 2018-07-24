cmake_minimum_required(VERSION 2.8.12)
project(infra)

# Default filename postfix for libraries under configuration DEBUG
set(CMAKE_DEBUG_POSTFIX d)

# If no type is given explicitly (STATIC or SHARED)
# then the type is based on whether the current value of 
# the variable BUILD_SHARED_LIBS is ON.
set(BUILD_SHARED_LIBS OFF)

set(API_DIR ext_api)
set(NAMESPACE_NAME ${CMAKE_PROJECT_NAME}::)

add_subdirectory(mylib1)
add_subdirectory(mylib2)

