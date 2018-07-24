BUILD_DIR=build
PUBLIC_DIR=public
INSTALL_DIR=install

# cmake -H <home-dir> -B <build-dir>
echo -e "\nGenerate infra\n"
cmake -Hinfra -B${BUILD_DIR}/infra -DCMAKE_INSTALL_PREFIX=${BUILD_DIR}/${PUBLIC_DIR}
# Build <tgt> instead of default targets
echo -e "\nBuild install infra\n"
cmake --build ${BUILD_DIR}/infra --target install

echo -e "\nGenerate myexe\n"
cmake -Hmyexe -B${BUILD_DIR}/myexe -DCMAKE_INSTALL_PREFIX=${PWD}/${BUILD_DIR}/${INSTALL_DIR} -DCMAKE_PREFIX_PATH=${PWD}/${BUILD_DIR}/${PUBLIC_DIR}/lib/export
echo -e "\nBuild install myexe\n"
cmake --build ${BUILD_DIR}/myexe --target install
