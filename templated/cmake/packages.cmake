
if (NOT _MESSAGES_CMAKE_INCLUDED)
    include(${INC_CMAKE_DIR}/messages.cmake)
endif()

set(_PACKAGES_CMAKE_INCLUDED YES)

macro(define_package name)
    set(PACKAGE_NAME ${name})

    set(EXPORT_NAME ${PACKAGE_NAME}-export)
    set(NAMESPACE_NAME ${PACKAGE_NAME}::)
    set(EXPORT_FILE ${PACKAGE_NAME}-config.cmake)
endmacro()

macro(find_package)
    if(NOT SINGLE_TREE)
        if(NOT "${ARGV0}" EQUAL ${PACKAGE_NAME})
            msg_green("find_package( ${ARGV} ) from package: ${PACKAGE_NAME}")
            _find_package(${ARGV})
        else ()
            msg_green("find_package( ${ARGV} ) skipped - inside package: ${PACKAGE_NAME}")
        endif()
    else()
        msg_green("find_package( ${ARGV} ) skipped - single tree setup")
    endif()
endmacro()
