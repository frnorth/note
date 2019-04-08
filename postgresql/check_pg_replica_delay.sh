#!/bin/bash

STATE_OK=0
STATE_WARNING=1
STATE_CRITICAL=2


HOST=127.0.0.1
PORT=5432
USER="postgres"
PASSWORD="123456"
WARING_THRESHOLD=1
CRITICAL_THRESHOLD=2

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
    -w)
      shift
      WARING_THRESHOLD=$1
      ;;
    -c)
      shift
      CRITICAL_THRESHOLD=$1
      ;;
  esac
shift
done

export PGPASSWORD=$PASSWORD

DELAY=`psql -h $HOST -p $PORT -U $USER -c '\x' -c 'select pg_xlog_location_diff(pg_current_xlog_location(),replay_location)/1024/1024 as MB from pg_stat_replication;' | grep mb | awk '{print $3}'`
#DELAY=`psql -h $HOST -p $PORT -U $USER -c 'select pg_xlog_location_diff(pg_current_xlog_location(),replay_location)/1024/1024 as MB from pg_stat_replication;' | head -3 | tail -1`
#echo $DELAY

if [ `echo "$DELAY < $WARING_THRESHOLD" | bc` -eq 1 ]
then
  echo "Ok, delay is small: $DELAY"
  exit $STATE_OK
fi

if [ `echo "$DELAY < $CRITICAL_THRESHOLD" | bc` -eq 1 ]
then
  echo "Warning, delay is a little much: $DELAY"
  exit $STATE_WARNING
fi

echo "Critical, delay is to much: $DELAY"
exit $STATE_CRITICAL
