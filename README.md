# docker-zulu


## Introduction
This uses the excellent [`gliberlabs/alpine`](https://github.com/gliderlabs/docker-alpine) base Docker image to build a minimal container for Java tasks and applications, running the best OpenJDK: [Azul's Zulu](http://www.azulsystems.com/products/zulu).

In order to run Java, `glibc` is required. As the base Alpine Linux does not include `glibc`, it is installed as an additional package.

The pre-squashed size is 245.8 MB and after using [docker-squash](https://github.com/jwilder/docker-squash), it is just 165.1 MB (most of this is the JDK).

## Build

```sh
docker build -t delitescere/java:8 .
```

## Example usage

```sh
docker run --rm -ti delitescere/java:8 sh -c 'java $JAVA_OPTS -XshowSettings'
```

Enjoy smaller containers!
