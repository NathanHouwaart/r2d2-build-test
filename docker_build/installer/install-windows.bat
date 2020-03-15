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

:: Start of the program, go to the check permissions label
GOTO CHECK_PERMISSIONS

:: This function will check the permissions of the .bat script. This script needs
:: to run with admin privileges. If the requirement is not met, it will jump to
:: the RETURN label
:CHECK_PERMISSIONS
    echo Administrative permissions required. Detecting permissions...

    net session >nul 2>&1
    if %errorLevel% == 0 (
        echo Success: Administrative permissions confirmed.
        GOTO START_SCREEN
    ) else (
        echo Failure: Current permissions inadequate.
        GOTO STOP
    )


:: START_SCREEN is the start of the pgorgam to let the user know what this script does.
:START_SCREEN

:: enabledelayedexpansion is needed in order to use variables that can change at runtime
:: Without this, variales can not be variable assigned. More information can be found here: https://ss64.com/nt/delayedexpansion.html
:: Variables with delayed expansion are indicated with '!'. Like -> !%R2D2_ROOT_FOLDER%
setlocal enabledelayedexpansion
setlocal enableextensions

:: if the user calls the script with like this: "install-windows.bat y"
:: the script will skip to the EXEC label. This is used for automatic confirmation
IF /I "%1" EQU "Y" GOTO EXEC

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
IF /I "%AREYOUSURE%" NEQ "Y" GOTO RETURN

:: Echo two blank lines and let user know what's up
:: What this code block does:
::  - Change directory to the root of the drive
::  - Assign the variable R2D2_ROOT_DRIVE to this root drive. E.g. 'C:/'
::  - Ignore the backslash '\'character
::  - Set a environment variable with setx called R2D2_ROOT_DRIVE with the root drive of R2D2
:EXEC
echo. && echo.

:: Depending on if the user is running on Windows 10 Pro or Home, the script will set slightly
:: different environment variables. This is because Windows 10 Home Docker is run with git bash
:: and therefore has a different sytle of Root Drive
:CHECK_WINDOWS_VERSION
for /f "tokens=1,2* delims=: " %%i in (
  'systeminfo ^|  findstr /B /C:"OS Name" /C:"OS Version"'
) do set "%%i_%%j=%%k"

if "%OS_Name%"=="Microsoft Windows 10 Home" (
    set R2D2_ROOT_DRIVE_VM=/c
    set R2D2_ROOT_DRIVE=%~d0%
) else (
    set R2D2_ROOT_DRIVE_VM=%~d0%
    set R2D2_ROOT_DRIVE=%~d0%
)

:: Set environmental variables
setx /M R2D2_ROOT_DRIVE %R2D2_ROOT_DRIVE%
setx /M R2D2_ROOT_DRIVE_VM "%R2D2_ROOT_DRIVE_VM%"

echo setting R2D2-Root drive to: %R2D2_ROOT_DRIVE%
echo setting R2D2-Root-VM drive to: %R2D2_ROOT_DRIVE_VM%


:: Echo two blank lines and let user know what's up
:: What this code block does:
::  - Change directory to the root of the R2D2 folder (%~dp0% is a static variable of the location of the .bat file)
::  - Assign the variable R2D2_ROOT_FOLDER to this root folder. E.g. 'D:\User\r2d2-build-test\'
::  - Replace backslash '\'characters with forward slash characters '/'
::  - Set a environment variable with setx called R2D2_ROOT_DIR with the root folder of R2D2
echo.
CD /d %~dp0%..\.. 
set R2D2_ROOT_FOLDER=!%cd%
set R2D2_ROOT_FOLDER=!%R2D2_ROOT_FOLDER%
set R2D2_ROOT_FOLDER=%R2D2_ROOT_FOLDER:\=/%
setx /M R2D2_ROOT_DIR "%R2D2_ROOT_FOLDER%" 
echo setting R2D2-Root folder to: !%R2D2_ROOT_FOLDER%

echo.
:: Echo two blank lines and let user know what's up
:: What this code block does:
::  - Change directory to the Windows 10 make application folder
::  - Assign the variable MAKE_INSTALL_PATH to this folder. E.g. 'D:\User\r2d2-build-test\programs\make'
::  - cdAdd MAKE_INSTALL_PATH to the global PATH variable in order to call make from anywhere in the terminal
CD %~dp0%..\..\programs\make
set MAKE_INSTALL_PATH=%cd%
setx /M path "%path%;%MAKE_INSTALL_PATH%
echo setting windows path variable for make to: %MAKE_INSTALL_PATH%


endlocal
echo. && echo.
echo done
echo.

IF /I "%1" EQU "Y" GOTO RETURN

echo log out and back in to apply the changes!
echo.
echo.

:: Pause the screen and wait for user to press a key, that way rhe user can read through the script output
:STOP
pause

:RETURN