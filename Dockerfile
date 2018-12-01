# Copyright 2018, Development Gateway, see COPYING
FROM alpine:3.8

ARG VERSION 1.1.1

RUN set -x; \
  apk add --no-cache --virtual .build-deps gcc make libc-dev \
  && wget --proxy on https://github.com/jech/polipo/archive/polipo-$VERSION.tar.gz \
  && tar -xf polipo-$VERSION.tar.gz \
  && cd polipo-polipo-$VERSION \
  && patch -p 1 <../make.patch \
  && export CFLAGS='-O2 -fPIE -s' \
  && export PLATFORM_DEFINES='-DNO_SOCKS -DNO_FORBIDDEN -DNO_SYSLOG -DNO_REDIRECTOR' \
  && make install \
  && cd .. \
  && rm -rf polipo-$VERSION.tar.gz polipo-polipo-$VERSION \
  && apk del .build-deps \
  && mkdir -p /var/cache/polipo \
  && chown nobody:nobody /var/cache/polipo
