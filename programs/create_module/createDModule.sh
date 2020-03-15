#!/bin/bash
#Use this script to create a usable Docker module using the r2r2-build-test

#Add this script to your /usr/bin/ directory with executable rights to use.
#When used like this :'. createDModule' in a folder the cd command will work as well.

#This script requires that the r2d2-build-test/modules/ directory contains the test_module directory to use as a template.

function pause(){
   read -p "$*"
}

defaultname=${PWD##*/}
defaultdir=${R2D2_ROOT_DRIVE}${R2D2_ROOT_DIR}/modules/
echo $defaultdir

pause 'Press [Enter] key to continue...'

defaultport=/dev/ttyACM0

#Ask the user for a directory name and check if the $newdir variable is empty if it is use the name of the current directory.
read -p "New directory name (default = $defaultname):`echo $'\n> '`" newdir
if [[ -z "$newdir" ]]; then
	newdir=$defaultname
fi

#Ask the user for the Arduino DUE port and check if the $dueport variable is empty if it is use a default port
read -p "Arduino DUE port (default = $defaultport):`echo $'\n> '`" dueport
if [[ -z "$dueport" ]]; then
	dueport=$defaultport
fi

#Create the newpath.
newpath=$defaultdir$newdir
echo newpath

pause 'Press [Enter] key to continue...'

#Check if main.cpp exists in the current directory if it does start copying directories and editing the Makefile using the test_module directory.
if [[ -e "main.cpp" ]]; then
	cp -r ${defaultdir}test_module $newpath
	#If there is a headers directory copy its contents.
	if [[ -d "headers" ]]; then
		for file in headers/; do
			cp -r $file $newpath/code/headers/$file
		done
	fi
	#If there is a src directory copy its contents.
	if [[ -d "src" ]]; then
		for file in src/; do
			cp -r $file $newpath/code/src/$file
		done
	fi
	#Supress overwrite message since we always want to overwrite.
	yes | cp main.cpp $newpath/code/main.cpp > /dev/null 2>&1
	#Find and replace the MODULE_NAME value to ${newdir}
	sed -i "s|_NAME_|$newdir|g" $newpath/code/Makefile
	#Find and replace the SERIAL_PORT value to ${dueport}
	sed -i "s|_PORT_|$dueport|g" $newpath/code/Makefile
	cd $newpath/code
	echo "Finished!"
fi
