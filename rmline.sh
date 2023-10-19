#!/bin/bash

# INIT: arguments number checking
if [ $# != 3	]
then
	echo "USAGE: `basename $0` <mode: -p/-n> <pattern if -p/line number if -n>  <filename>
DESCRIPTION: removes lines containing a pattern in -p mode, or removes 1 line or a lines range in -n mode
DETAILS: in -n mode, argument is 1 positive integer, or range between 2 positive integers: I1,I2
         in -p mode, okay with special chars: ' \" /
DEPENDENCIES: none
LIMITATION: CYGWIN does not have awk, but gawk
"
	exit
fi

# INIT: check $3 exists
if [ ! -e "$3" ]
then
	echo "file \"$3\" does not exist"
	exit
fi
File="$3"
Mode="$1"
Selector="$2"

if [ "$Mode" == "-p" ]
then
	# to pass shell variable into AWK program (delimited by '), there is option -v:
	tempVar=`awk -v Selector="$Selector"  'match($0,Selector) == 0 {print $0}' $File`
	removed=`cat $File | grep -n "$Selector"`
	echo -e "$tempVar" > "$File"
	echo "$File: lines containing $Selector deleted:"
	echo "$removed"



	# Tips:
	# similar command in Cygwin: gawk 'match($0,"James") == 0 {print $0}' PhoneBook.txt > PhoneBook1.txt
	# tip for Cygwin: to use this progs, either change awk by gawk, or rename the exe file in /Cygwin/bin: gawk.exe into awk.exe
	# we can do it with sed:
	# tempVar=`sed "/$Selector/d" $File`
	# but AWK is better with exotic chars in pattern, as pattern is set in a variable
	# whereas sed is sensitive to ' " / etc
fi


if [ "$Mode" == "-n" ]
then
	# argument is 1 positive integer, or range between 2 positive integers: I1,I2
	InitCheck=`echo $Selector | tr -d ','`
	if [ `expr $InitCheck` -le 0 ]
	then
		echo "Second Argument (after -n) must be a positive integer"
		exit
	else
		if [ $? != 1 ]
			then
			echo "$Selector is not a valid line number or line range"
			# detect here is 'expr' failed: if InitCheck is not an int
			exit
		fi
		tempVar=`sed "$Selector""d" $File`
		echo -e "$tempVar" > "$File"
		echo "$File: line(s) $Selector deleted"
	fi


fi
