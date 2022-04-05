#!/bin/bash

usage () {
    echo "USAGE : `basename $0` <prod/local> <table_name>
DESCRIPTION: delete all the elements of the table_name
DEPENDENCIES: listItems.sh, deleteItemsfromTable.sh
EXAMPLE: `basename $0` local Pointer"
}

# INIT: arguments number checking
if [ $# != 2 ]
then usage
	exit
fi

mode="$1"
tableName="$2"


listItems $mode $tableName > ../items.json

deleteItemsfromTable $mode $tableName ../items.json
