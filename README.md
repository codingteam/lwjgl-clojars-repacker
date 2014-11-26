# LWJGL repacker script for clojars

[![lwjgl on Clojars](http://clojars.org/ru.org.codingteam/lwjgl-platform-natives/latest-version.svg)](http://clojars.org/ru.org.codingteam/lwjgl-platform-natives)
[![jinput on Clojars](http://clojars.org/ru.org.codingteam/jinput-platform-natives/latest-version.svg)](http://clojars.org/ru.org.codingteam/jinput-platform-natives)

Quick usage example:

    $ ./repack.sh lwjgl.ticket
    $ ./repack.sh jinput.ticket

You'll get two folders `lwjgl-platform-natives` and
`jinput-platform-natives` with jars and poms that you can upload to
[clojars.org](http://clojars.org/).

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
