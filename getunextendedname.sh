#!/bin/bash

# INIT: arguments number checking
if [ $# != 1  ]
    then
    echo "USAGE : `basename $0` <file name.extension>     (space capable)
DESCRIPTION: display the filename without extension: display report for report.pdf
REMARK: This is complementary to the result of getextension
"
    exit
fi


# find the numbers of occurences of "." in filename: the extension is the part after the last "."
numberOfPoints=`echo "$1" | sed "s/[^.]//g" | wc -c`
numberOfPoints=`expr $numberOfPoints \- 1`
echo "$1" | cut -d "." -f-$numberOfPoints

