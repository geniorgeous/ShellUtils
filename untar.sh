#!/bin/bash

# INIT: Parameters number checking
if [ $# != 1  ]
	then
    echo "USAGE: `basename $0` <filename.extension (extension=tar/bz2/gz/tar.gz/tar.bz2)>
DESCRIPTION: untar tarball \$1, if extension is tar or bz2 or gz or tar.gz or tar.bz2 in a directory named filename
DEPENDENCY: tar
"

	exit
fi

# INIT: check tarball $1 exists
if [ ! -e "$1" ]
then
		echo "file $1 does not exits"
		exit
fi
tarball="$1"

# 1- check extension .tar.gz of archive
if [ `echo "$tarball" |grep ".tar.gz$" | wc -l`  = 1 ]
then
		tar -xvzf "$tarball"
		exit
fi


# 2- check extension .tar.bz2 of archive
if [ `echo "$tarball" |grep ".tar.bz2$" | wc -l`  = 1 ]
then
		tar -xjvf "$tarball"
		exit
fi


# 3- check extension .tar of archive
if [ `echo "$tarball" |grep ".tar$" | wc -l`  = 1 ]
then
		tar -xvf "$tarball"
		exit
fi


# 4- check extension .bz2 of archive
if [ `echo "$tarball" |grep ".bz2$" | wc -l`  = 1 ]
then
		bunzip2 "$tarball"
		exit
fi


# 5- check extension .gz of archive
if [ `echo "$tarball" |grep ".gz$" | wc -l`  = 1 ]
then
		gunzip "$tarball"
		exit
fi
