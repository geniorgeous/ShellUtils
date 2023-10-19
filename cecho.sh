#!/bin/bash


# INIT: arguments number checking
if [ $# == 0  ]
    then
    echo "
USAGE : `basename $0` COLOR=RED/GREEN/BLUE/PINK/CYAN/BOLD/GRAY/YELLOW <arguments>
DESCRIPTION: echo a text in a specific color
DEPENDENCIES: none
EXAMPLE: `basename $0` RED \"hello\"
"
    exit
fi



# '*' chars are protected using $*
arguments=${*/\*/\\\*}
# $action contains the arguments from $2 to the end
arguments=`echo $action | cut -d\  -f2-`

if [ "$1" == "RED" ]; then
 echo -en "\033[31m\033[1m$2\033[0m" $arguments"\n"
elif [ "$1" == "GREEN" ]; then
 echo -en "\033[32m\033[1m$2\033[0m" $arguments"\n"
elif [ "$1" == "BLUE" ]; then
 echo -en "\033[34m\033[1m$2\033[0m" $arguments"\n"
elif [ "$1" == "PINK" ]; then
 echo -en "\033[35m\033[1m$2\033[0m" $arguments"\n"
elif [ "$1" == "CYAN" ]; then
 echo -en "\033[36m\033[1m$2\033[0m" $arguments"\n"
elif [ "$1" == "BOLD" ]; then
 echo -en "\033[37m\033[1m$2\033[0m" $arguments"\n"
elif [ "$1" == "GRAY" ]; then
 echo -en "\033[90m\033[1m$2\033[0m" $arguments"\n"
elif [ "$1" == "YELLOW" ]; then
 echo -en "\033[33m\033[1m$2\033[0m" $arguments"\n"

else
 echo -e "$arguments"
fi
