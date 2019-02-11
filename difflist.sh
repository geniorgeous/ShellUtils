#!/bin/bash

# affiche le formalisme attendu du lancement du script
usage () {
	echo "USAGE :
`basename $0` <list_of_files.txt> <folder_1> <folder_2>

# list_of_files.txt is expected to be a list of filenames, 1 filename per line
# It computes the diff on each of the file listed in list_of_files.txt: diff  folder_1/filenameK folder_2/filenameK
# folder_1 and folder_2 should be the relative path from the shell folder to the target folders, respectively
"

}

# si la dernière commande a renvoyé un message d'erreur, affiche le message d'erreur et sort
error () {
	if [ $? != 0 ]
        	then usage
        	echo $message
        	exit
	fi
}

# vérification du nombre d'arguments
if [ $# != 3  ]
	then usage
	exit
fi

# vérification des arguments
message=`ls $1`
error

message=`ls $2`
error

message=`ls $3`
error


# number of lines in the filename list txt file
num_lines=`cat $1 | wc -l`

# loop on list_of_files.txt
k=0
while [ $k -lt $num_lines ]
do

	k=`expr $k + 1`
	# line number K of the list_of_files.txt is the filenameK
	filenameK=`head -$k $1 | tail -1`
	# test if the line is empty
	if [ $filenameK ] 
		then
        	echo "diff $2/$filenameK $3/$filenameK"
	        diff "$2/$filenameK" "$3/$filenameK"
	fi
done







