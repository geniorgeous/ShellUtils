#!/bin/bash

usage () {
    echo "USAGE : `basename $0` <prod/local> <table_name> <filename.json>
DESCRIPTION: delete all the elements listed in filename.json from the table_name
DEPENDENCIES: listItems
EXAMPLE: `basename $0` local StaticObject ../items.json"

echo 'PREREQUISITE: have a valid items.json like:
{
            "items": [
                {
                    "id": "1-l-v2",
                    "version": 1
                },
                {
                    "id": "a-p-v2-c",
                    "version": 1
                },
                {
                    "id": "b-t-v2",
                    "version": 1
                },
                {
                    "id": "v-t-v2",
                    "version": 1
                },
                {
                    "id": "a-p-v2-o-235",
                    "version": 1
                }
            ]
}
'
}

listItemsFunc () {
    python -c "exec(\"import sys, json\\njsonData=json.load(sys.stdin)\\nfor item in jsonData['items']: print(item['id'] + ':' + str(item['version']))\")"
}

# INIT: arguments number checking
if [ $# != 3 ]
then usage
	exit
fi

if [ ! -e "$3" ]
                then
                echo "file \"$3\" does not exist"
                exit
fi

mode="$1"
tableName="$2"
filename="$3"


tableList="Bucket Geostruct Item ItemLng Location Pointer Section Specialty SpecialtyLng StaticObject Stella Tag TagLng User"

if [[ $tableList =~ (^|[[:space:]])$tableName($|[[:space:]]) ]]
then
    for i in `listItemsFunc < $filename`; do newman run postman/deleteItem.postman_collection.json --environment postman/$mode.postman_environment.json --env-var  "table=$tableName" --env-var "id_version=$i"; done
fi

