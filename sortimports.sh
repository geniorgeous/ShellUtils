#!/bin/bash

usage () {
	echo "USAGE :
`basename $0` <filename>

# DESCRIPTION: sort typescript import lines
# DEPENDENCY: none"
}

# INIT: arguments number checking
if [ $# != 1 ]
	then usage
	exit
fi

filename=$1

if [ ! -e "$filename" ]
then
	echo "file \"$filename\" does not exist"
	exit
fi

lineNumber=`cat $filename | grep -n "^import" | tail -1 | cut -d : -f 1`
lineNumberPlusOne=`expr $lineNumber + 1`
importLines=`catlines 1 $lineNumber $filename | sed ':a;N;$!ba;s/,\n/,/g' | sed ':a;N;$!ba;s/{\n/{/g' | sed 's/\(.*\)from\(.*\)/\2from\1/g'`


# 4 categories to sort, and to display in this order:
# category 1: 'react'
echo "$importLines" | grep "^ \'[a-z]" | sort | sed 's/\(.*\)from\(.*\)/\2from\1/g'
# category 2: '@mui/material'
echo "$importLines" | grep "^ \'\@" | grep -v "^ \'\@geo" | sort | sed 's/\(.*\)from\(.*\)/\2from\1/g'
# category 3: '@geo/viewer/dist/ItemsPage'
echo "$importLines" | grep "^ \'\@geo" | sort | sed 's/\(.*\)from\(.*\)/\2from\1/g'
# category 4: '../common/AlertSnackbar'
echo "$importLines" | grep "^ \'\." | sort | sed 's/\(.*\)from\(.*\)/\2from\1/g'

catlines $lineNumberPlusOne 9999 $filename
# echo "$importLines" | sort | sed 's/\(.*\)from\(.*\)/\2from\1/g'
