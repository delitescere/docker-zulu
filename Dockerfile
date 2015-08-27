FROM gliderlabs/alpine:3.2

MAINTAINER josh@grahamis.com

USER root

# Install packages
RUN \
  echo ipv6 >> /etc/modules && \
  apk update && \
  apk upgrade && \
  apk add --update ca-certificates curl

# Install glibc (should be temporary once it's in the base image). https://github.com/gliderlabs/docker-alpine/issues/11#issuecomment-91329401
WORKDIR /tmp
RUN \
  wget "https://circle-artifacts.com/gh/andyshinn/alpine-pkg-glibc/6/artifacts/0/home/ubuntu/alpine-pkg-glibc/packages/x86_64/glibc-2.21-r2.apk" && \
  apk add --allow-untrusted glibc-2.21-r2.apk && \
  wget "https://circle-artifacts.com/gh/andyshinn/alpine-pkg-glibc/6/artifacts/0/home/ubuntu/alpine-pkg-glibc/packages/x86_64/glibc-bin-2.21-r2.apk" && \
  apk add --allow-untrusted glibc-bin-2.21-r2.apk && \
  /usr/glibc/usr/bin/ldconfig /lib /usr/glibc/usr/lib
  
ENV JAVA_HOME /usr/local/java

WORKDIR /tmp/jre

# If release changes, the checksum and URL need to be updated
# See http://www.azulsystems.com/products/zulu/downloads#Linux
RUN \
  checksum="a63294b466f1df1886c4f4832b696ec6" && \
  url="http://cdn.azulsystems.com/zulu/2015-07-8.8-bin/zulu1.8.0_51-8.8.0.3-x86lx64.zip" && \
  referer="http://www.azulsystems.com/zuludoc" && \
  etag=$(curl -sI --referer "${referer}" "${url}" | awk -F"\"|:" '/^ETag: / {print $3}') && \
  if [ "X${checksum}" == "X${etag}" ]; then \
    curl -O -sL --referer "${referer}" "${url}"; \
  else \
    echo "[FATAL] Java ZIP ETag ${etag} doesn't match checksum ${checksum}. Exiting." >&2 && \
    exit 1; \
  fi

RUN \
    unzip -q *.zip && \
    rm *.zip && \
    rm -rf */demo */man */sample && \
    rm */*.zip && \
    mv * ${JAVA_HOME} && \
    cd .. && \
    rmdir ${OLDPWD} && \
    cd ${JAVA_HOME} && \
    for rf in jre/bin/*; do f=$(basename $rf); if [ -e bin/$f ]; then rm -f $rf; ln $PWD/bin/$f $rf; fi; done

ENV JAVA_OPTS=-Djava.awt.headless=true PATH=${PATH}:${JAVA_HOME}/bin

RUN \
  rm -rf /var/cache/apk/*

WORKDIR /root
