#!/bin/bash

# INIT: arguments number checking
if [ $# -lt 1	]
then
	echo "USAGE : `basename $0` <image_name> {<target_longest_side> {<min_kb_size>}}
DESCRIPTION: resize the images by default in 1920 wide or 1920 high if image bigger. If target_longest_side, it does the same processing with target_longest_side instead of 1920. If min_kb_size & target_longest_side, it does the same processing with target_longest_side instead of 1920 only for images bigger than min_kb_size
DEPENDENCIES: image-magick (convert tool), feh, local script cecho
"
	exit
fi

image="$1"
target_longest_side=1920
min_kb_size=0
if [ $# == 2 ]
then
	target_longest_side=`expr "$2"`
elif [ $# == 3 ]
then
	target_longest_side=`expr "$2"`
	min_kb_size=`expr "$3"`
fi
echo "image: $image, target_longest_side: $target_longest_side, min_kb_size: $min_kb_size"

getKbSize () {
		ls -lks "$1"  | sed "s/^[\ ]*//g" | cut -d \  -f 1
}
image_kb_size=`getKbSize $image`

if [ $image_kb_size -gt $min_kb_size ]
then

	image_width=`feh -l $image | cut -f 3 | tail -1`
	image_width=`expr $image_width`

	image_height=`feh -l $image | cut -f 4 | tail -1`
	image_height=`expr $image_height`

	if [ $image_height -le $image_width ]
	then
		echo "image_kb_size: $image_kb_size, image_width: $image_width, image_height: $image_height, horizontal image"
	else
		echo "image_kb_size: $image_kb_size, image_width: $image_width, image_height: $image_height, vertical image"
	fi

	if [ $image_height -gt $target_longest_side ] || [ $image_width -gt $target_longest_side ]
	then
		if [ $image_height -le $image_width ]
		then
			if [ $image_width -gt $target_longest_side ]
			then
				cecho GREEN "convert $image -resize $target_longest_side $image"
				convert "$image" -resize $target_longest_side "$image"
			fi
		else
			if [ $image_height -gt $target_longest_side ]
			then
				cecho GREEN "convert $image -resize x$target_longest_side $image"
				convert "$image" -resize "x"$target_longest_side "$image"
			fi
		fi
	else
		cecho RED "image $image sides are smaller than $target_longest_side pixels"

	fi
else
	cecho RED "image $image is smaller than $min_kb_size KB"
fi
