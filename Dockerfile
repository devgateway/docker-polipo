# Copyright 2018, Development Gateway, see COPYING
FROM alpine:3.8

ARG VERSION=1.1.2

RUN set -x; \
  apk add --no-cache --virtual .build-deps gcc make libc-dev \
  && wget --proxy on -O polipo-$VERSION.tar.gz \
    https://github.com/devgateway/polipo/archive/v$VERSION.tar.gz \
  && tar -xf polipo-$VERSION.tar.gz \
  && cd polipo-$VERSION \
  && export CFLAGS='-O2 -fPIE -s' \
  && export PLATFORM_DEFINES='-DNO_SOCKS -DNO_FORBIDDEN -DNO_SYSLOG -DNO_REDIRECTOR' \
  && make polipo \
  && install -m 0755 -s polipo /usr/bin/ \
  && cd .. \
  && rm -rf polipo-$VERSION.tar.gz polipo-$VERSION \
  && apk del .build-deps \
  && mkdir -p /var/cache/polipo \
  && chown nobody:nobody /var/cache/polipo \
  && crontab -r \
  && echo '0 2 * * * run-parts /etc/periodic/daily' >/var/spool/cron/crontabs/nobody \
  && chown nobody:nobody /var/spool/cron/crontabs/nobody

COPY polipo.conf /etc/polipo/config
COPY polipo.sh /etc/periodic/daily/polipo
COPY entrypoint.sh /

WORKDIR /var/cache/polipo

USER nobody

ENTRYPOINT ["/entrypoint.sh"]
CMD ["polipo"]

VOLUME /var/cache/polipo

EXPOSE 3128
