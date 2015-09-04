# docker-zulu

## Introduction
This uses the excellent [gliberlabs/alpine](https://github.com/gliderlabs/docker-alpine) base Docker image to build a minimal container for Java tasks and applications, running the best OpenJDK: [Azul's Zulu](http://www.azulsystems.com/products/zulu).

In order to run Java, `glibc` is required. As Alpine Linux does not include `glibc`, it is installed as an additional package.

## JDK and JRE

Two variants are supplied. One is the full Zulu OpenJDK and the other is Zulu JRE [compact3 profile](https://docs.oracle.com/javase/8/docs/technotes/guides/compactprofiles/compactprofiles.html). The compact3 profile is the heaviest of the three Oracle profiles for subsetted JRE and provides everything that most JVM components need. In future, the smaller profiles may also be provided, but the intention is to use Jigsaw from Java 9 to elimate anything that isn't required by each specific component.

If you have a reasonable JVM component that only needs the Java runtime provided by compact3, use the "jre" Dockerfile. If you need more than that, use the "jdk" Dockerfile which comes with everything. You can use `jdeps` to determine if you only need more than the compact3 profile, or add the `-profile compact3` option to your `javac` command.
 
A huge thanks to the Zulu team at Azul Systems who have supplied the Zulu Embedded JRE compact3 profile build for Alpine Linux so everyone can benefit. If you use these images for production, I strongly encourage you to get a world-class support [subscription](http://www.azulsystems.com/products/zulu/support-packages).

## Docker images
The [docker-squash](https://github.com/jwilder/docker-squash) tool is used to squash the images after being built, eliminating intermediate layers.

The [delitescere/jdk](https://hub.docker.com/r/delitescere/jdk/) image pre-squashed size is 245.8 MB, and after squashing it is just 165.1 MB.
The [delitescere/java](https://hub.docker.com/r/delitescere/java/) image pre-squashed size is 90.43 MB, and after squashing it is just 73.27 MB.

## Build

Note: The Zulu Embedded JRE compact3 profile build supplied to me by Azul Systems is managed in this repository using [Git LFS](https://git-lfs.github.com/).

```sh
docker build -t delitescere/jvm-prep prep
docker build -t jdk-unsquashed jdk
docker save jdk-unsquashed | sudo docker-squash -t delitescere/jdk | docker load
docker build -t jre-unsquashed jre
docker save jre-unsquashed | sudo docker-squash -t delitescere/java | docker load
```

## Example usage

```sh
docker run --rm -ti delitescere/java:8 sh -c 'java $JAVA_OPTS -XshowSettings'
```

## Legal

See the LICENSE file. Use of Zulu is governed by the terms of use at [http://www.azulsystems.com/products/zulu/terms-of-use](http://www.azulsystems.com/products/zulu/terms-of-use).

Enjoy smaller containers!
