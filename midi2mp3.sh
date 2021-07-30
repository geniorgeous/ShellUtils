#!/bin/bash

# INIT: arguments number checking
if [ $# != 1  ]
    then
    echo "Usage : `basename $0` <file.wav>
Description: convert a .midi file into .mp3 file (same basename). rate = 192k: output size is 500 KB/min
Dependencies: timidity, ffmpeg
"
    exit
fi

# INIT: check $1  file
if [ ! -e "$1" ]
		then
		echo "file \"$1\" does not exist"
		exit
fi

base=`getunextendedname "$1"`
if [ -e "$base".mp3 ]
		then
		rm -v "$base".mp3
fi

timidity "$base".midi -Ow -o - | ffmpeg -i - -acodec libmp3lame -ab 192k "$base".mp3
