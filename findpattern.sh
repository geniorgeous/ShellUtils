#!/bin/bash


if [  $# != 5 ] && [  $# != 4 ] && [ $# != 3  ]
then 
	echo "USAGE : findpattern i/s <directory> <pattern> {.<file_extension>/any} {E-pattern1/pattern2}
# Option \$1 is for case sentsitive or case unsensitive
# Usage A: if \$4 exists and not equal to any: looking for pattern \$2 (case unsensitive) in files with extension \$4 under folder \$3. If any, it does not filter an extension
# Example: findpattern s . static js
# Usage B: if \$5 exists, Usage A plus it excludes any path containing the pattern(s). Patterns do not contain /. / is the separator between patterns. Limitation: max 2 patterns
# Example: findpattern i . static any E-node_/dist
"

       	exit
fi

param2searchdirectory=$2
param3searchpattern=$3


if [ $1 = "i" ]
	then


	if [ $5 ]
	then
		param4extension=$4
		param5foldertoremove=$5


		if [ `echo $param5foldertoremove | grep -o "^E\-" | wc -l` = 1 ]
			then
			folderToRemove=`echo $param5foldertoremove | cut -c3-`
			if [ `echo $folderToRemove | grep -o "/" | wc -c` = 2 ]
				then
					folderToRemove1=`echo $folderToRemove | cut -d \/ -f1`
					folderToRemove2=`echo $folderToRemove | cut -d \/ -f2`
					echo $folderToRemove1
					echo $folderToRemove2
					if [ "$param4extension" = "any" ]
						then
						find $param2searchdirectory  -type f -not -path "*$folderToRemove1*" -not -path "*$folderToRemove2*" -exec grep  -Hnia "$param3searchpattern" {} \;     |  grep -va '.hg' | grep -va " matches$" | cut -c3- | grep -ia --color=auto "$param3searchpattern"
					else
						find $param2searchdirectory  -type f -iname "*$param4extension" -not -path "*$folderToRemove1*" -not -path "*$folderToRemove2*" -exec grep  -Hnia "$param3searchpattern" {} \;     |  grep -va '.hg' | grep -va " matches$" | cut -c3- | grep -ia --color=auto "$param3searchpattern"

					fi

			else
					if [ "$param4extension" = "any" ]
						then
						find $param2searchdirectory  -type f -not -path "*$folderToRemove*" -exec grep  -Hnia "$param3searchpattern" {} \;     |  grep -va '.hg' | grep -va " matches$" | cut -c3- | grep -ia --color=auto "$param3searchpattern"
					else
						find $param2searchdirectory  -type f -iname "*$param4extension" -not -path "*$folderToRemove*" -exec grep  -Hnia "$param3searchpattern" {} \;     |  grep -va '.hg' | grep -va " matches$" | cut -c3- | grep -ia --color=auto "$param3searchpattern"

					fi
			fi
			echo $folderToRemove
		fi
	elif [ $4 ]
	then
		param4extension=$4
		find $param2searchdirectory -type f -iname "*$param4extension"  -exec grep  -Hnia "$param3searchpattern" {} \;     |  grep -va '.hg' | grep -va " matches$" | cut -c3- | grep -ia --color=auto "$param3searchpattern"
	else
		grep -rnia "$param3searchpattern" $param2searchdirectory      |  grep -va '.hg' | grep -va " matches$" | cut -c3- | grep -ia --color=auto "$param3searchpattern"
	fi

else
	if [ $5 ]
	then
		param4extension=$4
		param5foldertoremove=$5
		if [ `echo $param5foldertoremove | grep -o "^E\-" | wc -l` = 1 ]
			then
			folderToRemove=`echo $param5foldertoremove | cut -c3-`
			if [ `echo $folderToRemove | grep -o "/" | wc -c` = 2 ]
				then
					folderToRemove1=`echo $folderToRemove | cut -d \/ -f1`
					folderToRemove2=`echo $folderToRemove | cut -d \/ -f2`
					echo $folderToRemove1
					echo $folderToRemove2
					if [ "$param4extension" = "any" ]
						then
						find $param2searchdirectory  -type f -not -path "*$folderToRemove1*" -not -path "*$folderToRemove2*" -exec grep  -Hna "$param3searchpattern" {} \;     |  grep -va '.hg' | grep -va " matches$" | cut -c3- | grep -ia --color=auto "$param3searchpattern"
					else
						find $param2searchdirectory  -type f -iname "*$param4extension" -not -path "*$folderToRemove1*" -not -path "*$folderToRemove2*" -exec grep  -Hna "$param3searchpattern" {} \;     |  grep -va '.hg' | grep -va " matches$" | cut -c3- | grep -a --color=auto "$param3searchpattern"

					fi

			else
					if [ "$param4extension" = "any" ]
						then
						find $param2searchdirectory  -type f -not -path "*$folderToRemove*" -exec grep  -Hna "$param3searchpattern" {} \;     |  grep -va '.hg' | grep -va " matches$" | cut -c3- | grep -a --color=auto "$param3searchpattern"
					else
						find $param2searchdirectory  -type f -iname "*$param4extension" -not -path "*$folderToRemove*" -exec grep  -Hna "$param3searchpattern" {} \;     |  grep -va '.hg' | grep -va " matches$" | cut -c3- | grep -a --color=auto "$param3searchpattern"

					fi
			fi
			echo $folderToRemove
		fi
	elif [ $4 ]
		then
			param4extension=$4		
			find $1 -type f -iname "*$param4extension"  -exec grep  -Hna "$param3searchpattern" {} \;     |  grep -va '.hg' | grep -va " matches$" | cut -c3- | grep -a --color=auto "$param3searchpattern"
	else
		grep -rna "$param3searchpattern" $param2searchdirectory      |  grep -va '.hg' | grep -va " matches$" | cut -c3- | grep -a --color=auto "$param3searchpattern"
	fi


fi


