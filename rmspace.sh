#!/bin/bash

# INIT: Parameters number checking
if [ $# != 2  ]
    then
    echo "USAGE: `basename $0` r/d <directory_name>
DESCRIPTION: if -r: for directory \$1, rename recursively files without space. If -d. renames only level-1 files/folders
TRICK: \$2 can have spaces but in this case, use `basename $0` -r/-d \"directory name\"
"
    exit
fi

# INIT: check directory $1 exists
if [ ! -e "$2" ]
    then
    echo "error: the directory $1 does not exist"
    exit
fi
directory_name="$2"

. ifsnospace
for i in `ls "$directory_name"`; 
	do 
	{ 
      #echo "$directory_name/$i";
			targetName=`echo "$i" | sed "s/ /./g" | sed "s/\.-\./-/g" | sed "s/\._\./_/g" | sed 's/.(/-/g' | sed 's/)./-/g' | sed 's/,./-/g' | sed 's/(//g' | sed 's/)//g' | sed 's/.&./&/g' | sed "s/\.[\.]*/\./g"`
			if [ "$directory_name/$i" != "$directory_name/$targetName" ]
					then
					mv -v "$directory_name/$i" "$directory_name/$targetName"
			fi
			if [ $1 = "r" ] && [ -d "$directory_name/$targetName" ]
					then
					rmspacer r "$directory_name/$targetName"
			fi
} 
done

. ifsspace

