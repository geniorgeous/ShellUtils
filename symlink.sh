#!/bin/bash


# INIT: arguments number checking
if [ $# != 2  ]
    then 
    echo "Usage : 
# f mode: `basename $0` -f <relative_path or absolute_path/filename.extension>
#     -> it creates a symbolic link of the file in the current folder
# d mode: `basename $0` -d '<relative_path to folder>' 
#     -> it creates a symbolic link in current folder for all the files in the folder
# p mode: `basename $0` -p '<relative_path or absolute_path/pattern>' 
#     -> it creates a symbolic link in current folder for all the files matching the pattern
#     -> example: symlink -p \"../devArchive/dev_perso/test/*.rr\"
"
    exit
fi
file="$2"
mode=$1


if [ "$mode" = "-f" ]
then


	# INIT: check $1 directory or file
	if [ ! -e "$file" ]
        then
            echo "file \"$file\" does not exist"
            exit
	fi



	filename=`basename $file`
	unextendedFilename=`getunextendedname $filename`
	if [ ! -e "$unextendedFilename" ]
        then
			echo "ln -s $file $unextendedFilename"
			ln -s $file $unextendedFilename
	else
		echo "Cannot create symbolic link $unextendedFilename: File exists"
	fi	
	exit
	
	
elif [ "$mode" = "-d" ]
then
	for i in `ls $file`
	do
		`basename $0` -f "$file/$i"
		
	done
	exit

elif [ "$mode" = "-p" ]
then
	for i in `ls $file`
	do
		`basename $0` -f "$i"
		
	done
	exit
fi




