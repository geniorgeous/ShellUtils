#!/bin/bash

#INIT: arguments number checking
if [ $# != 1  ]
    then 
    echo "# Usage : `basename $0` <filename>"
    echo "# Encodes an ISO file into an UTF8 file"
    exit
fi

filename="$1"
utforiso $filename > /dev/null
if [ $? == 1 ]
then 
	filecontent=`iconv -f iso-8859-15 -t utf8 $1`
	echo "$filecontent" > "$filename"
	echo "$filename: conversion done"
	# Remark: to do the conversion into ISO, command would be: iconv -f utf8 -t iso-8859-15 $1
else
	echo "$filename is already UTF8"
fi



