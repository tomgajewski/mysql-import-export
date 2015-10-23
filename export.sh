#!/bin/bash
source ./common.sh


#if filename is provided use it , if not take default one
if [ "$1" != "" ];
  then
    EXPORT_FILENAME=$1
fi


echo "You are about to export DB (host:$SOURCE_DB_HOST , dbname: $SOURCE_DB_NAME , dbuser:$SOURCE_DB_USER, pass:$SOURCE_DB_PASS to a file $EXPORT_DIR$EXPORT_FILENAME, Proceed (y/n) ? "



read answer
if echo "$answer" | grep -iq "^y" ;then
   mysqldump -h $SOURCE_DB_HOST -u $SOURCE_DB_USER -p"$SOURCE_DB_PASS"   --routines --max_allowed_packet=512M $SOURCE_DB_NAME > $EXPORT_DIR$EXPORT_FILENAME

    if [ ${PIPESTATUS[0]} -ne "0" ];
    then
        echo "Export has failed with Error: ${PIPESTATUS[0]}";
        exit 1;
    else
        actualsize=$(wc -c <"$EXPORT_DIR$EXPORT_FILENAME")
        echo "DB EXPORTED to $EXPORT_DIR$EXPORT_FILENAME with size $actualsize bytes"
    fi

else
    echo Aborted
fi


