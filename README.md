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

## Purging Disk Cache

Run `/usr/lib/cache-purge.sh` in the container. It will make Polipo flush memory cache to disk,
trim the files, and reload.

## Environment Variables

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

## See Also

[Polipo Manual](https://www.irif.fr/~jch/software/polipo/manual/index.html)

## Copyright

Copyright 2018, Development Gateway

See COPYING for details.
