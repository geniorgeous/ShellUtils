#!/bin/bash

usage () {
	echo "USAGE :
`basename $0` <fileList.txt> <relative_path_1> <relative_path_2>

# This script is a loop of diff command on each file in the 2 different folders targetted by relative paths.
# Each line of fileList.txt is a filename. It can contain spaces.
# So it runs on each filename: \"diff \$2/\$filename \$3/\$filename\""
}

# If the last command failed, it desplays error and it exits
error () {
	if [ $? != 0 ]
        	then usage
        	echo $message
        	exit
	fi
}

# INIT: arguments number checking
if [ $# != 3  ]
	then usage
	exit
fi

# check of arguments
message=`ls $1`
error

message=`ls $2`
error

message=`ls $3`
error


num_lines=`cat $1 | wc -l`

i=0
while [ $i -lt $num_lines ]
do

	i=`expr $i + 1`
	# get the line number i
	filename=`head -$i $1 | tail -1`
	# test if the line of fileList.txt is not exmpty
	if [ "$filename" ]
		then
        	echo "diff $2/$filename $3/$filename"
	        diff "$2/$filename" "$3/$filename"
	fi
done
