#!/bin/bash

STATE_OK=0
STATE_CRITICAL=2

HOST=127.0.0.1
PORT=5432
USER="postgres"
PASSWORD="123456"

while [ $# -gt 0 ]; do
  case "$1" in
    -h)
      shift
      HOST=$1
      ;;
    -p)
      shift
      PORT=$1
      ;;
    -U)
      shift
      USER=$1
      ;;
    -W)
      shift
      PASSWORD=$1
      ;;
  esac
shift
done

export PGPASSWORD=$PASSWORD

STATE=`psql -h $HOST -p $PORT -U $USER -c '\x' -c 'select * from pg_stat_replication;' | grep '^state' | awk '{print $3}'`
#STATE=`psql -h $HOST -p $PORT -U $USER -c 'select state from pg_stat_replication;' | grep 'streaming';`
#echo $STATE

if [ $STATE = "streaming" ]
then
  echo "Ok, replication is: $STATE"
  exit $STATE_OK
fi

echo "Error occurs in replication, which is now: $STATE"
exit $STATE_CRITICAL
