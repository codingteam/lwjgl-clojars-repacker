# LWJGL repacker script for clojars

Quick usage example:

    $ wget http://cznic.dl.sourceforge.net/project/java-game-lib/Official%20Releases/LWJGL%202.9.1/lwjgl-2.9.1.zip
    $ unzip lwjgl-2.9.1.zip
    $ ./repack.sh lwjgl-2.9.1/native 2.9.1

You'll `lwjgl-platform-natives-2.9.1.jar` and `pom.xml` which you can
upload to [clojars.org](http://clojars.org/).
