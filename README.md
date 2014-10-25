# LWJGL repacker script for clojars

Quick usage example:

    $ wget http://cznic.dl.sourceforge.net/project/java-game-lib/Official%20Releases/LWJGL%202.9.1/lwjgl-2.9.1.zip
    $ unzip lwjgl-2.9.1.zip
    $ ./repack.sh lwjgl-2.9.1/native 2.9.1

You'll get `lwjgl-platform-natives-2.9.1.jar` and `pom.xml` which you can
upload to [clojars.org](http://clojars.org/).

To upload the artifacts you first need to register at [clojars.org](http://clojars.org/). Then create a `~/.m2/settings.xml` file with the following content:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<settings xmlns="http://maven.apache.org/SETTINGS/1.0.0" 
          xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
          xsi:schemaLocation="http://maven.apache.org/SETTINGS/1.0.0 http://maven.apache.org/xsd/settings-1.0.0.xsd">
  <servers>
	<server>
      <id>clojars</id>
      <username>your clojars username</username>
      <password>your clojars password</password>
    </server>
  </servers>
</settings>
```

After that, load the file with Maven:

    mvn deploy:deploy-file -Dfile=lwjgl-platform-natives-2.9.1.jar -Durl=https://clojars.org/repo -DrepositoryId=clojars -DpomFile=pom.xml
