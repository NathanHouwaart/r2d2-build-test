@echo off
cls


echo 		    --- R2D2-install script ---
echo -------Make sure you run this script in ADMINISTRATOR MODE.--------
echo.
echo This script will:
echo 	1. Update windows path variable to include make
echo 	2. Set a systemvariable with the R2D2-Root folder.
echo 	3. Set a systemvariable with the drive you have R2D2-Root on
echo. && echo.

:PROMPT
SET /P AREYOUSURE=Are you sure you wish yo continue? (Y/[N])?
IF /I "%AREYOUSURE%" NEQ "Y" GOTO END

CD /d %~dp0%..\..\programs\make
set INSTALL_PATH=%cd%
echo.
echo setting windows path variable
setx /M path "%path%;%INSTALL_PATH%
echo done

echo. && echo.
echo setting R2D2-Root folder

setlocal enabledelayedexpansion
CD /
set R2D2_ROOT_DRIVE=%cd%
set R2D2_ROOT_DRIVE=%R2D2_ROOT_DRIVE:\=%
setx /M R2D2_ROOT_DRIVE %R2D2_ROOT_DRIVE%


CD %~dp0%..\..
set R2D2_ROOT_FOLDER=%cd%
set R2D2_ROOT_FOLDER=!%R2D2_ROOT_FOLDER%
set R2D2_ROOT_FOLDER=%R2D2_ROOT_FOLDER:\=/%
setx /M R2D2_ROOT_DIR %R2D2_ROOT_FOLDER% 


endlocal
echo done

pause


:END
exit
