# RDP Tunnel

These scripts allow Windows Servers to be accessed via Remote Desktop, even the port is not acccessible from the internet.

A proxy linux server is necessary.

the remote.cmd (`ssh -R`) opens the rdp connection to the proxy (where it is now internally open), the terminal.cmd (`sssh -L`) connects a new port on the terminal to the port on the proxy.
