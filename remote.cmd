:: auto connection : planned tasks as adminstrator. make sure ssh tunnel works
::


:: option 1 : connection via pw-protected (standard) user
::            add standard-user to remote users
::
:: option 2 : allow connections w/o pw
::

:: Test ssh tunnel
ssh -R 55443:localhost:3389 username@server.com printf "\nssh connection works!" || (echo && echo ssh connection failed && pause && exit)

:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Script start

@echo off

set sshPre=ssh -R 55443:localhost:3389 
set /p sshEnd=Complete the ssh command: %sshPre%

call :testSSH
if %errorlevel% == 0 (
    echo ssh works
) else (
    echo ssh connection failed!
    pause
    exit
)

call :createTask
if %errorlevel% == 0 (
    echo startup task created
) else (
    echo You need to run this script as Administrator
    pause
    exit
)

pause

:: Script End
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Functions

:testSSH
    cmd /c %sshPre%%sshEnd% echo connected
exit /b

:createTask
    schtasks /create /tn "rdp tunnel" /tr %sshPre%%sshEnd% /SC ONSTART && schtasks /change /tn "rdp tunnel" /RI 1440
exit /b
    
