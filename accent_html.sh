#!/bin/bash

# INIT: arguments number checking
if [ $# != 1  ]
	then
	echo "USAGE: `basename $0` <filename>
DESCRIPTION: replaces HTML encoded chars by UTF8 char (supported by modern browsers)
DETAILS:
sedonfile \"iso-8859-1\" \"utf-8\" \$1
sedonfile \"&\eacute;\"  é \$1
sedonfile \"&\egrave;\"  è \$1
sedonfile \"&\#8217;\" \"\'\" \$1
sedonfile \"&\agrave;\"  à \$1
sedonfile \"&\ecirc;\"  ê \$1
sedonfile \"&\icirc;\"  î \$1
sedonfile \"&\acirc;\"  â \$1
sedonfile \"&\ocirc;\"  ô \$1
sedonfile \"&\laquo;\"  \"«\" \$1
sedonfile \"&\raquo;\"  \"»\" \$1
sedonfile \"&\Ccedil;\"  "Ç" \$1
sedonfile \"&\ccedil;\"  "ç" \$1
sedonfile \"&\amp;\"  & \$1
sedonfile \"&\gt;\"  \< \$1
sedonfile \"&\lt;\"  \> \$1
sedonfile \"&\#124;\"  \| \$1
DEPENDENCIES: sedonfile
EXAMPLE: `basename $0` index.html
"
	exit
fi

# INIT: check file $1 exists
if [ ! -e "$1" ]
then
	echo "file \"$1\" does not exist"
	exit
fi

sedonfile "iso-8859-1" "utf-8" $1
sedonfile "&\eacute;"  é $1
sedonfile "&\egrave;"  è $1
sedonfile "&\#8217;"  "\'" $1
sedonfile "&\agrave;"  à $1
sedonfile "&\ecirc;"  ê $1
sedonfile "&\icirc;"  î $1
sedonfile "&\acirc;"  â $1
sedonfile "&\ocirc;"  ô $1
sedonfile "&\laquo;"  "«" $1
sedonfile "&\raquo;"  "»" $1
sedonfile "&\Ccedil;"  "Ç" $1
sedonfile "&\ccedil;"  "ç" $1
sedonfile "&\amp;"  "&" $1
sedonfile "&\gt;"  "\<" $1
sedonfile "&\lt;"  "\>" $1
sedonfile "&\#124;"  "\|" $1
