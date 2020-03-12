::############################################################################
::
:: .bat file for setting up the R2D2 build environment for Windows 10. Make
:: sure you run this in ADMINISTRATOR mode
:: 
:: Copyright (c) R2D2 leads 2020 (r2d2-leads@hu.nl)
:: 
:: Distributed under the Boost Software License, Version 1.0.
:: (See accompanying file LICENSE_1_0.txt or copy at 
:: http://www.boost.org/LICENSE_1_0.txt)
:: 
::############################################################################
@echo off
cls

:: enabledelayedexpansion is needed in order to use variables that can change at runtime
:: Without this, variales can not be variable assigned. More information can be found here: https://ss64.com/nt/delayedexpansion.html
:: Variables with delayed expansion are indicated with '!'. Like -> !%R2D2_ROOT_FOLDER%
setlocal enabledelayedexpansion

:: Basic echo information to let the user know what this script does.
echo 		    --- R2D2-install script ---
echo -------Make sure you run this script in ADMINISTRATOR MODE.--------
echo.
echo This script will:
echo 	1. Update windows path variable to include make
echo 	2. Set a systemvariable with the R2D2-Root folder.
echo 	3. Set a systemvariable with the drive you have R2D2-Root on
echo. && echo.

:: SET /P will give the user a prompt with the text: Are you sure you wish yo continue? (Y/[N])?
:: The user can then input a char which is stored in the variable AREYOUSURE. With a simple if
:: statement the users input is checked.
:: 
:: If the users input is anything but a Y or y, jump to the END label
::
SET /P AREYOUSURE=Are you sure you wish yo continue? (Y/[N])?
IF /I "%AREYOUSURE%" NEQ "Y" GOTO END

:: Echo two blank lines and let user know what's up
:: What this code block does:
::  - Change directory to the root of the drive
::  - Assign the variable R2D2_ROOT_DRIVE to this root drive. E.g. 'C:/'
::  - Ignore the backslash '\'character
::  - Set a environment variable with setx called R2D2_ROOT_DRIVE with the root drive of R2D2
echo. && echo.
CD /
set R2D2_ROOT_DRIVE=%cd%
set R2D2_ROOT_DRIVE=%R2D2_ROOT_DRIVE:\=%
setx /M R2D2_ROOT_DRIVE %R2D2_ROOT_DRIVE%
echo setting R2D2-Root drive to: %R2D2_ROOT_DRIVE%

:: Echo two blank lines and let user know what's up
:: What this code block does:
::  - Change directory to the root of the R2D2 folder (%~dp0% is a static variable of the location of the .bat file)
::  - Assign the variable R2D2_ROOT_FOLDER to this root folder. E.g. 'D:\User\r2d2-build-test\'
::  - Replace backslash '\'characters with forward slash characters '/'
::  - Set a environment variable with setx called R2D2_ROOT_DIR with the root folder of R2D2
echo. && echo.
CD %~dp0%..\..
set R2D2_ROOT_FOLDER=%cd%
set R2D2_ROOT_FOLDER=!%R2D2_ROOT_FOLDER%
set R2D2_ROOT_FOLDER=%R2D2_ROOT_FOLDER:\=/%
setx /M R2D2_ROOT_DIR %R2D2_ROOT_FOLDER% 
echo setting R2D2-Root folder to: %R2D2_ROOT_FOLDER% 

:: Echo two blank lines and let user know what's up
:: What this code block does:
::  - Change directory to the Windows 10 make application folder
::  - Assign the variable MAKE_INSTALL_PATH to this folder. E.g. 'D:\User\r2d2-build-test\programs\make'
::  - Add MAKE_INSTALL_PATH to the global PATH variable in order to call make from anywhere in the terminal
CD %~dp0%..\..\programs\make
set MAKE_INSTALL_PATH=%cd%
echo.
setx /M path "%path%;%MAKE_INSTALL_PATH%
echo setting windows path variable for make to: %MAKE_INSTALL_PATH%


endlocal

echo done

:: Pause the screen and wait for user to press a key, that way rhe user can read through the script output
pause

:END
exit
