#!/bin/sh -e
# Copyright 2018, Development Gateway, see COPYING
if [ "$1" != "polipo" ]; then
  exec "$@"
fi

crond -L /dev/null

exec polipo -c /etc/polipo/polipo.conf
