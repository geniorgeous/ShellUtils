#!/bin/bash

# INIT: arguments number checking
if [ $# -lt 1	]
then
	echo "USAGE : `basename $0` <operationContent.txt>
DESCRIPTION: Convert ps file into csv file containing the list of banking transactions
DETAIL: the table structure is col1=date, col2=operationName, col3=date, col4(optional)=exo, col5(optional)=débit, col6(optional)=crédit
DEPENDENCIES: none
PRE-STEP: for i in \`ls *_RELEVE.DE.COMPTE_*.ps\` ; do { cat \$i | sed \"s/^..\[(/\[(/g\" | sed  \"s/08(X)-8/(COTIS HSBC HEXAGONE)-5(w)-/g\" | sed \"s/\([[:alnum:] ]\)-/\1/g\" | grep -A 5 \"^\[([0-9][0-9]\.[0-9][0-9]).*(.*).*(.*).*(.*).*\" | egrep \"^\(|^\[\(\" | sed ':a;N;\$!ba;s/\n(/ (/g' | sed \"s/(X)//g\"; } done > operationContent.txt
"
	exit
fi

# PRINCIPLE: cat file.ps | sed "s/^..\[(/\[(/g" | grep  '^\[([0-9][0-9]\.[0-9][0-9]' -> gives lines like:
# DEBIT LINE : [(07.02)-2036.46(CB CARREFOUR CITY         06/02)-16670.8(07.02)-10844.2(13,96)]TJ
#                                                                               ^^^^^
# CREDIT LINE: [(25.02)-2036.46(VIREMENT SEPA RECU    YCI0 12737)-14613.8(25.02)-19613.4(3.000,00)]TJ
#                                                                                ^^^^^
# CONCLUSION: The number between the 2 last () is the space. It is bigger than 15000 when it's a credit

# one problem: all the operation lines have 4 times (), except COTIS HSBC HEXAGONE, with this syntax: [(05.09)-2421.08(X)-8333(8,35)]TJ
# the pattern for exception is 08(X)-8 -> the idea is to rebuild a normal operation line, by replacing it

# PAY ATTENTION: after doing the pre-step -> the diferent years have to be in defferent operationContent: operationContent2022.txt, operationContent23.txt
# Then: hsbcpstocsv operationContent2022.txt | sort -r > result2022.csv
#       hsbcpstocsv operationContent2023.txt | sort -r > result2023.csv

getXAxisGreaterThan () {
	# compare integer length
	int1=`echo $1 | cut -d \. -f 1`
	#echo $int1
	int2=`echo $2 | cut -d \. -f 1`
	#echo $int2
	if [ `echo $int1 | wc -c` -lt `echo $int2 | wc -c` ]; then
		return 0
	elif [ `echo $int1 | wc -c` -gt `echo $int2 | wc -c` ]; then
		return 1
	else
		if [ $1 \> $2 ]; then
			return 1
		else
			return 0
		fi
	fi
}

getXAxisInRange () {
	getXAxisGreaterThan $2 $1
	if [ $? -ne 0 ]; then
		getXAxisGreaterThan $3 $2
		if [ $? -ne 0 ]; then
			return 1
		else
			return 0
		fi
	else
		return 0
	fi
}

getIndex () {
	localIndexDate=$2
	date=$1
	if grep -q "$date" <<< "$localIndexDate"; then
  	localIndexDate="$localIndexDate"0
  else
  	localIndexDate="$date-"
  fi
  	echo $localIndexDate
}


psfile="$1"
index="0101-"
indexDate="0101-"
lineSuffix="1"
######################################
# $IFS removed to allow the trimming # 
#####################################
while read -r line
do
  #echo "$line"
  # get the next line: X axis is lower than 80, and the value 3 lines after is a date with format dd.mm
  if grep -q '^\[([0-9][0-9]\.[0-9][0-9]' <<< "$line"; then
  	# get the Y value
  	yvalue=`echo $line`
  	linePattern=`echo $line | grep -o "^\[([0-9][0-9]\.[0-9][0-9])" | sed "s/^\[/\\\\\\[/g"`
  	if [ $lineSuffix -eq 1 ]; then
  		lineSuffix=`grep "$linePattern" $1 | wc -l`
  	else
  		lineSuffix=`expr $lineSuffix \- 1`
  	fi
  	if [ `echo $lineSuffix | wc -c` -eq 2 ]; then lineSuffixString="0$lineSuffix"; else lineSuffixString="$lineSuffix"; fi
  	col1index=`echo $line | grep -o "^\[([0-9][0-9]\.[0-9][0-9])" | sed "s/\([0-9][0-9]\).\([0-9][0-9]\)/\2\1/g" | grep -o "[0-9][0-9][0-9][0-9]"`"-$lineSuffixString"
  	col2=`echo $line | grep -o "^\[([0-9][0-9]\.[0-9][0-9])" | sed "s/\([0-9][0-9]\).\([0-9][0-9]\)/\1\/\2/g" | grep -o "[0-9][0-9]/[0-9][0-9]"`"/2023"
  	col3=`echo $line | cut -d \( -f3 | cut -d \) -f1`
  	col4=`echo $line | cut -d \( -f5 | cut -d \) -f1 | sed "s/\.//g"`
  	if [ `echo $col3 | grep "^CB " | wc -l` -eq 1 ]; then
  		# display the city where the payment was done
  		col3="$col3 "`echo $line | cut -d \( -f 6 | cut -d \) -f 1`
  	elif [ `echo $col3 | grep "^VIREMENT " | wc -l` -eq 1 ] || [ `echo $col3 | grep "^VIRT SEPA " | wc -l` -eq 1 ]; then
  		# display the person who did the transfer
  		col3="$col3 "`echo $line | cut -d \( -f 7 | cut -d \) -f 1`
  	elif [ `echo $col3 | grep "^PRLV " | wc -l` -eq 1 ]; then
  		# display the person who did the transfer
  		col3="$col3 "`echo $line | cut -d \( -f 8 | cut -d \) -f 1`
  	fi 
  	spaceNumber=`echo $line | cut -d \- -f4 | cut -d \( -f1 | cut -d \. -f1`
  	getXAxisGreaterThan $spaceNumber "15000"
  	if [ $? -ne 0 ]; then
  		echo "$col1index | $col2 | $col3 || $col4"
  	else
  		echo "$col1index | $col2 | $col3 | $col4"
  	fi
	fi

done < "$psfile"
