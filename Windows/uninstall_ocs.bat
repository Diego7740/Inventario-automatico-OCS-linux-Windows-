@echo off

sc stop "OCS Inventory Service" >nul 2>&1
timeout /t 5 >nul

IF EXIST "C:\Program Files\OCS Inventory Agent\uninst.exe" ("C:\Program Files\OCS Inventory Agent\uninst.exe" /S)

rmdir /s /q "C:\Program Files\OCS Inventory Agent" 2>nul

sc delete "OCS Inventory Service" >nul 2>&1

schtask /delete /tn "OCS Inventory Agent" /f >nul 2>&1

exit /b 0
