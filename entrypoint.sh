#!/bin/sh -e
# Copyright 2018, Development Gateway, see COPYING
if [ "$1" != "polipo" ]; then
  exec "$@"
fi

CONFIG_FILE=/etc/polipo/config

# add optional Polipo configuration
DIRECTIVES='
  maxDiskCacheEntrySize
  diskCacheTruncateTime
  diskCacheTruncateSize
  diskCacheUnlinkTime
'
for DIRECTIVE in $DIRECTIVES; do
  eval VALUE="\$$(echo $DIRECTIVE | sed 's/[[:upper:]]/_&/g' | tr '[[:lower:]]' '[[:upper:]]')"
  if [ -n "$VALUE" ]; then
    echo "$DIRECTIVE = $VALUE" >>"$CONFIG_FILE"
  fi
done

exec polipo -c "$CONFIG_FILE"
