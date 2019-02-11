#!/bin/bash

# INIT: arguments number checking
if [ $# != 1	]
then echo "USAGE : `basename $0` <filename.c>     (filename may contain spaces)
DESCRIPTION: compile a basic .c program source file (gcc -g -o) with includes in utils folder
DEPENDENCIES: gcc
EXAMPLE: `basename $0` main.c"
	exit
fi

# INIT: check $1 exists
if [ ! -e "$1" ]
                then
                echo "file \"$1\" does not exist"
                exit
fi

# INIT: check $1 extension
if [ `getextension "$1"` != "c" ]
                then
                echo "file \"$1\" is not a .c file"
                exit
fi


basicFileName=`getunextendedname "$1"`

gcc -g -o "$basicFileName" "$1"	-I$bin/utils




