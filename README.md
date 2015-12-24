# docker-zulu

The "Smallest JVM containers in the world"™

## Introduction
This uses the excellent [gliberlabs/alpine](https://github.com/gliderlabs/docker-alpine) base Docker image to build a minimal container for Java tasks and applications, running the best OpenJDK: [Azul's Zulu](https://zulu.org/).

In order to run Java, `glibc` is required. As Alpine Linux does not include `glibc`, it is installed as an additional package.

## JDK and JRE

Two variants are supplied. One is the full Zulu OpenJDK and the other is Zulu JRE [compact3 profile](https://docs.oracle.com/javase/8/docs/technotes/guides/compactprofiles/compactprofiles.html). The compact3 profile is the heaviest of the three Oracle profiles for subsetted JRE and provides everything that most JVM components need. In future, the smaller profiles may also be provided, but the intention is to use Jigsaw from Java 9 to elimate anything that isn't required by each specific component.

If you have a reasonable JVM component that only needs the Java runtime provided by compact3, use the "jre" Dockerfile. If you need more than that, use the "jdk" Dockerfile which comes with everything. You can use `jdeps` to determine if you only need more than the compact3 profile, or add the `-profile compact3` option to your `javac` command.
 
A huge thanks to the Zulu team at Azul Systems who have supplied the Zulu Embedded JRE compact3 profile build for Alpine Linux so everyone can benefit. If you use these images for production, I strongly encourage you to get a world-class support [subscription](https://www.azul.com/products/zulu/). NB: Even with a support subscrption, Azul Systems does not support this Docker image, just the JVM within it running on Alpine Linux.

## Docker images
Recent pushes may not be reflected in the size. Click the badge to get the latest data.

The [delitescere/jdk](https://hub.docker.com/r/delitescere/jdk/) image is [![](https://badge.imagelayers.io/delitescere/jdk:latest.svg)](https://imagelayers.io/?images=delitescere/jdk:latest 'Get your own badge on imagelayers.io')

The [delitescere/java](https://hub.docker.com/r/delitescere/java/) image is [![](https://badge.imagelayers.io/delitescere/java:latest.svg)](https://imagelayers.io/?images=delitescere/java:latest 'Get your own badge on imagelayers.io') and is just 69MB after squashing.

The [docker-squash](https://github.com/jwilder/docker-squash) tool can be used to squash images after being built, eliminating intermediate layers. I leave the squashing to you if you want to do it.

## Build

Note: The Zulu Embedded JRE compact3 profile build supplied to me by Azul Systems is managed in this repository using [Git LFS](https://git-lfs.github.com/).

```sh
docker build -t delitescere/jvm-prep prep
docker build -t delitescere/jdk jdk
docker build -t delitescere/java jre
```
TODO: Automate tagging with Java versions

## Example usage

```sh
docker run --rm -ti delitescere/java:8 sh -c 'java $JAVA_OPTS -XshowSettings -version'
```

## Legal

See the LICENSE file.

Enjoy smaller containers!
