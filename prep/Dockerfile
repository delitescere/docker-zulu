FROM frolvlad/alpine-glibc

MAINTAINER josh@grahamis.com

USER root

# Secure the container so that no base users (e.g. root, operator) have a login.
# Provide a script that runs every container invocation (specifically to update Java net.properties).
# Get ready to accept a JVM installation.

ENV JAVA_HOME /usr/local/java
ENV JRE ${JAVA_HOME}/jre
ENV JAVA_OPTS=-Djava.awt.headless=true PATH=${PATH}:${JRE}/bin:${JAVA_HOME}/bin
ENV ENV=/etc/shinit.sh

COPY shinit.sh /etc/

RUN \
  echo ipv6 >> /etc/modules && \
  sed -i -e 's#:/bin/[^:].*$#:/sbin/nologin#' /etc/passwd && \
  chmod a=rx /etc/shinit.sh && \
  mkdir java

WORKDIR /tmp/java
