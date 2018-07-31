if (NOT _MESSAGES_CMAKE_INCLUDED)
    include(${INC_CMAKE_DIR}/messages.cmake)
endif()

set(_TARGETS_CMAKE_INCLUDED YES)

function(define_lib lib_name)
    # parse arguments
    set(args_options )
    set(args_single )
    set(args_multi SOURCES PRIV_HEADERS API_HEADERS API_DIR)

    cmake_parse_arguments("LIB" "${args_options}" "${args_single}" "${args_multi}" ${ARGN})

    if(LIB_UNPARSED)
        message("Unparsed arguments for define_lib(${lib_name}: ${LIB_UNPARSED}")
    endif()

    # transform some arguments
    if(LIB_API_DIR)
        set(API_DIR ${LIB_API_DIR})
    endif()

    foreach(hdr ${LIB_API_HEADERS})
        list(APPEND API_HEADERS "${API_DIR}/${hdr}")
    endforeach(hdr)

    # declare new lib project
    project(${lib_name})

    add_library(${PROJECT_NAME}
        ${LIB_SOURCES}
        ${LIB_PRIV_HEADERS}
        ${API_HEADERS}
    )
    # create alias with the namespace
    add_library(${NAMESPACE_NAME}${PROJECT_NAME}
        ALIAS ${PROJECT_NAME}
    )
    # define include dirs for private and public use
    target_include_directories(${PROJECT_NAME} PRIVATE
        $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}>
    )
    target_include_directories(${PROJECT_NAME} PUBLIC
        $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/${API_DIR}>
    )
    target_include_directories(${PROJECT_NAME} INTERFACE
        $<INSTALL_INTERFACE:include>
    )
    install(FILES ${API_HEADERS}
        DESTINATION include
    )
    # define install policies
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
    )
endfunction()

function(define_app app_name)
    # parse arguments
    set(args_options )
    set(args_single )
    set(args_multi SOURCES PRIV_HEADERS API_HEADERS API_DIR LIBS SYS_LIBS INSTALL_DIR)

    cmake_parse_arguments("APP" "${args_options}" "${args_single}" "${args_multi}" ${ARGN})

    if(APP_UNPARSED)
        msg_red("Unparsed arguments for define_app(${app_name}: ${APP_UNPARSED}")
    endif()

    if(APP_API_DIR)
        set(API_DIR ${APP_API_DIR})
    endif()

    if (NOT APP_INSTALL_DIR)
        set(APP_INSTALL_DIR bin)
    else()
        set(APP_INSTALL_DIR bin/${APP_INSTALL_DIR})
    endif()

    # transform some arguments
    foreach(hdr ${APP_API_HEADERS})
        list(APPEND API_HEADERS "${API_DIR}/${hdr}")
    endforeach(hdr)

    # declare new app project
    project(${app_name})

    add_executable(${PROJECT_NAME}
        ${APP_SOURCES}
        ${APP_PRIV_HEADERS}
        ${API_HEADERS}
    )
    # define include dirs for private and public use
    target_include_directories(${PROJECT_NAME} PRIVATE
        $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}>
    )
    if(API_HEADERS)
        target_include_directories(${PROJECT_NAME} PUBLIC
            $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/${API_DIR}>
        )
    endif()
    target_include_directories(${PROJECT_NAME} INTERFACE
        $<INSTALL_INTERFACE:include>
    )
    #define libraries to link with
    target_link_libraries(${PROJECT_NAME}
        ${APP_LIBS}
        ${APP_SYS_LIBS}
    )
    # define install policies
    install(FILES ${API_HEADERS}
        DESTINATION include
    )
    install(TARGETS ${PROJECT_NAME}
        RUNTIME DESTINATION ${APP_INSTALL_DIR}
    )
    if(API_HEADERS)
        install(TARGETS ${PROJECT_NAME}
            EXPORT ${EXPORT_NAME}
        )
        install(EXPORT ${EXPORT_NAME}
            NAMESPACE ${NAMESPACE_NAME}
            DESTINATION ${PACKAGE_NAME}
            FILE ${EXPORT_FILE}
        )
        export(EXPORT ${EXPORT_NAME}
            NAMESPACE ${NAMESPACE_NAME}
        )
    endif()
endfunction()

function(define_utest utest_name)
    define_app(
        ${ARGV}
        INSTALL_DIR
            utests
    )
    msg_green("Unit Test added: ${utest_name}")
endfunction()