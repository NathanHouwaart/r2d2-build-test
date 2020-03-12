#!/bin/bash

#############################################################################
#
# .sh file for setting up the R2D2 build environment for Mac OS. 
# 
#   Make sure you make this file executable by running:
#       ---- sudo chmod +x install-mac.sh ----
# 
# Run this file with SUDO privileges
#
# Copyright (c) R2D2 leads 2020 (r2d2-leads@hu.nl)
# 
# Distributed under the Boost Software License, Version 1.0.
# (See accompanying file LICENSE_1_0.txt or copy at 
# http://www.boost.org/LICENSE_1_0.txt)
# 
#############################################################################

# Basic echo information to let the user know what this script does.
echo -e ' \t\t' 		    --- R2D2-install script ---
echo -------Make sure you run this script with SUDO privileges.--------
echo
echo This script will:
echo -e	'\t' 1. Set a systemvariable with the R2D2-Root folder.
echo -e '\t' 2. Set a systemvariable with the drive you have R2D2-Root on
echo && echo

# read -p will give the user a prompt with the text: Are you sure you wish yo continue? (Y/[N])?
# The user can then input a char which is stored in the variable REPLY. With a simple if
# statement the users input is checked.
# 
# If the users input is equal to Y or y execute the code.
read -p "Are you sure you wish yo continue? (Y/[N]): " -n 1 -r
echo 
if [[ $REPLY =~ ^[Yy]$ ]]
then

    echo setting R2D2-Root folder and setting R2D2-Root drive

    # The root directory of R2D2 is two directories up from this one. Store absolute path in variable R2D2_ROOT_DIR
    R2D2_ROOT_DIR=$(pwd)/../..
    R2D2_ROOT_DIR=$(cd $R2D2_ROOT_DIR && pwd)

    # In Mac, global environmental variables can be saved in the users .bash_profile.
    # Both the R2D2_ROOT_DIR and the R2D2_ROOT_DRIVE ( which is empty on unix systems ) 
    # are appended to the .bash_profile file.
    echo export R2D2_ROOT_DIR=\"$R2D2_ROOT_DIR\" >> ~/.bash_profile
    echo export R2D2_ROOT_DRIVE=\"\" >> ~/.bash_profile

    echo 
    echo 
    echo done
    echo log out and back in to apply the changes!
else
    echo script has not been executed
fi







