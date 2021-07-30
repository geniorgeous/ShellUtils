#!/bin/bash

usage () {
	echo "USAGE :
`basename $0` <file.svg> <target_png_width>

# DESCRIPTION: converts a SVG file into a PNG file with same basename, plus the desired width
# DEPENDENCY: getunextendedname"
}

# INIT: arguments number checking
if [ $# != 2  ]
	then usage
	exit
fi

svg=$1
width=$2
png=`getunextendedname $svg`".png"

inkscape -w "$width" "$svg" -o "$png"
