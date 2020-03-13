@echo off

setlocal enabledelayedexpansion

for /f "tokens=1,2* delims=: " %%i in (
  'systeminfo ^|  findstr /B /C:"OS Name" /C:"OS Version"'
) do set "%%i_%%j=%%k"


echo %OS_Name%


endlocal

pause