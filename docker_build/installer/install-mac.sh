#!/bin/bash

#############################################################################
#
# .sh file for setting up the R2D2 build environment for Mac OS. 
# 
#   Make sure you make this file executable by running:
#       ---- chmod +x install-mac.sh ----
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
echo
echo This script will:
echo -e	'\t' 1. Set a systemvariable with the R2D2-Root folder.
echo -e '\t' 2. Set a systemvariable with the drive you have R2D2-Root on
echo && echo


source ~/.bash_profile
if [[ -z $R2D2_ROOT_DIR ]]; then

  # If the users input is equal to Y or y execute the code.
  read -p "Are you sure you wish you continue? (Y/[N]): " -n 1 -r
  echo
  if [[ $REPLY =~ ^[Yy]$ ]]
  then

      echo setting R2D2-Root folder and setting R2D2-Root drive

      # The root directory of R2D2 is two directories up from this one. Store absolute path in variable R2D2_ROOT_DIR
      R2D2_ROOT_DIR=$(pwd)/../..
      R2D2_ROOT_DIR=$(cd $R2D2_ROOT_DIR && pwd)

      # In Linux, global environmental variables can be saved in the file /etc/environment
      # Both the R2D2_ROOT_DIR and the R2D2_ROOT_DRIVE ( which is empty on unix systems )
      # are appended to the /etc/environment file.

      echo >> ~/.bashrc
      echo export R2D2_ROOT_DIR=\"$R2D2_ROOT_DIR\" >> ~/.bash_profile
      echo export R2D2_ROOT_DRIVE=\"\" >> ~/.bash_profile
      echo export R2D2_ROOT_DRIVE_VM=\"\" >> ~/.bash_profile

      echo
      echo
      echo done
      echo log out and back in to apply the changes!
  else
      echo script has not been executed
  fi

else
    echo script has not been executed
  echo "Not executing script; environment variables have already been set!"
fi








