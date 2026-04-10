set(VCPKG_LIBRARY_LINKAGE dynamic)
set(VCPKG_POLICY_DLLS_IN_STATIC_LIBRARY enabled)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO ip7z/7zip
    REF "${VERSION}"
    SHA512 5f4922efd94e12776e531f77053981978a0d9f8c6da50f51bdb750a54436b07ddccafa6a1180fd234a7fcaf4d2a5b0ab7c2a9267da2ea8e68407bf432ff0f76c
    HEAD_REF main
)

vcpkg_download_distfile(
    CMAKEFILE_PATH
    URLS https://raw.githubusercontent.com/microsoft/vcpkg/f4c23ffc72ab26026394a83504dd9b5d50774833/ports/7zip/CMakeLists.txt
    FILENAME CMakeLists.txt
    SHA512 845A4F37094F0140F5EFB44C86499AFDA8E6C2B5BEA6F9A44577A974C6E58811DA7494BB3441C5A5009784BD757E85CD98087FD3E3E95DA882298AF6C8E0D1DE
)

file(COPY_FILE "${CMAKEFILE_PATH}" "${SOURCE_PATH}/CMakeLists.txt")
file(COPY "${CMAKE_CURRENT_LIST_DIR}/7zip-config.cmake.in" DESTINATION "${SOURCE_PATH}")

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
)

vcpkg_cmake_install()
vcpkg_copy_pdbs()

vcpkg_cmake_config_fixup()

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/DOC/License.txt")

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")
