project(utest)

set(SOURCES
    main.c
)

add_executable(${PROJECT_NAME} ${SOURCES})

target_link_libraries(${PROJECT_NAME}
    infra::mylib1
    infra::mylib2
)

install(TARGETS ${PROJECT_NAME}
    RUNTIME DESTINATION bin/tests
)
