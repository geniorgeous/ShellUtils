#!/bin/bash

# gets a code number from a string (of file rights) like rw-r--r-x for example = 645
# $1 is 'u' (root) or 'g' (group) or 'o' (other) or 't' (total)
# $2 is the string
GetCodeFromString () {
    if [ $1 = "u" ] || [ $1 = "g" ] || [ $1 = "o" ]
		then
		# case of a call for a specified user
		if [ $1 = "u" ]
		# get the 3-chars string corresponding with "root" user (in ex1: rw-)
			then
			SubString=`echo $2 | cut -c-3`
		fi
		if [ $1 = "g" ]
			then
		# get the 3-chars string corresponding with "group" user (in ex1: r--)
			SubString=`echo $2 | cut -c4- | cut -c-3` 
		fi
		if [ $1 = "o" ]
			then
		# get the 3-chars string corresponding with "other" user (in ex1: r-x)
			SubString=`echo $2 | cut -c7-`
		fi
		# code = conversion from $SubString to a number between 0 and 7: r=4 w=2 x=1
		code=0
		if [ `echo $SubString | cut -c1` = "r" ]
			then
			code=`expr $code + 4`
		fi
		if [ `echo $SubString | cut -c2` = "w" ]
			then
			code=`expr $code + 2`
		fi
		if [ `echo $SubString | cut -c3` = "x" ]
			then
			code=`expr $code + 1`
		fi
	elif [ $1 = "t" ]
		then
		# case of a call for the 3 users categories: root and group and other
		# then result = 100*code(root) + 10*code(group)+code(other) 
		code=`expr \`GetCodeFromString u $2\` \\* 100 +  \`GetCodeFromString g $2\` \\* 10 + \`GetCodeFromString o $2\` `
	fi
	echo $code
}

# INIT: arguments checking
if [ $# != 1 ]
    then echo "# Usage : `basename $0` <filename>"
    echo "# Gives the digits from 000 to 777 for the rights of the file \$1"
    echo "# This string can be used in chmod command like: chmod 645 anyfile.txt"
		exit 1
fi

# INIT: check that $1 exits
if [ ! -e "$1" ]
	then
	echo "file \"$1\" does not exist"
	exit 1
fi

# INIT: check that $1 is a file
if [ ! -f "$1" ]
		then
		echo "file \"$1\" exists but is not a file"
		exit 1
fi



# StringMode contient un truc du style rw-r--r-x
StringMode=`ls -l $1 | cut -d \  -f-1 | cut -c2- | sed "s/\s//g" | cut -c-9`
if  [ `echo "$StringMode" | wc -c` != 10 ] # 9 + ending char(\0) = 10
		then
		echo "the string of file rights is not of 9 chars"
		exit
fi

# calls GetCodeFromString function et gets the integer code equivalent to $StringMode
result=`GetCodeFromString t $StringMode`
echo $result

