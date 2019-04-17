#!/bin/bash

set -e

DATE=`date "+%y-%m-%d"`

export PGPASSWORD="xxxxxx"

BACKDIR=/data/database/backup

pg_basebackup -D $BACKDIR/bak-$DATE -h xxx.xxx.xxx.xxx -p xxxx -c fast -X stream -U replica

find $BACKDIR/ -maxdepth 1 -type d -mtime +3 | grep -v "$BACKDIR/$" | xargs -i rm {} -rf

# crontab:  00 01 * * * /data/database/backup/backup.sh

