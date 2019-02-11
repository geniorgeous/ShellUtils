#!/bin/bash



if [  $# != 3 ] && [ $# != 2  ]
then 
	echo "USAGE : `basename $0` <directory> <pattern> {<file_extension>}
# finds files in \$1 directory that not contains \$2 pattern (not case sensitive)
# if \$3 is specified, do that for file with extension .\$3
# Example: `basename $0` . bin/bash sh
"

       	exit
fi

directory="$1"
pattern="$2"

. ifsnospace

if [ $3  ] 
		then

		for i in `find $directory -type f -iname "*$3"` 
			do 
			if [ `grep -i "$pattern" $i | wc -l` -eq 0 ]
					then
					echo $i
			fi 
		done

else

		for i in `find $directory -type f` 
			do 

			if [ `grep -i "$pattern" $i | wc -l` -eq 0 ]
					then
					echo $i
			fi 
		done


fi


. ifsspace

