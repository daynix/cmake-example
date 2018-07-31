project(mylib2)

set(SOURCES 
    mylib2.c
    ${API_DIR}/mylib2.h
)

add_library(${PROJECT_NAME} ${SOURCES})

add_library(${NAMESPACE_NAME}${PROJECT_NAME} ALIAS ${PROJECT_NAME})

target_include_directories(mylib2 PUBLIC
    $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/${API_DIR}>)

target_include_directories(mylib2 INTERFACE
    $<INSTALL_INTERFACE:include>
)

install(FILES ${API_DIR}/mylib2.h
    DESTINATION include
)

# If no type is given explicitly (STATIC or SHARED)
# then the type is based on whether the current value of 
# the variable BUILD_SHARED_LIBS is ON.

install(TARGETS ${PROJECT_NAME}
    EXPORT ${EXPORT_NAME}
    ARCHIVE DESTINATION lib
    LIBRARY DESTINATION lib
    RUNTIME DESTINATION bin
)

install(EXPORT ${EXPORT_NAME}
    NAMESPACE ${NAMESPACE_NAME}
    DESTINATION ${PACKAGE_NAME}
    FILE ${EXPORT_FILE}
)

export(EXPORT ${EXPORT_NAME}
    NAMESPACE ${NAMESPACE_NAME}
#    FILE ${EXPORT_FILE}
)

