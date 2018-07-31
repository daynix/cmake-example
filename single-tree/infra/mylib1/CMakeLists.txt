project(mylib1)

set(API_HEADERS
    ${API_DIR}/mylib1.h
)

set(SOURCES 
    mylib1.c
    mylib1_priv.h
    ${API_HEADERS}
)

add_library(${PROJECT_NAME} ${SOURCES})

target_include_directories(${PROJECT_NAME}
    PUBLIC
        $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/${API_DIR}>
    PRIVATE
        $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}>
)

# If no type is given explicitly (STATIC or SHARED)
# then the type is based on whether the current value of
# the variable BUILD_SHARED_LIBS is ON.

install(TARGETS ${PROJECT_NAME}
    ARCHIVE DESTINATION lib
    LIBRARY DESTINATION bin
    RUNTIME DESTINATION bin
    INCLUDES DESTINATION include
)

