#!/bin/bash

# INIT: arguments number checking
if [ $# != 2 ]
then echo "USAGE : `basename $0` <prod/local> <stellaPointer>
DESCRIPTION: delete all the content of the Stella $1
EXAMPLE: `basename $0` local test406fr
"
	exit
fi

mode="$1"
stellaPointer="$2"

newman run postman/deleteFullStella.postman_collection.json --environment postman/$mode.postman_environment.json --env-var  "pointer=$stellaPointer"
