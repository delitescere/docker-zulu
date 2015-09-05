FROM delitescere/jvm-prep

MAINTAINER josh@grahamis.com

# If release changes, the file name needs to be changed (and included in git LFS)
WORKDIR /tmp/java
COPY zre1.8.0_60-8.9.0.4-compact3-x86lx64.txz /tmp/java/
RUN \
  tar -xJf *.txz && \
  rm *.txz && \
  mkdir -p $(dirname ${JRE}) && \
  mv * ${JRE} && \
  cd / && \
  rm -rf /tmp/* && \
  rm -rf /var/cache/apk/* && \
  java -version

WORKDIR /root
