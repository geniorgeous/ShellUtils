#!/bin/bash

usage () {
	echo "USAGE :
`basename $0` <folder or file or regex>

# Removes quietly 1 file or 1 folder or anything matching the regex"
}




# INIT: arguments number checking
if [ ! -e "$1" ]
then
	echo "file \"$1\" does not exist or the regex does not match any file nor directory"
	usage
	exit
fi



for i in "$@"; do
    echo "removing $i"
    rm -rf "$i" > /dev/null
done

