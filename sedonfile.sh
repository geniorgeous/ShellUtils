#!/bin/bash


# INIT: arguments number checking
if [ $# != 3  ]
    then 
    echo "Usage : `basename $0` <pattern_to_replace> <new_pattern> <filename>
# sedonfile replace \$1 occurences by \$2 in \$3 file, and send it back in file
# use case: to delete ^M at line feed: sedonfile '\\r\$' '' file
# delete tabs starting line: sedonfile '^\t' '' file
"
    exit
fi
file="$3"



# INIT: check $1 directory
if [ ! -e "$file" ]
                then
                echo "file \"$file\" does not exist"
                exit
fi


tempVar=`cat "$file" | sed "s/$1/$2/g"`
echo "$tempVar" > "$file"


