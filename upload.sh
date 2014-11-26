#!/bin/bash

LWJGL=(lwjgl-platform-natives/lwjgl-platform-natives-*.jar)
JINPUT=(jinput-platform-natives/jinput-platform-natives-*.jar)

mvn deploy:deploy-file \
    -Dfile=$LWJGL \
    -Durl=https://clojars.org/repo \
    -DrepositoryId=clojars \
    -DpomFile=lwjgl-platform-natives/pom.xml

mvn deploy:deploy-file \
    -Dfile=$JINPUT \
    -Durl=https://clojars.org/repo \
    -DrepositoryId=clojars \
    -DpomFile=jinput-platform-natives/pom.xml

