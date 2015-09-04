FROM delitescere/jvm-prep

MAINTAINER josh@grahamis.com

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
    mkdir -p $(dirname ${JAVA_HOME}) && \
    mv * ${JAVA_HOME} && \
    cd .. && \
    rmdir ${OLDPWD} && \
    cd ${JAVA_HOME} && \
    for ff in bin/*; do f=$(basename $ff); if [ -e ${JRE}/bin/$f ]; then ln -snf ${JRE}/bin/$f $ff; fi; done
# replace files in JAVA_HOME/bin that also exist in JRE/bin with a symlink

RUN \
  rm -rf /var/cache/apk/*

WORKDIR /root
