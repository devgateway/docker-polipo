#!/bin/sh -e
# Copyright 2018, Development Gateway, see COPYING
if [ "$1" != "polipo" ]; then
  exec "$@"
fi

CONFIG_FILE=/etc/polipo/config
CRONTAB=/var/spool/cron/crontabs/nobody

# install a crontab to purge the cache
: ${CACHE_PURGE_SCHEDULE:=0 2 * * *}
echo "$CACHE_PURGE_SCHEDULE kill -USR1 1; sleep 1; polipo -x; kill -USR2 1" >"$CRONTAB"

# spawn a cron daemon
crond -L /dev/null

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
