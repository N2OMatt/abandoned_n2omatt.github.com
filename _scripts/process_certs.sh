#!/bin/bash
SRC_CERTS_DIR="../_mycerts";
DST_CERTS_DIR="../certs";
SITE_ROOT_DIR=".."

helper()
{
    PDF_NAME=$1
    JPG_NAME=$(echo $PDF_NAME | sed s/pdf/jpg/g);
    
    # echo $PDF_NAME
    # echo $JPG_NAME
    
    convert "$PDF_NAME" "$JPG_NAME"
    rm "$PDF_NAME";
}
url-encode()
{
    echo $(python -c "import sys, urllib as ul; \
    print ul.quote(\" \".join(sys.argv[1:]))" $1)
}

export -f helper

rm -rf $DST_CERTS_DIR;
if [ ! -e $DST_CERTS_DIR ]; then
    mkdir $DST_CERTS_DIR;
fi

#Change the directory to ease the paths manipulation.
cd $SRC_CERTS_DIR

#Create the directories.
find ./* -not \( -path '*/\.*' -or -path '*/_*' \) -type d -exec mkdir -p "$DST_CERTS_DIR/{}" \;
#Copy the certifications.
find ./* -not \( -path '*/\.*' -or -path '*/_*' \) -type f -exec cp {} "$DST_CERTS_DIR/{}" \;

#Change the directory to ease the paths manipulation.
cd $DST_CERTS_DIR;
find . -iname "*.pdf" -exec bash -c "helper \"{}\"" \;

#####
#Change the directory to ease the paths manipulation.
cd $SITE_ROOT_DIR;

echo -e "---\n\
layout: page\n\
title: Certs\n\
permalink: /Certs/\n\
---\n" > certs.md

echo "NOTICE - THIS PAGE IS SCRIPT GENERATED..." >> certs.md
echo "AND THE SCRIPT IS A __WIP__ YET :)" >> certs.md

find certs -iname "*.jpg" | sort > temp.txt;
CURRENT_NAME="INVALID";
while read line ; do
    PROVIDER=$(echo $line | cut -d \/ -f 2);
    CERTNAME=$(echo $line | cut -d \/ -f 3 | cut -d \. -f 1 | cut -d - -f2);
    CERTURL=$(url-encode "$line");

    # #Check if the Cert Provider changed 
    # #and then add a section title for it.
    if [ $CURRENT_NAME != $PROVIDER ]; then
        CURRENT_NAME=$PROVIDER;
        echo -e "\n### $CURRENT_NAME" >> certs.md
    fi;
    echo "* [$CERTNAME](../$CERTURL)" >> certs.md
    
done < temp.txt;

rm temp.txt
