#!/bin/bash

OSX_LIB_FILES=(
    "macosx/liblwjgl.jnilib"
    "macosx/openal.dylib"
)

LINUX_LIB_FILES=(
    "linux/libopenal.so"
    "linux/libopenal64.so"
    "linux/liblwjgl64.so"
    "linux/liblwjgl.so"
)

WINDOWS_LIB_FILES=(
    "windows/lwjgl64.dll"
    "windows/OpenAL32.dll"
    "windows/lwjgl.dll"
    "windows/OpenAL64.dll"
)

SOLARIS_LIB_FILES=(
    "solaris/libopenal.so"
    "solaris/libopenal64.so"
    "solaris/liblwjgl64.so"
    "solaris/liblwjgl.so"
)

OSX_FOLDERS=(
    "native/macosx/x86_64"
    "native/macosx/x86"
)

LINUX_FOLDERS=(
    "native/linux/x86_64"
    "native/linux/x86"
)

WINDOWS_FOLDERS=(
    "native/windows/x86_64"
    "native/windows/x86"
)

ALL_FOLDERS=(
    "${OSX_FOLDERS[@]}"
    "${LINUX_FOLDERS[@]}"
    "${WINDOWS_FOLDERS[@]}"
)

function createAllFolders {
    for folder in "${ALL_FOLDERS[@]}"; do
        mkdir -pv "${folder}"
    done
}

function copyFilesToFolders {
    PLATFORM="$1"
    eval LIB_FILES='(${'$PLATFORM'_LIB_FILES[@]})'
    eval FOLDERS='(${'$PLATFORM'_FOLDERS[@]})'
    for folder in "${FOLDERS[@]}"; do
        for libFile in "${LIB_FILES[@]}"; do
            cp -v "${ORIGINAL_NATIVE_FOLDER}/${libFile}" "${folder}"
        done
    done
}

function usage {
    echo "Usage: ./repack.sh <version> <origin-lwjgl-folder>"
}

ORIGINAL_NATIVE_FOLDER="$1"
VERSION="$2"
PLATFORM_NATIVES_FILENAME="lwjgl-platform-natives-${VERSION}.jar"

createAllFolders

copyFilesToFolders "OSX"
copyFilesToFolders "LINUX"
copyFilesToFolders "WINDOWS"

jar cfMv "${PLATFORM_NATIVES_FILENAME}" native
m4 -DVERSION="${VERSION}" ./pom.xml.m4 > pom.xml
rm -r native
