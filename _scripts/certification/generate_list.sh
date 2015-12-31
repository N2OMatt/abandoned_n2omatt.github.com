#!/bin/bash
##
## Author:  N2OMatt
## Date:    Dec 31 2015
## License: GPLv3
##
## This script will scan the Certification directory and generate
## a list of certifications links.
##

################################################################################
## Vars                                                                       ##
################################################################################
SITE_ROOT_PATH=$(realpath $PWD/../..)
SOURCE_PATH=$SITE_ROOT_PATH/_mycerts
HTMLS_PATH=$SITE_ROOT_PATH/certs

################################################################################
## Functions                                                                  ##
################################################################################
url_encode()
{
    echo $(python -c "import sys, urllib as ul; \
    print ul.quote(\" \".join(sys.argv[1:]))" $1)
}

create_list()
{
    #Change the to the htmls directory to ease
    #the paths manipulation.
    cd $SOURCE_PATH;

    TEMP_FILENAMES_FILES=$SOURCE_PATH/temp.txt;
    OUTPUT_FILE="certs.md";

    #Save all certification filenames into temp file.
    find . -not \( -path '*/\.*' -or -path '*/_*' \) -iname "*.pdf" | \
    sort > $TEMP_FILENAMES_FILES;

    cd $SITE_ROOT_PATH;

    #Echo the Front-Matter.
    echo "---"                 > $OUTPUT_FILE;
    echo "layout: page"       >> $OUTPUT_FILE;
    echo "title: Certs"       >> $OUTPUT_FILE;
    echo "permalink: /certs/" >> $OUTPUT_FILE;
    echo "---"                >> $OUTPUT_FILE;


    CURRENT_PROVIDER_NAME="INVALID";
    while read LINE ; do
        #Get the name of provider.
        PROVIDER_NAME=$(echo $LINE | cut -d \/ -f 2);
        #Get the name of certification.
        #Remove path.
        #Remove extension.
        #Remove the date.
        CERTIFICATION_NAME=$(echo $LINE | cut -d \/ -f 3     \
                                        | cut -d \. -f 1     \
                                        | cut -d _  -f 4-100 );

        #Get the name of certification (whitespaced).
        WHITESPACED_NAME=$(echo $CERTIFICATION_NAME | sed s/_/" "/g);

        #Check if the provider changed and add a header for it.
        if [ $PROVIDER_NAME != $CURRENT_PROVIDER_NAME ]; then
            echo ""                  >> $OUTPUT_FILE;
            echo "## $PROVIDER_NAME" >> $OUTPUT_FILE;
            echo ""                  >> $OUTPUT_FILE;

            CURRENT_PROVIDER_NAME=$PROVIDER_NAME
        fi;

        ##Echo the Certification name (link).
        CERTIFICATION_URL=$(url_encode ./$CERTIFICATION_NAME.html)

        echo "* [$WHITESPACED_NAME]($CERTIFICATION_URL) "
        echo "* [$WHITESPACED_NAME]($CERTIFICATION_URL) " >> $OUTPUT_FILE;

    done < $TEMP_FILENAMES_FILES;
}

################################################################################
## Script Initialization                                                      ##
################################################################################
create_list
