class nagios_install::core 
{
$bin="nagios-4.1.1.tar.gz"
      file { '/opt/software/nagios/':
                        ensure => 'directory',
                        mode   => '0750',
                }->

       /*
       exec{"yum php":
                         cwd=>'/opt/software/nagios',
                       command=>'yum install php',
                        path=>['/usr/bin','/usr/sbin',],
        }
	 exec{"yum httpd":
                         cwd=>'/opt/software/nagios',
                       command=>'yum install httpd*',
                        path=>['/usr/bin','/usr/sbin',],
        }
	 exec{"yum gcc":
                         cwd=>'/opt/software/nagios',
                       command=>'yum install gcc glibc glibc-common gd gd-devel make net-snmp openssl-devel xinetd unzip',
                        path=>['/usr/bin','/usr/sbin',],
        }*/
	
	group{"nagcmd":
		ensure=>"present",
		}->

	user{"nagios":
                        ensure=>"present",
                        groups=>"nagcmd",
                        shell=>'/bin/bash',
                        home=>'/home/nagios',
                        managehome=>true,
                        }->
	
	exec{"usermod":
                         cwd=>'/opt/software/nagios',
                       command=>'usermod -a -G nagcmd nagios',
                        path=>['/usr/bin','/usr/sbin',],
        }->
       
	file{"$bin":
                        path =>"/opt/software/nagios/$bin",
                        source=>"puppet:///modules/nagios_install/$bin",
                        ensure=>present,
                        mode=>755,
		}->
	
	exec{"untar":
                         cwd=>'/opt/software/nagios',
                       command=>'tar -xzf nagios-4.1.1.tar.gz',
                        path=>['/usr/bin','/usr/sbin',],
        }->

	exec{"./configure":
                         cwd=>'/opt/software/nagios/nagios-4.1.1',
                       command=>'./configure --with-command-group=nagcmd',
                        path=>['/usr/bin','/usr/sbin','/opt/software/nagios/nagios-4.1.1',],
        }->

	exec{"makeall":
                         cwd=>'/opt/software/nagios/nagios-4.1.1',
                       command=>'make all',
                        path=>['/usr/bin','/bin','/sbin','/usr/sbin','/opt/software/nagios/nagios-4.1.1',],
        }->

	exec{"makeinstall":
                         cwd=>'/opt/software/nagios/nagios-4.1.1',
                       command=>'make install',
                        path=>['/usr/bin','/bin','/sbin','/usr/sbin','/opt/software/nagios/nagios-4.1.1',],
        }->

	exec{"makeinstall_commandmode":
                         cwd=>'/opt/software/nagios/nagios-4.1.1',
                       command=>'make install-commandmode',
                        path=>['/usr/bin','/bin','/sbin','/usr/sbin','/opt/software/nagios/nagios-4.1.1',],
        }->

	exec{"makeinstall_init":
                         cwd=>'/opt/software/nagios/nagios-4.1.1',
                       command=>'make install-init',
                        path=>['/usr/bin','/bin','/sbin','/usr/sbin','/opt/software/nagios/nagios-4.1.1',],
        }->

	exec{"makeinstall_config":
                         cwd=>'/opt/software/nagios/nagios-4.1.1',
                       command=>'make install-config',
                        path=>['/usr/bin','/bin','/sbin','/usr/sbin','/opt/software/nagios/nagios-4.1.1'],
        }->

	exec{"makeinstall_webconf":
                         cwd=>'/opt/software/nagios/nagios-4.1.1',
                       command=>'make install-webconf',
                        path=>['/usr/bin','/bin','/sbin','/usr/sbin','/opt/software/nagios/nagios-4.1.1',],
        }->

	exec{"usermode":
                         cwd=>'/opt/software/nagios/nagios-4.1.1',
                       command=>'usermod -G nagcmd apache',
                        path=>['/usr/bin','/usr/sbin',],
        }


}

