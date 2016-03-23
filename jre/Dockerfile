FROM frolvlad/alpine-glibc:alpine-3.3

MAINTAINER josh@grahamis.com

ENV JAVA_HOME /usr/local/java
ENV JRE ${JAVA_HOME}/jre
ENV JAVA_OPTS=-Djava.awt.headless=true PATH=${PATH}:${JRE}/bin:${JAVA_HOME}/bin
ENV ENV=/etc/shinit.sh

COPY shinit.sh /etc/

WORKDIR /tmp

RUN \
  echo ipv6 >> /etc/modules && \
  echo 'http://dl-2.alpinelinux.org/alpine/v3.3/main/' > /etc/apk/repositories && \
  apk add --no-cache --virtual=build-dependencies ca-certificates wget && \
  sed -i -e 's#:/bin/[^:].*$#:/sbin/nologin#' /etc/passwd && \
  chmod a=rx /etc/shinit.sh && \
  wget https://github.com/delitescere/docker-zulu/raw/master/zre8.13.0.5-cp3-jre8.0.72-linux_x64.tar.gz && \
  tar -xzf *.tar.gz && \
  rm *.tar.gz && \
  mkdir -p $(dirname ${JRE}) && \
  mv * ${JRE} && \
  cd / && \
  apk del ca-certificates openssl wget && \
  rm -rf /tmp/* /var/cache/apk/* && \
  java -version

ENV JAVA_HOME ${JRE}
WORKDIR /root
