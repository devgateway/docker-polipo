#!/bin/sh -e
kill -USR1 1
sync
polipo -x
kill -USR2 1
