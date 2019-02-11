#!/bin/bash


# INIT: arguments number checking
if [ $# != 2  ]
    then 
    echo "Usage : `basename $0` <relative_file_path> <remote_folder>
# It diplays <relative_file_path> <remote_folder>/<relative_file_path>
# To make sense, the remote folder should have similar content as current folder
# It is useful to do diff on a files in 2 different folder trees
"
echo '# Example: diff `mergepath ./core/src/common/ErrorCounter.cpp Z:/dev/workspace/myrepo`
# Example of recursive diff: diff -r `mergepath ./core/src/common Z:/dev/workspace/myrepo`
'
    exit
fi
relativeFilePath="$1"
otherFolder="$2"


echo "$relativeFilePath $otherFolder/$relativeFilePath"


