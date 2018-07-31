cmake_minimum_required(VERSION 3.10)
project(infra)

# Build Options
option(BUILD_SHARED   "Build shared libraries"          OFF)
option(BUILD_EXAMPLES "Build example applications"      ON)
option(BUILD_UT       "Build unit test applications"    ON)

# printing in colors
string(ASCII 27 Esc)
set(Reset   "${Esc}[m"  )
set(Red     "${Esc}[31m")
set(Blue    "${Esc}[34m")
set(Green   "${Esc}[32m")
set(Yellow  "${Esc}[33m")

message("${Blue}Options: BUILD_SHARED=${BUILD_SHARED} BUILD_EXAMPLES=${BUILD_EXAMPLES} BUILD_UT=${BUILD_UT}${Reset}")

# Default filename postfix for libraries under configuration DEBUG
set(CMAKE_DEBUG_POSTFIX d)


# If no type is given explicitly (STATIC or SHARED)
# then the type is based on whether the current value of 
# the variable BUILD_SHARED_LIBS is ON.
if (BUILD_SHARED)
    set(BUILD_SHARED_LIBS ON)
else ()
    set(BUILD_SHARED_LIBS OFF)
endif ()

if (CMAKE_BUILD_TYPE MATCHES Debug)
    set(CMAKE_CXX_FLAGS ${CMAKE_CXX_FLAGS} -std=c++14 -g -O0 -Wall -Wextra)
else ()
    set(CMAKE_CXX_FLAGS ${CMAKE_CXX_FLAGS} -std=c++14 -O2 -Wall -Wextra)
endif ()


set(API_DIR ext_api)

set(PACKAGE_NAME ${CMAKE_PROJECT_NAME})
set(EXPORT_NAME ${PACKAGE_NAME}-export)
set(NAMESPACE_NAME ${PACKAGE_NAME}::)
set(EXPORT_FILE ${PACKAGE_NAME}-config.cmake)

add_subdirectory(mylib1)
add_subdirectory(mylib2)

