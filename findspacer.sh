#!/bin/bash

# Parameters number checking
if [ $# != 1  ]
    then
    echo "Usage : `basename $0` <directory_name>
# for directory \$1, finds recursively files and subdirectories names with space
# N.B: \$1 can have spaces but in this case, use `basename $0` \"directory name\"
"
    exit
fi

# important to use "$1" in the case of $1 with spaces
if [ ! -e "$1" ]
    then
    echo "error: the directory $1 does not exist"
    exit
fi
directory_name="$1"

. ifsnospace
for i in `ls "$1"`; 
	do 
	{ 
			grepspace=`echo "$directory_name/$i" | grep " "` 
			if [ -n "$grepspace" ]
					then
					echo "$directory_name/$i contains spaces"
			fi
			if [ -d "$directory_name/$i" ]
					then
					findspacer "$directory_name/$i"
			fi
} 
done

