#!/bin/bash

# INIT: arguments number checking
if [ $# -lt 1	]
then
	echo "USAGE : `basename $0` <ps_file>
DESCRIPTION: Convert ps file into csv file containing the list of banking transactions
DETAIL: the table structure is col1=date, col2=operationName, col3=date, col4(optional)=exo, col5(optional)=débit, col6(optional)=crédit
DEPENDENCIES: none
"
	exit
fi

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
######################################
# $IFS removed to allow the trimming # 
#####################################
while read -r line
do
  #echo "$line"
  # get the next line: X axis is lower than 80, and the value 3 lines after is a date with format dd.mm
  if grep -q "1 0 0 1 [1-7][0-9][0-9]\." <<< "$line"; then
  	# get the Y value
  	yvalue=`echo $line | cut -d \  -f 6`
  	echo "NEW LIIIIIIIIIINE $yvalue"
  	# get the first column
  	read -r line && read -r line && read -r line && read -r line && read -r line && read -r line
  	if grep -q "\([0-9][0-9]\.[0-9][0-9]\)" <<< "$line"; then
  		col1date=`echo $line | sed "s/[\(\)]//g"`
  		date=`echo $col1date | sed "s/\([0-9][0-9]\).\([0-9][0-9]\)/\2\1/g"`
  		indexDate=`getIndex $date $indexDate`
  		echo $indexDate
  		indexNumber=`echo $indexDate | cut -d \- -f 2 | wc -c`
  		index="$date-$indexNumber"
  		echo "$index"
  		outputLine="$index|$col1date|"
  		#echo $outputLine
  		# get the second column
  		while read -r line
  		do
  			if grep -q "1 0 0 1 .* [1-9]" <<< "$line"; then
  				xvalue=`echo $line | cut -d \  -f 5`
  				#echo $xvalue
  				getXAxisInRange "80" $xvalue "110"
  				if [ $? -ne 0 ]; then
  					read -r line && read -r line && read -r line
  					col2operation=`echo $line | sed "s/[\(\)]//g"`
  					outputLine="$outputLine$col2operation|"
  					#echo $outputLine
			  		while read -r line
			  		do
			  			if grep -q "1 0 0 1 .* $yvalue" <<< "$line"; then
			  				xvalue=`echo $line | cut -d \  -f 5`
			  				#echo $xvalue
			  				getXAxisInRange "400" $xvalue "480"
			  				if [ $? -ne 0 ]; then
			  					read -r line && read -r line && read -r line
			  					#echo "DEBIT "$line
			  					col3debit=`echo $line | sed "s/[\(\)]//g"`
			  					outputLine="$outputLine$col3debit|"
			  					echo $outputLine
			  					break
			  				fi
			  				getXAxisInRange "481" $xvalue "600"
			  				if [ $? -ne 0 ]; then
			  					read -r line && read -r line && read -r line
			  					#echo "CREDIT "$line
			  					col4credit=`echo $line | sed "s/[\(\)]//g"`
			  					outputLine="$outputLine|$col4credit"
			  					echo $outputLine
			  					break
			  				fi
			  			fi
			  		done
			  		break
  				fi
  			fi
  		done
  	fi
	fi

done < "$psfile"
