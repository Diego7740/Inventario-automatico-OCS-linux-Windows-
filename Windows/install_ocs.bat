@echo off

IF EXIST "C:\Program Files\OCS Inventory Agent\OCSInventory.exe" exit /b 0

copy "\\robotia.cl\SYSVOL\robotia.cl\scripts\OCS\OcsPackage.exe" "C:\Windows\Temp\" /Y

start /wait "" "C:\Windows\Temp\OcsPackage.exe" /S /DEFAULT_USER_DOMAIN

exit /b 0
