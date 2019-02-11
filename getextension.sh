#!/bin/bash

# INIT: arguments number checking
if [ $# != 1  ]
    then
    echo "Usage : `basename $0` <file name.extension>     (space capable)"
		echo '# print the extension
# Use Case: basicname=`getunextension "my movie.avi"`
# In this use case, the variable basicname contains "avi"
# This is complementary to the result of getunextendedname
'
    exit
fi


# find the numbers of occurences of "." in filename: the extension is the part after the last "."
numberOfPointsPlus1=`echo "$1" | sed "s/[^.]//g" | wc -c`
echo "$1" | cut -d "." -f$numberOfPointsPlus1

