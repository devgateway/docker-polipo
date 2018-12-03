# Polipo Image for Docker

This image is built on Alpine Linux with IPv6 support (using Musl libc). Polipo has been abandoned
after release 1.1.1, but it's still great software. This unofficial release 1.1.2 includes patches
from upstream and DG's tweaks to support build on newer systems.

## Ports

Polipo is configured to listen on port 3128.

## User

Polipo runs as user `nobody`, uid 65534.

## Volume

### `/var/cache/polipo`

Path to the disk cache directory. Polipo will store files up to a certain size in its disk cache.
The cron job spawned by the init script will trim or remove files that are unused for certain time
spands. See environment variables below and
[Purging the on-disk cache](https://www.irif.fr/~jch/software/polipo/manual/Purging.html).

## Environment Variables

### `CACHE_PURGE_SCHEDULE`

The time interval in `crontab(5)` format for running cache purge job. Default is nightly at 02:00.

Default: `0 2 * * *`

### `DISK_CACHE_TRUNCATE_SIZE`

Size in bytes to which on-disk objects are truncated.

Default: `1048576`

### `DISK_CACHE_TRUNCATE_TIME`

Time after which on-disk objects are truncated.

Default: `4d12h`

### `DISK_CACHE_UNLINK_TIME`

Time after which on-disk objects are removed.

Default: `32d`

### `MAX_DISK_CACHE_ENTRY_SIZE`

Maximum size of objects cached on disk.

Default: `-1` (unlimited)

## Copyright

Copyright 2018, Development Gateway

See COPYING for details.
