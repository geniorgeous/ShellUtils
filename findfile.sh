#!/bin/bash


# INIT: arguments number checking
if [ $# != 1	]
then
	echo "USAGE : `basename $0` \"<filename_pattern>\"
DESCRIPTION: find all the file with name containing filename_pattern (case unsensitive), in current directory
DEPENDANCIES: none
"
	exit
fi

filename_pattern="$1"
find . -iname "*$filename_pattern*" | grep -v "\.hg" | cut -c3-

