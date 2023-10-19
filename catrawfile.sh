#!/bin/bash

# INIT: arguments number checking
if [ $# != 1	]
then
	echo "USAGE : `basename $0` <filename>     (filename may contain spaces)
DESCRIPTION: prints file chars in alternance with associated binary codes: displays the code of non-printable characters
DEPENDENCIES: none
EXAMPLE: `basename $0` Unsupported.log"
	echo 'RESULT:
0000000   #   i   n   c   l   u   d   e       <   s   t   d   i   o   .   h   >  \n   #   i   n   c   l   u   d   e       <   s   t   d
         35 105 110  99 108 117 100 101  32  60 115 116 100 105 111  46 104  62  10  35 105 110  99 108 117 100 101  32  60 115 116 100
0000040   l   i   b   .   h   >  \n   #   i   n   c   l   u   d   e       <   i   o   s   t   r   e   a   m   >  \n   #   i   n   c   l
        108 105  98  46 104  62  10  35 105 110  99 108 117 100 101  32  60 105 111 115 116 114 101  97 109  62  10  35 105 110  99 108
N.B: non ASCII caracters are encoded on several bytes (UTF8), so this program prints the decimal decomposition
'
	exit
fi


# INIT: check $1 exists
if [ ! -e "$1" ]
                then
                echo "file \"$1\" does not exist"
                exit
fi


# use of 'od'
# options:
# -w32: prints 32 chars ASCII by lines
# -c: prints the letters
# -t d1: print the decimal encoding for each ASCII char

# 2 pipes to align binary codes with letters
od -c -t d1  "$1" |  sed 's/ \([^ ]\)/\1/g' | sed '/^0/s/     /    /g'
