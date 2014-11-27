#!/bin/bash

function usage {
    echo "Usage: ./repack.sh <ticket>"
}

[ $# -eq 0 ] && { usage; exit 1; }

source "$1"

read -d '' POM_XML << EOF
<?xml version="1.0" encoding="UTF-8"?>

<project>
  <modelVersion>4.0.0</modelVersion>
  <groupId>org.clojars.rexim</groupId>
  <artifactId>${ARTIFACT_ID}-natives</artifactId>
  <version>${VERSION}</version>
  <description>Native dependencies for ${ARTIFACT_ID}</description>
</project>
EOF

REPO_URL="https://repo1.maven.org/maven2"
BASE_URL="${REPO_URL}/${GROUP_ID//.//}/${ARTIFACT_ID}/${VERSION}"

PLATFORMS=("linux:linux" "osx:macosx" "windows:windows")
ARCHS=("x86" "x86_64")

mkdir "${ARTIFACT_ID}-natives"
cd "${ARTIFACT_ID}-natives"

for PLATFORM in "${PLATFORMS[@]}"; do
    PLATFORM_NAME="${PLATFORM%:*}"
    PLATFORM_FOLDER="native/${PLATFORM##*:}"

    JAR_NAME="${ARTIFACT_ID}-${VERSION}-natives-${PLATFORM_NAME}.jar"
    URL_TO_JAR="${BASE_URL}/${JAR_NAME}"
    wget "${URL_TO_JAR}"

    for ARCH in "${ARCHS[@]}"; do
        OUTPUT_FOLDER="${PLATFORM_FOLDER}/${ARCH}"
        mkdir -pv "${OUTPUT_FOLDER}"
        unzip "${JAR_NAME}" -d "${OUTPUT_FOLDER}"
        rm -rfv "${OUTPUT_FOLDER}/META-INF"
    done

    rm -fv "${JAR_NAME}"
done

jar cfMv "${ARTIFACT_ID}-natives-${VERSION}.jar" native
echo "${POM_XML}" > pom.xml
rm -rf native

cd ..
