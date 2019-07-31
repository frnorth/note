#!/bin/bash

set -e

#while [ 1 ]
#do

  curl -X POST -d "username=wangjie&password=d969eef6ead3c29a3a629280686cf0c3f5da86aff3ca12020c923adc6c92" http://xxxxxxxxx.c -D ./tmp_cookie &> /dev/null

  sed -i 's/;//g' ./tmp_cookie

  cookie=`grep Cookie ./tmp_cookie | awk '{print $2}'`

  #echo $cookie

  curl -X GET -b "$cookie" "http://xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx" -H "accept: */*" > ./reportUrlTree.lua

  echo -e "\nreturn reportUrlTree" >> ./reportUrlTree.lua

  #sleep 60

#done

