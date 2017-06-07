Project information on the [project site](http://grahamis.com/tinyjvm).

## Docker images

The [docker-squash](https://github.com/jwilder/docker-squash) tool can be used to squash images after being built, eliminating intermediate layers. I leave the squashing to you if you want to do it.

## Build

Note: The Zulu Embedded JRE compact3 profile build supplied to me by Azul Systems is managed in this repository to improve the image size (`wget && tar && rm` is generally smaller than `COPY`).

```sh
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
