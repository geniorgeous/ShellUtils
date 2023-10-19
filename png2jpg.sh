#!/bin/bash

usage () {
	echo "USAGE :
`basename $0` <file.png>

# DESCRIPTION: converts a PNG file into a JPG file with transparent background transformed to white
# DEPENDENCY: getunextendedname"
}

# INIT: arguments number checking
if [ $# != 2  ]
	then usage
	exit
fi

png=$1
jpg=`getunextendedname $png`".jpg"

convert "$png" -background white -flatten -alpha off "$jpg"
