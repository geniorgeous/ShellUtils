#!/bin/bash

usage () {
    echo "USAGE : `basename $0` <prod/local> <table_name>
DESCRIPTION: list all the elements of the table table_name
DEPENDENCIES: jq
EXAMPLE: `basename $0` local User"
}

# INIT: arguments number checking
if [ $# != 2 ]
then usage
  exit
fi

mode="$1"
tableName="$2"

tableList="Bucket Geostruct Item ItemLng Location Pointer Section Specialty SpecialtyLng StaticObject Stella Tag TagLng User"

if [[ $tableList =~ (^|[[:space:]])$tableName($|[[:space:]]) ]]
then
  newman run postman/listItems.postman_collection.json --environment postman/$mode.postman_environment.json --env-var  table="$tableName" | grep "^  │ " | tail -n +3 | sed "s/  │ //g" | sed "s/^'{/{/g" | sed "s/}'$/}/g" | sed ':s;N;s/\n//;bs' | sed "s/pointer/id/g" | jq -e .
else
  echo "Invalid table name"
fi
