#!/bin/bash

# INIT: arguments number checking
if [ $# != 1  ]
		then echo "USAGE : `basename $0` <directory name>
DESCRIPTION: remove (after user confirmation) the files like *~ (vi buffered file) or #* or *# (emacs buffered files) 
DEPENDENCIES: none
EXAMPLE: `basename $0` .
"
		exit
fi

. ifsnospace

# INIT: check $1 exists
if [ ! -e $1 ]
    then
    echo "error: the directory $1 does not exist"
    exit
fi


for FILE in `find $1 -name "*~"`; do { ls -l "$FILE"; rm -iv "$FILE"  ; } done

for FILE in `find $1 -name "*#"`; do { ls -l "$FILE"; rm -iv "$FILE"  ; } done

for FILE in `find $1 -name "#*"`; do { ls -l "$FILE"; rm -iv "$FILE"  ; } done

. ifsspace
