#!/bin/bash

for i in `find ./ -type f`
do
  CONTEXT=`cat $i | grep $1`
  if [ -n "$CONTEXT" ] ; then
    echo "-----------------------------------------"
    echo -n "+++ ";
    echo -e "\033[36m$i\033[0m";
	cat $i | grep $1 --color=auto
  fi
done
echo "-----------------------------------------"
