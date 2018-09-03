
ARG GFORTHVERSION=0.7.9_20180830
ARG NET2OVERSION=0.7.5-20180830

FROM mtrute/gforth-container:${GFORTHVERSION}

LABEL maintainer="Matthias Trute <mtrute@web.de>"

# change to trunk 
ENV VERSION ${NET2OVERSION}

VOLUME /net2o
WORKDIR /net2o
USER root
ENV USER root
ENV LANG C.UTF-8
ENV NET2O_CONF /net2o/config

RUN \
    apk add --no-cache --virtual .build-deps \ 
      fossil git build-base m4 file libtool libffi-dev libltdl g++ mesa-dev libx11-dev \
      autoconf automake pcre-dev bison boost zlib-dev coreutils mesa-gles \
    && mkdir /tmp/net2o-src \
    && cd /tmp/net2o-src \
    && fossil clone https://fossil.net2o.de/net2o net2o.fossil \
    && fossil open net2o.fossil $VERSION  \
    && git clone https://github.com/forthy42/ed25519-donna.git \
    && ./autogen.sh \
    && make configs && make no-config && make install-libs \
    && make libcc \
    && make install \
    && cd / \
    && n2o version \
    && apk del .build-deps \
    && apk add libtool gcc \
    && rm -rf /tmp/net2o-src

CMD [ "n2o" ]

ENTRYPOINT ["n2o"]
