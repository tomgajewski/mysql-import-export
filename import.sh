#!/bin/bash
source ./common.sh

echo "IMPORT SCRIPT"

if [ "$SOURCE_INPUT" = "DB" ];
then
    echo "Your SOURCE INPUT is: DB , we will temp export the source db to later import it.."
    sh export.sh $EXPORT_FILENAME

else

    EXPORT_FILENAME=$SOURCE_FILE
    echo "Your SOURCE INPUT FILE: $EXPORT_FILENAME"

fi

if [ "$REPLACE_DEFINER" = "YES" ];
then
    sh replace-definers.sh $EXPORT_FILENAME $REPLACE_PATTERN
fi

echo "IMPORTING  mysql --host=$TARGET_DB_HOST --user=$TARGET_DB_USER --password=$TARGET_DB_PASS $TARGET_DB_NAME < $EXPORT_DIR$EXPORT_FILENAME;"
echo "Proceed (y/n) ? "

read answer
if echo "$answer" | grep -iq "^y" ;then
   mysql --host=$TARGET_DB_HOST --user=$TARGET_DB_USER --password=$TARGET_DB_PASS $TARGET_DB_NAME < $EXPORT_DIR$EXPORT_FILENAME;

    if [ ${PIPESTATUS[0]} -ne "0" ];
    then
        echo "Import has failed with Error: ${PIPESTATUS[0]}";
        exit 1;
    else
        echo "OK"
    fi

else
    echo Aborted
fi





