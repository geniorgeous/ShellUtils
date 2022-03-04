#!/bin/bash

python -c "exec(\"import sys, json\\njsonData=json.load(sys.stdin)\\nfor item in jsonData['items']: print(item['id'] + ':' + str(item['version']))\")"
