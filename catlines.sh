#!/bin/bash

# INIT: arguments number checking
if [ $# != 3	]
then echo "USAGE : `basename $0` <start_line> <end_line> \"<filename>\"		(filename may contain spaces)
DESCRIPTION: prints filename from line start_line to line endline
DEPENDENCIES: none
EXAMPLE: catlines 50 100 brainstorming.txt"
	exit
fi

filename="$3"
# INIT: check file $3 exists
if [ ! -e "$filename" ]
then
	echo "file \"$filename\" does not exist"
	exit
fi

start_line="$1"
if [ `expr $start_line` -le 0 ]
then
	echo "\$start_line should be a positive integer"
	exit
fi

end_line="$2"
if [ `expr $end_line` -le 0 ]
then
	echo "\$end_line should be a positive integer"
	exit
fi


width=`expr	$end_line \- $start_line + 1`

if [ `expr $width` -le 0 ]
then
	echo "\$2 should be upper than \$1"
	exit
fi

head -$end_line "$filename" | tail -$width
