#!/bin/bash
echo -e ' \t\t' 		    --- R2D2-install script ---
echo -------Make sure you run this script in ADMINISTRATOR MODE.--------
echo
echo This script will:
echo -e	'\t' 1. Set a systemvariable with the R2D2-Root folder.
echo -e '\t' 2. Set a systemvariable with the drive you have R2D2-Root on
echo && echo

read -p "Are you sure you wish yo continue? (Y/[N]): " -n 1 -r
echo 
if [[ $REPLY =~ ^[Yy]$ ]]
then
    echo setting R2D2-Root folder and setting R2D2-Root drive

    R2D2_ROOT_DIR=$(pwd)/../..
    R2D2_ROOT_DIR=$(cd $R2D2_ROOT_DIR && pwd)

    echo export R2D2_ROOT_DIR=\"$R2D2_ROOT_DIR\" >> ~/.bash_profile
    echo export R2D2_ROOT_DRIVE=\"\" >> ~/.bash_profile

    echo 
    echo 
    echo done
else
    echo script has not been executed
fi







