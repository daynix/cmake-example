cmake_minimum_required(VERSION 2.8.12)
project(myexe)

find_package(mylib1 REQUIRED)
find_package(mylib2 REQUIRED)

add_executable(myexe main.c)

target_link_libraries(myexe infra::mylib1 infra::mylib2)

install(TARGETS myexe DESTINATION bin)
