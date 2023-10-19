#!/bin/bash

# INIT: arguments number checking
if [ $# != 1 ]
then echo "USAGE : `basename $0` \"filename\"		(filename may contain spaces)
DESCRIPTION: checks if the file is iso-8859-15 or utf8
DEPENDENCIES: ./isutf8, iconv
EXAMPLE: `basename $0` example.txt"
	exit
fi

filename="$1"
# INIT: check file $1 exists
if [ ! -e "$filename" ]
then
	echo "file \"$filename\" does not exist"
	exit
fi

./isutf8 "$filename" > /dev/null
if [ $? == 0 ]
then
	echo "$filename is an utf8 file"
	exit 0
fi
iconv -f iso-8859-15 -t utf8 "$filename" | ./isutf8 > /dev/null
if [ $? == 0 ]
then
	echo "$filename is an iso-8859-15 file"
	exit 1
fi
echo "$filename is neither an utf8 file nor an iso-8859-15 file"
exit 2
