#!/bin/bash

# verification du nombre d'arguments
if [ $# != 2  ]
    then 
    echo "Usage : `basename $0` 90/180/270 <nom_de_fichier>
# pour le fichier \$2 (.pdf), tourne tout le document de 90° si \$1=90 ou 180° si \$1=180
# attention: les rotation ne sont pas associatives, c'est une rotation absolue par rapport a l'etat initial
# ainsi faire deux fois `basename $0` 90 toto.pdf a le meme effet que le faire une seule fois 
"
    exit
fi

if [ $1 = 90  ]
    then
    pdftk $2 cat 1-endEAST output ~/Downloads/tmp/`basename $2`
    rm $2
    mv ~/Downloads/tmp/`basename $2` $2
    echo "rotate 90° $2"
    exit
fi
if [ $1 = 180  ]
    then
    pdftk $2 cat 1-endSOUTH output ~/Downloads/tmp/`basename $2`
    rm $2
    mv ~/Downloads/tmp/`basename $2` $2
    echo "rotate 180° $2"
    exit
fi
if [ $1 = 270  ]
    then
    pdftk $2 cat 1-endWEST output ~/Downloads/tmp/`basename $2`
    rm $2
    mv ~/Downloads/tmp/`basename $2` $2
    echo "rotate 270° $2"
    exit
fi

echo "# \$1 doit valoir 90 ou 180 ou 270"

