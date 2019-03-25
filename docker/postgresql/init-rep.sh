#/bin/sh

set -e

su - postgres

pg_basebackup -h 172.17.0.7 -U postgres -F p -x -P -R -D /var/lib/postgresql/data/ -l replbackup
