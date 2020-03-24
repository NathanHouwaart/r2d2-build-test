#!/bin/bash

#############################################################################
#
# .sh file for setting up the R2D2 build environment for Linux. 
# 
#   Make sure you make this file executable by running:
#       ----  chmod +x install-linux.sh ----
#
# Copyright (c) R2D2 leads 2020 (r2d2-leads@hu.nl)
# 
# Distributed under the Boost Software License, Version 1.0.
# (See accompanying file LICENSE_1_0.txt or copy at 
# http://www.boost.org/LICENSE_1_0.txt)
# 
#############################################################################

echo -e ' \t\t' 		    --- R2D2-install script ---
echo
echo This script will:
echo -e	'\t' 1. Set a systemvariable with the R2D2-Root folder.
echo -e '\t' 2. Set a systemvariable with the drive you have R2D2-Root on
echo && echo

source ~/.bashrc
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

      # In Linux, environmental variables can be saved in the file ~/.bashrc
      # Both the R2D2_ROOT_DIR and the R2D2_ROOT_DRIVE ( which is empty on unix systems )
      # are appended to the ~/.bashrc file.

      echo >> ~/.bashrc
      echo export R2D2_ROOT_DIR=\"$R2D2_ROOT_DIR\" >> ~/.bashrc
      echo export R2D2_ROOT_DRIVE=\"\" >> ~/.bashrc
      echo export R2D2_ROOT_DRIVE_VM=\"\" >> ~/.bashrc

      if [ -f ~/.zshrc ] ; then # The existence of a .zshrc is considered to be adequate proof of zsh usage.
        echo Found zsh shell configuration, adding exports to .zshrc as well
        echo >> ~/.zshrc
        echo export R2D2_ROOT_DIR=\"$R2D2_ROOT_DIR\" >> ~/.zshrc
        echo export R2D2_ROOT_DRIVE=\"\" >> ~/.zshrc
        echo export R2D2_ROOT_DRIVE_VM=\"\" >> ~/.zshrc
      fi

      if [ -d ~/.config/fish ] && which fish > /dev/null ; then # Fish configuration exists, and the fish binary is available (as it is required for `set -Ux`).
        echo Found fish shell configuration, also adding setting environment variables to export universally
        fish -c "set -Ux R2D2_ROOT_DIR \"$R2D2_ROOT_DIR\""
        fish -c "set -Ux R2D2_ROOT_DRIVE \"\""
        fish -c "set -Ux R2D2_ROOT_DRIVE_VM \"\""
      fi

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

