#!/bin/bash

# INIT: arguments number checking
if [ $# != 1  ]
    then
    echo "USAGE: `basename $0` <directory_name>
DESCRIPTION: removes all the files (not the directories) in the directory \$1
"
    exit
fi

# INIT: check directory $1 exists
if [ ! -e "$1" ]
                then
                echo "directory \"$1\" does not exist"
                exit
fi

. ifsnospace; for i in `find . -maxdepth 1 -type f`; do rm "$i"; done;. ifsspace

