#!/bin/bash

root_dir="`dirname $0`"
build_dir="${root_dir}/build"
install_dir="${root_dir}/install"

function start_build()
{
    echo "Entering build dir:"
    mkdir -p ${build_dir}
    pushd ${build_dir}
}

function exit_build()
{
    echo -e "\nReturning to working dir:"
    popd
    exit $1
}

start_build

echo -e "\nGenerating...\n"
cmake .. -DCMAKE_INSTALL_PREFIX=${install_dir} || exit_build 1

echo -e "\nBuilding...\n"
make $@ || exit_build 1

echo -e "\nInstalling...\n"
cmake --build ${root_dir} --target ${install_dir} || exit_build 1

exit_build 0
