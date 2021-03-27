#!/bin/bash

strinput=$1

#strgrep="\""
strgrep=""

let length=${#strinput}-1

i=0

while [ $i -le $length ]
do
	if [ "${strinput:$i:${i+1}}" == " "  ];then
		strgrep=$strgrep$"[[:space:]]"
	else
		strgrep=$strgrep${strinput:$i:${i+1}}
	fi
	let i++
done
#strgrep=$strgrep"\""
echo $strgrep

for i in `find ./ -type f`
do
  CONTEXT=`cat $i | grep $strgrep`
  if [ -n "$CONTEXT" ] ; then
    echo "-----------------------------------------"
    echo -n "+++ ";
    echo -e "\033[36m$i\033[0m";
    cat $i | grep $strgrep --color=auto
  fi
done
echo "-----------------------------------------"


