#!/bin/bash


# INIT: arguments number checking
if [ $# != 1  ]
    then 
    echo "
USAGE: `basename $0` <filename>
DESCRIPTION: cute cat or color cat: nl -ba \$filename | pygmentize -g 
"
    exit
fi

file="$1"

# INIT: check file $1 exists
if [ ! -e "$file" ]
then
	echo "file \"$1\" does not exist"
	exit
fi

pygmentize -f terminal256 -O style=monokai -g $file | nl -ba
