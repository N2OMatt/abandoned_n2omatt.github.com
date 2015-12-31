#!/bin/bash
##
## Author:  N2OMatt
## Date:    12 Dec 2015
## License: GPLv3
##
## This script will generate:
## 1) One page with all certifications (links) grouped by provider.
## 2) A page with the certification image and name - for each certification.
##

################################################################################
## Vars                                                                       ##
################################################################################
CURRENT_PATH=$(pwd)
SITE_ROOT_DIR_PATH=$CURRENT_PATH/..


################################################################################
## Script Initialization                                                      ##
################################################################################
echo "Generating images...";
./generate_images.sh
echo "Generating mds...";
./generate_mds.sh
echo "Generating list...";
./generate_list.sh
echo "done...";
