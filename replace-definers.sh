#!/bin/bash
source ./common.sh


echo "Replacing Function Definers"

ARGUMENTS=$@

#if filename is provided use it , if not take default one
if [ "$1" == "" ];
  then
    echo "Please provide arguments"
   exit
fi




FILE="$EXPORT_DIR$1"
originalsize=$(wc -c <"$FILE")
echo "File to search and replace patterns is: $FILE"

var=1
for word in $ARGUMENTS
do
    if [ "$var" = "1" ];
    then

        var=$((var+1))
    else
        IFS='=' read -a array <<< "$word"
        echo "REPLACING: ${array[0]} with ${array[1]}"
        eval "sed -i'' -e 's/${array[0]}/${array[1]}/g'  $FILE"
    fi

done

#newsize=$(wc -c <"$FILE")
#
##if [ "$originalsize" != "$newsize" ];
##then
##    echo "File modified, size changed from $originalsize to $newsize"
##else
##    echo "File not modified - NOTHING HAS CHANGED"
##fi





