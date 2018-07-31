BUILD_DIR=build
EXPORT_DIR=export
INSTALL_DIR=install

function usage()
{
    echo -e "Usage: $(basename $0) [options]\n"
    echo -e "options:"
    echo -e "-c | --clean   : clean the build products"
    echo -e "-S | --shared  : build shared libraries, default: static"
    echo -e "-V | --verbose : produce verbose output, default: off"
    exit 1
}

function parse_args()
{
    options=$(getopt -o "cSV" -l "clean,shared,verbose" -- "$@")
    if [ $? -ne 0 ]; then
        usage
    fi

    eval set -- ${options}

    while [ $# -gt 1 ]; do
        case $1 in
            -c|--clean) CLEAN=true; ;;
            -S|--shared) SHARED=true; ;;
            -V|--verbose) VERBOSE=true; ;;
            # default options
            (--) shift; break ;;
            (-*) echo "$0: error - unrecognized option $1" 1>&2; usage; ;;
            (*) break ;;
        esac
        shift
    done
}

parse_args $@

if [[ "${CLEAN}" = true ]]; then
    rm -rf ${PWD}/${BUILD_DIR} || exit 1
    echo "${PWD}/${BUILD_DIR} REMOVED"
    exit 0
fi

if [[ "${SHARED}" = true ]]; then
    OPT_SHARED="-DBUILD_SHARED:BOOL=ON"
else
    OPT_SHARED="-DBUILD_SHARED:BOOL=OFF"
fi

if [[ "${VERBOSE}" = true ]]; then
    OPT_VERBOSE="-DCMAKE_VERBOSE_MAKEFILE:BOOL=ON -DCMAKE_RULE_MESSAGES:BOOL=ON"
else
    OPT_VERBOSE="-DCMAKE_VERBOSE_MAKEFILE:BOOL=OFF -DCMAKE_RULE_MESSAGES:BOOL=OFF"
fi

function build_project()
{
    local PROJECT_NAME=$1

    echo -e "\nGenerate ${PROJECT_NAME}\n"
    # cmake -H <home-dir> -B <build-dir>
    cmake -H${PROJECT_NAME} -B${BUILD_DIR}/${PROJECT_NAME} \
        -DCMAKE_INSTALL_PREFIX=${BUILD_DIR}/${EXPORT_DIR} \
        ${OPT_SHARED} \
        ${OPT_VERBOSE}

    echo -e "\nBuild install ${PROJECT_NAME}\n"
    # Build <tgt> instead of default targets
    cmake --build ${BUILD_DIR}/${PROJECT_NAME} --target install \
        -- -j
}


build_project infra
build_project app

