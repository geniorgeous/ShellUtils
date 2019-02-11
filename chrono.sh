#!/bin/bash

# INIT: arguments number checking
if [ $# == 0  ]                  
		then                         
		echo "USAGE : `basename $0` <command line>
DESCRIPTION: computes the elapsed time during command line, in ms
DEPENDENCIES: none
EXAMPLE: `basename $0` ls
RESULT: Run Time = 0 h 0 min 0 sec 15 millisec"
		exit
fi

# %s = nb of second since 01/01/1970
# %N = nb of nanoseconds of current second (9-digit result)
# Appending %s and %N gives an absolute time reference in nanoseconds

# 1- get absolute timestamp before:
beginNano=`date +%s%N`

# 2- runs the comand line
$*

# 3- get absolute timestamp after:
endNano=`date +%s%N`

# 4- computes elapsed time in milliseconds
deltaMilli=`expr \( $endNano / 1000000 \) - \( $beginNano / 1000000 \) `

# 5- computes hour/minute/second/millisecond decomposition:
milliseconds=`expr $deltaMilli % 1000`
seconds=`expr \( $deltaMilli / 1000 \) % 60`
minutes=`expr \( $deltaMilli / 60000 \) % 60`
hours=`expr $deltaMilli / 3600000`


echo "
Run Time = "$hours" h "$minutes" min "$seconds" sec "$milliseconds" millisec
"

