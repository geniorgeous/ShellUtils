#!/bin/bash

ifsnospace () {
	IFS=`echo -e "\n\r\t\n"`
}
ifsspace () {
	IFS=`echo -e "\n \t\n"`
}

# INIT: arguments number checking
if [ $# != 1  ]
    then
    echo "USAGE : `basename $0` <pattern>
DESCRIPTION: kills even when a process is not responding and interactively  a list of processes with pattern \$1
DETAILS: - skill -9 -i -c \$1 has the same result if \$1 is exactly the name of command to kill, but does nohing if \$1 is just a substring
         - pkill kills a process validating a pattern as well, but no interactive mode, and not with Kill signal (-9)
"
    exit
fi


# 1- change $IFS to not consider spaces (in result of `ps x`) as separator, for the loop criteria: we want to loop on line, not on word
. ifsnospace
# 2 loop on the process printed by `ps x` matching $1 pattern, but killing neither current killpattern9 nor current grep
for PROCESSUS in `ps -x | grep -i $1 | grep -v "killpattern9" | grep -v "grep -i $1"`
do
        echo "Do you want to kill -9 `echo $PROCESSUS ` ? (y/n)"
        # reads the user answer and continue only if answer = "y"
        read in
        if [ $in = "y"  ]
        then
                # a typical line looks like it: "  205 ?        S<     0:00 [aio/1]"
                # the pid to kill is printed at start of line so we have to get it
                # remove the spaces before pid (| sed "s/^[\ ]*//g" )
                # get the part before first space (| cut -d \  -f-1)
                pidToKill=`echo $PROCESSUS | sed "s/^[\ ]*//g" | cut -d \  -f-1`
                echo "kill -9 $pidToKill"
                kill -9 $pidToKill
        fi
done
. ifsspace



