#!/bin/sh -e
# Copyright 2018, Development Gateway, see COPYING
if [ "$1" != "polipo" ]; then
  exec "$@"
fi

CONFIG_FILE=/etc/polipo/config

crond -L /dev/null

for DIRECTIVE in maxDiskCacheEntrySize diskCacheTruncateSize; do
  eval VALUE="\$$(echo $DIRECTIVE | sed 's/[[:upper:]]/_&/g' | tr '[[:lower:]]' '[[:upper:]]')"
  if [ -n "$VALUE" ]; then
    echo "$DIRECTIVE = $VALUE" >>"$CONFIG_FILE"
  fi
done

exec polipo -c "$CONFIG_FILE"
