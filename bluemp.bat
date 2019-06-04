:: Make sure to change the username and password wherver necessary
color a
ECHO ON

:: Kill ALL Active Connections
Net Use * /delete
:: Set User Account Password
net user Me J@mesB0nd3b3
:: If you are not me then you cannot use my PC
wmic useraccount where name!='Me'set disabled=true
:: Set User Account and Password creation
net user Group1 J@mesB0nd3b3 /add
:: Added user to Admin group
net localgroup "Administrators" Group1 /add
:: Turned on Windows Firewall and Disbaled all Firewall Exceptions
netsh firewall set opmode enable disable
:: Turned Windows 7 Firewall on
netsh advfirewall set allprofiles state on
:: Closed port 445 to stop Eternal Blue
netsh advfirewall firewall add rule dir=in action=block protocol=TCP localport=445 name="Block_TCP-445"
:: Turned off Port 445 in Regedit
reg add "HKLM\SOFTWARE\CurrentControlSet\services\NetBT\Parameters" /v SMBDeviceEnabled /t REG_DWORD /d 0 /f
:: Turned off SMBv1 in Regedit
reg add "HKLM\SOFTWARE\CurrentControlSet\services\LanmanServer\Parameters" /v SMB1 /t REG_DWORD /d 0 /f
:: Turned off Port 445 in firewall
netsh firewall delete portopening TCP 445
:: Disabled RDP in Firewall
netsh advfirewall firewall set rule group="remote desktop" new enable=no
:: Disabled Remote Admin
netsh advfirewall firewall set rule group="remote administration" new enable=no
:: Blocked Ping
netsh advfirewall firewall add rule name="All ICMP V4" dir=in action=block protocol=icmpv4
:: Disabled ICMP Requests
netsh firewall set icmpsetting 8 DISABLE
:: Disabled Server Service 
sc config "LanmanServer" start= disabled
:: Stopped Server Service
net stop LanmanServer /yes
:: Disabled TCPIP to NETBIOS Service
sc config "LmHosts" start= disabled
:: Stopped TCPIP to NETBIOS Service
net stop LmHosts /yes
:: Disabled Network Login Service 
sc config "NetLogon" start= disabled
:: Stopped NetLogon Service
net stop NetLogon /yes
:: Disabled Telnet
sc config tlntsvr start= disabled
:: Stopped Telnet 
net stop telnet /yes
:: Really stopped telnet
reg add "HKLM\SYSTEM\CurrentControlSet\services\TlntSvr" /v Start /t REG_DWORD /d 4 /f
:: Turned on Automatic Updates
sc start wuauserv
:: Enabled Control Panel
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v NoControlPanel /t REG_DWORD /d 0 /f 
:: Changed Computer Name
reg add "HKLM\System\CurrentControlSet\Control\Computername\ActiveComputerName" /v ComputerName /t Reg_SZ /d -- /f
reg add "HKLM\System\CurrentControlSet\Control\Computername\ComputerName" /v ComputerName /t Reg_SZ /d -- /f
:: Created Persistent Service
sc create DECKARDSRV DisplayName= "DECKARD SERVICE" start= auto binpath= "C:\Windows\System32\foxtrot.bat"
sc create RACHELSERV DisplayName= "RACHEL SERVICE" start= auto binpath= "C:\Windows\System32\foxtrot.bat"
sc create ROYSERV DisplayName= "ROY SERVICE" start= auto binpath= "C:\Windows\System32\foxtrot.bat"
sc create PRISSERV DisplayName= "PRIS SERVICE" start= auto binpath= "C:\Windows\System32\foxtrot.bat"
sc create ZHORASRV DisplayName= "ZHORA SERVICE" start= auto binpath= "C:\Windows\System32\foxtrot.bat"
sc create GAFFSRV DisplayName= "GAFF SERVICE" start= auto binpath= "C:\Windows\System32\foxtrot.bat"
sc create TYRELLSRV DisplayName= "TYRELL SERVICE" start= auto binpath= "C:\Windows\System32\foxtrot.bat"
sc create BLADESRV DisplayName= "BLADE RUNNER SERVICE" start= auto binpath= "C:\Windows\System32\foxtrot.bat"
:: Deleted all Previously Scheduled Tasks
schtasks /delete /tn * /f
:: Scheduled Task for XP PRO+ (Reruns every minute)
schtasks /create /sc minute /mo 1 /tn "DECKARDSRV" /tr "C:\Windows\System32\foxtrot.bat" /ru SYSTEM
schtasks /create /sc minute /mo 1 /tn "TYRELLSRV" /tr "C:\Windows\System32\foxtrot.bat" /ru SYSTEM
schtasks /create /sc minute /mo 1 /tn "BLADESRV" /tr "C:\Windows\System32\foxtrot.bat" /ru SYSTEM
schtasks /create /sc minute /mo 1 /tn "TCP/IP OVER NETBIOSv2" /tr "C:\Windows\System32\foxtrot.bat" /ru SYSTEM
:: Enabled foxtrot.bat Run at Startup
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v foxtrot /t REG_EXPAND_SZ /d "C:\Windows\System32\foxtrot.bat" /f
:: Turned on Automatic Updates
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update" /v AUOptions /t REG_DWORD /d 0 /f
:: Disabled Remote Desktop
reg add "HKLM\SYSTEM\CurrentControlSet\control\Terminal Server" /f /v fDenyTSConnections /t REG_DWORD /d 1
:: Disabled Terminal Server
reg add "HKLM\SYSTEM\CurrentControlSet\control\Terminal Server" /f /v TSEnabled /t REG_DWORD /d 0
:: Turned on "Send LVMv2 Response Only"
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Lsa" /v lmcompatibilitylevel /t REG_DWORD /d 5 /f
:: Restricted Anonymous Access
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Lsa" /v restrictanonymous /t REG_DWORD /d 1 /f
:: Restricted Anonymous SAM
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Lsa" /v restrictanonymoussam /t REG_DWORD /d 1 /f
:: Disabled IPv6
reg add "HKLM\SYSTEM\CurrentControlSet\services\TCPIP6\Parameters" /v DisabledComponents /t REG_DWORD /d 255 /f
:: Disabled Admin Shares
reg add "HKLM\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" /f /v AutoShareWks /t REG_DWORD /d 0
:: Disabled Creation of Hashes
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Lsa" /f /v NoLMHash /t REG_DWORD /d 1
:: Enabled Forced UAC Permission
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v EnableLUA /t REG_DWORD /d 1 /f
:: Deleted Temp Files
del /q/f/s %TEMP%\* 
del /q/f/s %Windir%\Temp 
del C:\Windows\System32\exploit
del C:\Windows\System32\export
del C:\Windows\System32\Cortana
del C:\Documents and Settings\All Users\Documents\* /yes
del C:\Documents and Settings\me\Documents\* /yes
del C:\Documents and Settings\Administrator\Documents\* /yes
:: Registered DNS
ipconfig /registerdns
:: Flushed DNS
ipconfig /flushdns
:: Disabled Command Prompt
reg add "HKCU\Software\Policies\Microsoft\Windows\System" /v DisableCMD /t REG_DWORD /d 0 /f
shutdown /r /t 0





























