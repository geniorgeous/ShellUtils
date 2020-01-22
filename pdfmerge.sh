#!/bin/bash

# INIT: arguments number checking
if [ $# != 2 ]
    then
    echo "USAGE : `basename $0` <\"pattern\"> <generated_pdf_name.pdf>"
		echo '# merge all the files validating pattern $1, in alphabetical order
# Do not forget to add "" around pattern, else special caracter (* ?) are interpreted in the command
# run command:
# gs -dNOPAUSE -sDEVICE=pdfwrite -sOUTPUTFILE=\$2 -dBATCH \$1
# DEPENDENCIES: gs or gswin64 for windows
# EXAMPLE: pdfmerge "*.pdf" merged.pdf
'
    exit
fi

gs -dNOPAUSE -sDEVICE=pdfwrite -sOUTPUTFILE=$2 -dBATCH $1
