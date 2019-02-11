#!/bin/bash
# IFS (internal field separators) is the variable defining the separator for shell: ex: a program determines the arguments by splitting arguments string with IFS characters
# IFS contains a list of characters, c1c2c3..., meaning the separators are c1 or c2 or c3...
# Usually, the OS IFS is <space><tabulation><line feed>
# Reminder: end of line on Unix OS is line feed and on Windows it is line feed + carriage return
# here the goal is to go back to the OS value where space is a separator (typically when IFS has been altered in a part only of a program)
# Usage: . ifsnospace
# important '.': it runs the program inside the caller program so variable changes also in caller program (else it runs outside the caller so variable is not changed so it is useless)
# one line use case: 
# . ifsnospace; for i in `ls`; do { . ifsspace; echo "$i"; } done
# afterwards in the example, space is a separator 
IFS=`echo -e "\n \t\n"`

