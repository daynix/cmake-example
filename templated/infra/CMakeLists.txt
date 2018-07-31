cmake_minimum_required(VERSION 3.10)
project(infra LANGUAGES CXX)

# include CMake utils
set(INC_CMAKE_DIR ${PROJECT_SOURCE_DIR}/../cmake)
include(${INC_CMAKE_DIR}/messages.cmake)
include(${INC_CMAKE_DIR}/packages.cmake)
include(${INC_CMAKE_DIR}/targets.cmake)

# Build Options
option(BUILD_SHARED   "Build shared libraries"          OFF)
option(BUILD_EXAMPLES "Build example applications"      ON)
option(BUILD_UT       "Build unit test applications"    ON)

msg_blue("Options: BUILD_SHARED=${BUILD_SHARED} BUILD_EXAMPLES=${BUILD_EXAMPLES} BUILD_UT=${BUILD_UT}")

# If no type is given explicitly (STATIC or SHARED)
# then the type is based on whether the current value of 
# the variable BUILD_SHARED_LIBS is ON.
if (BUILD_SHARED)
    set(BUILD_SHARED_LIBS ON)
else ()
    set(BUILD_SHARED_LIBS OFF)
endif ()

# set common compile options
add_compile_options(-std=c++14)
add_compile_options(-Wall -Wextra)
if (CMAKE_BUILD_TYPE MATCHES Debug)
    add_compile_options(-g -O0)
else ()
    add_compile_options(-O2)
endif ()

# Default External (public) API subdirectory
set(API_DIR ext_api)

# Default filename postfix for libraries under configuration DEBUG
set(CMAKE_DEBUG_POSTFIX _dbg)

# Set up the current package 
define_package(${PROJECT_NAME})

# Find other packages
find_package(infra REQUIRED)

# Add the sub-tree
add_subdirectory(mylib1)
add_subdirectory(mylib2)
add_subdirectory(utest)

