:: a script that initiates the remote tunnel
::
:: make sure the targeted user is in the Remote Desktop User group
::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Script start

@echo off

set sshPre=ssh -R 55443:localhost:3389 
set /p sshEnd=Complete the ssh command: %sshPre%

echo starting ssh...
call :tunnelSSH
if %errorlevel% == 0 (
    echo.
) else (
    echo ...ssh connection failed!
    pause
    exit
)

echo creating Task...
call :createTask
if %errorlevel% == 0 (
    echo startup task created
) else (
    echo ...task not created.
    echo.
    echo You need to run this script as Administrator
    pause
    exit
)

echo ...done!
call :tunnelSSH
exit

:: Script End
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Functions

:tunnelSSH
    cmd /c %sshPre%%sshEnd% echo "Tunnel running. Close window or proceed to create scheduled task"; read
exit /b

:createTask
    schtasks /create /tn "rdp tunnel" /tr "%sshPre%%sshEnd%" /SC ONSTART /NP && schtasks /change /tn "rdp tunnel" /RI 1440 && echo task created
exit /b
    
