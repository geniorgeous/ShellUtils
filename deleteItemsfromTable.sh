#!/bin/bash

# INIT: arguments number checking
if [ $# != 1	]
then echo "USAGE : `basename $0` <table_name>
DESCRIPTION: delete all the elements listed in ../items.json from the table_name
DEPENDENCIES: listItems
EXAMPLE: `basename $0` StaticObject"

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
	exit
fi

tableName="$1"

tableList="Bucket BucketFolder DivElement DivLng2 Item ItemLng Location Media Post PostLng Specialty SpecialtyLng StaticObject Stella StellaPointer Tag TagLng User UserExtension UserPointer"

if [[ $tableList =~ (^|[[:space:]])$tableName($|[[:space:]]) ]]
then
	for i in `listItems < ../items.json`; do newman run postman/deleteElementFromTable.postman_collection.json --environment postman/local.postman_environment.json --env-var  "table=$tableName" --env-var "id_version=$i"; done
fi


