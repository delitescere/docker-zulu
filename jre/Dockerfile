FROM delitescere/jvm-prep

MAINTAINER josh@grahamis.com

# If release changes, the file name needs to be changed
RUN \
  wget https://github.com/delitescere/docker-zulu/raw/master/jre/zre8.13.0.5-cp3-jre8.0.72-linux_x64.tar.gz && \
  tar -xzf *.tar.gz && \
  rm *.tar.gz && \
  mkdir -p $(dirname ${JRE}) && \
  mv * ${JRE} && \
  cd / && \
  apk del ca-certificates wget && \
  rm -rf /tmp/* /var/cache/apk/* && \
  java -version

ENV JAVA_HOME ${JRE}
WORKDIR /root
