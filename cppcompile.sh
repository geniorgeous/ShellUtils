#!/bin/bash


# INIT: arguments number checking
if [ $# != 1  ]
    then
    echo "Usage : `basename $0` <filename.cpp>"
		echo '# generate an executable file named "filename" 
'
    exit
fi

# INIT: check $1 exists
if [ ! -e "$1" ]
                then
                echo "file \"$1\" does not exist"
                exit
fi

# INIT: check $1 extension
if [ `getextension "$1"` != "cpp" ]
                then
                echo "file \"$1\" is not a .cpp file"
                exit
fi


basicFileName=`getunextendedname "$1"`

g++ -g -o "$basicFileName" "$1"	-I$dev/C_CPP/utils
