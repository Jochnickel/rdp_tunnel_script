:: auto connection : planned tasks as adminstrator. make sure ssh tunnel works
::


:: option 1 : connection via pw-protected (standard) user
::            add standard-user to remote users
::
:: option 2 : allow connections w/o pw
::

:: Test ssh tunnel
ssh -R 55443:localhost:3389 username@server.com printf "\nssh connection works!" || (echo && echo ssh connection failed && pause && exit)
