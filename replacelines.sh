#!/bin/bash

# INIT: arguments number checking
if [ $# != 2  ]
    then
    echo "Usage : `basename $0` <file_name> <file_of_new_lines>"
	echo 'Description:
# for the file $1, replace the lines listed in file $2
# file $2 is a file with line as following (output of nl command):
#       TAB <line_index> TAB line
# pre-requisite: the lines to replace do not contain TAB
# Use Case: to do as a sedonfile only for some lines 
# file $2: example: replies.txt: I know that the lines of file $1 containing "<message" on odd lines are replies. So I build this file:
# nl dictionary.xml | grep "<message" |sed "1~2d" |sed "s/message/reply/g" > replies.txt
# now I have just do run this program on dictionary.xml and replies.txt. The resulted dictionary.xml is that lines started by "<message" on odd lines are now  started by "<reply"
'
    exit
fi

# INIT: check $1 file
if [ ! -e "$1" ]
                then
                echo 'file "'$1'" does not exist'
                exit
fi

# INIT: check $1 file
if [ ! -e "$2" ]
                then
                echo 'file "'$2'" does not exist'
                exit
fi


last_line_index=1
result=""
nb=1
nb_max=`cat "$2" | wc -l`
while ( [ "$nb" -le "$nb_max" ] )
do
	# get the line of $2, containing the index, a TAB and the line content, to place in $1, at $index line
	line_index_and_content=`catlines $nb $nb $2`
	# so line index is first field (default separator of cut os TAB)
	line_index=`echo -e "$line_index_and_content" | cut -f1`
	# and line content is second part
	line_content=`echo -e "$line_index_and_content" | cut -f2-`
	line_before=`expr $line_index \- 1`
	# so temporary result is previous result + $1 file content between last line index and current line index + line content of $2 file
	result=$result`catlines $last_line_index $line_before $1`"\n$line_content\n"

	# continue the loop
	last_line_index=`expr $line_index + 1`
	nb=`expr $nb + 1`
done

# at the end, the part between line index and the end of $1 file is appended to $result
max_index=`cat "$1" | wc -l`
result="$result"`catlines $last_line_index $max_index "$1"`

# $result replaces $1 file, so lines replacement is done
echo -e "$result" > "$1"