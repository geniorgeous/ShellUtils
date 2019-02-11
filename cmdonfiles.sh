#!/bin/bash


# INIT: arguments number checking
if [ $# == 0  ]
    then 
    echo "
USAGE : `basename $0` <r/s> <filename_pattern> action (with [file] to refer to file)
DESCRIPTION: 
VERSION$Revision: 1.3 $
DEPENDANCIES: none
EXAMPLE: cmdonfiles \"*.jpg\" ls -l [file] 
EXAMPLE2: cmdonfiles \"dscn*jpg\" renamefilename -a [file] 0 4 ph
"
    exit
fi

if [ $1 = "s" ]
	then

	numberOfSlash=`echo "$2" | sed "s/[^/]//g" | wc -c`
	if [ $numberOfSlash -eq 1 ]
		then
		dirname='.'
		pattern="$2"
	else
		numberOfSlashMinus1=`expr $numberOfSlash \- 1`
		dirname=`echo "$2" | cut -d "/" -f-$numberOfSlashMinus1`
		pattern=`echo "$2" | cut -d "/" -f$numberOfSlash-`
	fi

	# '*' chars are protected using $*
	action=${*/\*/\\\*}
	# $action contains the arguments from $3 to the end
	action=`echo $action | cut -d\  -f3-`
	# loop on files in directory (not recursive)
	for file in `find $dirname -mindepth 1 -maxdepth 1 -type f -name "$pattern"`
	  do
	  if [ $3 ]
	      then
		  # replaces until 5 occurences of [file] in the command line

		  action2=${action/\[file\]/$file} # this replaces only 1 occurrence of [file]
		  action3=${action2/\[file\]/$file} # this replaces only 1 occurrence of [file]
		  action4=${action3/\[file\]/$file} # this replaces only 1 occurrence of [file]
		  action5=${action4/\[file\]/$file} # this replaces only 1 occurrence of [file]
		  cmd=${action5/\[file\]/$file} # this replaces only 1 occurrence of [file]
		  cecho RED "$cmd"
		  # run $cmd
	      $cmd
	  fi
	done
elif [ $1 = "r" ]
	then

	# '*' chars are protected using $*
	action=${*/\*/\\\*}
	# $action contains the arguments from $3 to the end
	action=`echo $action | cut -d\  -f3-`
	# loop on files in directory (not recursive)
	for file in `find . -type f -name "$2"`
	  do
	  if [ $3 ]
	      then
		  # replaces until 5 occurences of [file] in the command line
		  action2=${action/\[file\]/$file} # this replaces only 1 occurrence of [file]
		  action3=${action2/\[file\]/$file} # this replaces only 1 occurrence of [file]
		  action4=${action3/\[file\]/$file} # this replaces only 1 occurrence of [file]
		  action5=${action4/\[file\]/$file} # this replaces only 1 occurrence of [file]
		  cmd=${action5/\[file\]/$file} # this replaces only 1 occurrence of [file]
		  cecho RED "$cmd"
		  # run $cmd
	      $cmd
	  fi
	done
fi

