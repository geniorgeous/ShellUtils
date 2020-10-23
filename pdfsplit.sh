#!/bin/bash

# INIT: arguments number checking
if [ $# != 3 ]
    then
    echo "USAGE : `basename $0` <filename.pdf> <first_page_to_get> <last_page_to_get>
DESCRIPTION:  for the pdf $1, generates a pdf starting at $2 and ending at $3 page
"
    exit
fi

# INIT: check $1 directory
if [ ! -e "$1" ]
                then
                echo "file \"$1\" does not exist"
                exit
fi

gswin64 -sDEVICE=pdfwrite -dNOPAUSE -dQUIET -dBATCH -dFirstPage=$2 -dLastPage=$3 -sOutputFile=$1.from.$2.to.$3.pdf $1
