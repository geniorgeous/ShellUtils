#!/bin/bash

ChangeZoneAhead () {

    if [ $# != 4 ]
	then
	echo "
# USAGE: `basename $0` -a[i] : to run with 4 additional arguments:
# \$1 = <filename>
# \$2 = <integer_of_start_substring_to_replace>
# \$3 = <integer_of_substring_length>
# \$4 = <substring_to_put_in_replacement>
# in short: renamefile -a[i] <filename> <start> <length> <string>
# option -ai means interactive question to confirm replacement
"
	exit
    fi
    name=`echo $1 | awk -F"/" '{print $NF}'`
    ls -l $name
    totalLength=`echo $name | wc -c | sed "s/\ //g"`
    totalLength=`expr $totalLength - 1`
    let "indice = $2"
    let "length = $3"

    temp=`expr $indice`

    if [ `expr $temp \> 0` != 0 ]
	then
		begin=`echo $name | cut -c-$temp`
    else
		begin=""
    fi

    temp=`expr $indice + $length + 1`
    if [ `expr $temp \< $totalLength + 1` != 0 ]
	then
		end=`echo $name | cut -c$temp-`
	else
		end=""
    fi

    new_name=$begin$4$end
}


ChangeZoneBehind () {


    if [ $# != 4 ]
	then
	echo "
# USAGE: `basename $0` -a[i] : to run with 4 additional arguments:
# \$1 = <filename>
# \$2 = <integer_of_length_after_substring>
# \$3 = <integer_of_substring_length>
# \$4 = <substring_to_put_in_replacement>
# in short: renamefile -b[i] <filename> <start> <length> <string>
# option -bi means interactive question to confirm replacement 
"
	exit
    fi
    name=`echo $1 | awk -F"/" '{print $NF}'`
    ls -l $name
    totalLength=`echo $name | wc -c | sed "s/\ //g"`
    totalLength=`expr $totalLength - 1`
    let "indice = $2"
    let "length = $3"

    temp=`expr $totalLength - $indice - $length`
    if [ `expr $temp \> 0` != 0 ]
	then
		begin=`echo $name | cut -c-$temp`
    else
		begin=""
    fi

    temp=`expr $totalLength - $indice + 1`

    if [ `expr $temp \< $totalLength + 1` != 0 ]
	then
		end=`echo $name | cut -c$temp-`
    else
		end=""
    fi

    new_name=$begin$4$end
}


ChangePattern () {
    if [ $# != 3 ]
	then
	echo "
# USAGE: `basename $0` -p[i] : to run with 3 additional arguments:
# \$1 = <filename>
# \$2 = <substring_to_replace>
# \$3 = <substring_to_put_in_replacement>>
# in short: renamefile -p[i] <filename> <start> <length> <string>
# option -pi means interactive question to confirm replacement
"
	exit
    fi
    new_name=${1/$2/$3}


}


################ MAIN PROGRAM #################

if [ $# = 0 ]
    then
	echo "
# USAGE: `basename $0` to run with 3 modes: -a, -b or -p with optionnally [i]:
# option -i means interactive question to confirm replacement
# to display usage with each mode, enter renamefile -a/-b/-p
# renamefile -a (like ahead) is used to change a substring of filename based on integer of start substring to replace
# renamefile -b (like behind) is used to change a substring of filename based on integer of length after substring to replace
# renamefile -p (like pattern) is used to change a substring of filename based on a pattern to replace
"
	exit
fi


while getopts ":abpni" Option
  do
  case $Option in
      a     ) mode="ahead";;
      b     ) mode="behind";;
      p     ) mode="pattern";;
      i     ) interactive="true";;
      *     ) echo "Option non implémentée.";;   # DEFAULT
  esac
done

shift $(($OPTIND - 1))
echo $1

. ifsnospace
if [ "$mode" = "ahead" ]
    then
    ChangeZoneAhead "$1" "$2" "$3" "$4"
elif [ "$mode" = "behind" ]
    then
    ChangeZoneBehind $1 $2 $3 "$4"
elif [ "$mode" = "pattern" ]
    then
    ChangePattern $1 $2 $3
fi

if [ $interactive ]
    then

    echo "Voulez-vous renommer $1 en $new_name ? (y/n)"
    read in
    if [ $in != "y"  ]
	then exit
    fi
fi

mv -v $1 $new_name
. ifsspace
