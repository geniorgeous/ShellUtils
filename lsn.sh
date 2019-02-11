#!/bin/bash
# list the last 10 modified files/directories in directory $*

. ifsnospace

for i in `ls $*`
do
	echo "$i"
done

. ifsspace