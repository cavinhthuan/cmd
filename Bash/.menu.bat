@echo off
set "url=http://cavinhthuan.xyz/port"
cls
echo ----- Menu -----
echo 1. Run close_port.bat
echo 2. Run findFreePort.bat
echo ----------------
set /p choice=Choose an option (1 or 2): 

if "%choice%"=="1" (
    curl -o close_port.bat %url%/close_port.bat
    call close_port.bat
) else if "%choice%"=="2" (
    curl -o findFreePort.bat %url%/findFreePort.bat
    call findFreePort.bat
) else (
    echo Invalid choice.
)

pause
