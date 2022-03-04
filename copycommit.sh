#!/bin/bash

usage () {
	echo "USAGE :
`basename $0` -e <folderToExport> OR `basename $0` -c <commitcode> OR `basename $0` -i <folerToImport>

# -e mode (export local): It creates a subfolder in geotmp folder containing all uncommited files.
# -c mode (export commit): It creates a subfolder in geotmp folder containing all the files of a commit.
# -i mode (import): It can be then reused to copy this bunch of file in a different branch"
}

# If the last command failed, it desplays error and it exits
error ( ) {
	if [ $? != 0 ]
        	then usage
        	echo "
commit id < $1 > not valid"
        	exit
	fi
}

# INIT: arguments number checking
if [ $# != 2  ]
	then usage
	exit
fi

mode=$1
commitId=$2
initDir=`pwd`


if [ $mode == "-e" ] || [ $mode == "-c" ]
	then
		if [ $mode == "-e" ]
		then
			filelist=`git ls-files -m`
		else
			filelist=`git --no-pager show --pretty="format:" --name-only $commitId`
			error $commitId
		fi

		mkdir /Users/julienmalfait/Dev/geotmp/$commitId 2>/dev/null

		dirList=`for i in $filelist; do dirname $i; done`
		dirShortList=`echo -e "$dirList" | sort | uniq`
		echo $dirShortList

		for i in $dirShortList
		do
			echo "Creating ~/Dev/geotmp/$commitId/$i"
			mkdir -p "/Users/julienmalfait/Dev/geotmp/$commitId/$i"
		done

		for i in $filelist
		do
			echo "cp $i /Users/julienmalfait/Dev/geotmp/$commitId/$i"
			cp $i /Users/julienmalfait/Dev/geotmp/$commitId/$i
		done
elif [ $mode == "-i" ]
	then
		ls /Users/julienmalfait/Dev/geotmp/$commitId
		error $commitId
		cd /Users/julienmalfait/Dev/geotmp/$commitId
		for i in `find . -type f | cut -c3-`
		do
			echo "cp $i $initDir/$i"
			cp $i $initDir/$i
		done
		cd -
fi
