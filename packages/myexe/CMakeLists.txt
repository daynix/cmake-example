cmake_minimum_required(VERSION 3.10)
project(myexe)

find_package(infra REQUIRED)

add_executable(myexe main.c)

target_link_libraries(myexe infra::mylib1 infra::mylib2)

install(TARGETS myexe DESTINATION bin)
