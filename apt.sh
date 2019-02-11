#!/bin/bash

# INIT: arguments number checking
if [ $# -lt 2	]
then
	echo "USAGE : `basename $0` <mode: search/show/install/reinstall/remove/clean> <program_name (s)>/<pattern>
DESCRIPTION: simple interface to not use apt-get and apt-cache: 5 modes: search/show/install/reinstall/remove
DEPENDENCIES: apt-get and apt-cache
EXAMPLE: apt remove skype 
"
	echo '
# if      mode = search, search in the list of available program matching pattern $2
# else if mode = show, shows in detail the packets (program installer binaries $*) properties
# else if mode = install: install the list of programs $*
# else if mode = reinstall: reinstall the list of programs $*
# else if mode = remove: remove the list of programs $* all the config files and dependent libraries (cleanly, without altering libraries of other programs)
# else if mode = clean: clean the database of apt to speed-up apt operations
'
	exit
fi

selector=$1
# $* represents all the parameters from 1 to n
# here $1 is a selector of command so real parameters are from 2 to n
# so 'shift' command is useful: the positional parameters are shifted by 1: $2 becomes $1, etc.
shift

if [ $selector == "remove" ]
then 
	echo "remove the list of programs $* all the config files and dependent libraries (cleanly, without altering libraries of other programs)"
	apt-get remove --purge $*
	apt-get autoremove
elif [ $selector == "show" ]
then 
	echo "shows in detail the packets (program installer binaries $*) properties"
	apt-cache show $*
elif [ $selector == "install" ]
then 
	echo "install the list of programs $*"
	apt-get install $*
elif [ $selector == "reinstall" ]
then 
	echo "reinstall the list of programs $*"
	apt-get install --reinstall $*
elif [ $selector == "search" ]
then 
	echo "[apt-cache search "$1" | grep -i "$1" | sort : ]"
	apt-cache search "$1" | grep -i "$1" | sort
elif [ $selector == "clean" ]
then 
	echo "dpkg --clear-avail; dpkg --forget-old-unavail"
	dpkg --clear-avail; dpkg --forget-old-unavail
fi
