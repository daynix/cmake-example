BUILD_DIR=build
PUBLIC_DIR=public
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


# cmake -H <home-dir> -B <build-dir>

# infra

echo -e "\nGenerate infra\n"
cmake -Hinfra -B${BUILD_DIR}/infra \
    -DCMAKE_INSTALL_PREFIX=${BUILD_DIR}/${PUBLIC_DIR} \
    ${OPT_SHARED} \
    ${OPT_VERBOSE}

# Build <tgt> instead of default targets
echo -e "\nBuild install infra\n"
cmake --build ${BUILD_DIR}/infra --target install
    ${OPT_VERBOSE} -j

# myexe

echo -e "\nGenerate myexe\n"
cmake -Hmyexe -B${BUILD_DIR}/myexe \
    -DCMAKE_INSTALL_PREFIX=${PWD}/${BUILD_DIR}/${INSTALL_DIR} \
    -DCMAKE_PREFIX_PATH=${PWD}/${BUILD_DIR}/${PUBLIC_DIR}/lib/export
    ${OPT_SHARED} \
    ${OPT_VERBOSE}

echo -e "\nBuild install myexe\n"
cmake --build ${BUILD_DIR}/myexe --target install
    ${OPT_VERBOSE} -j
