class nagios_install::nrpe 
{
require'nagios_install::nagplugins'
$bin="nrpe-2.15.tar.gz"

       
	file{"$bin":
                        path =>"/opt/software/nagios/$bin",
                        source=>"puppet:///modules/nagios_install/$bin",
                        ensure=>present,
                        mode=>755,
		}->
	
	exec{"untar1":
                         cwd=>'/opt/software/nagios',
                       command=>'tar -xzf nrpe-2.15.tar.gz',
                        path=>['/usr/bin','/usr/sbin',],
        }->

	exec{"./configure1":
                         cwd=>'/opt/software/nagios/nrpe-2.15',
                       command=>'./configure --enable-command-args --with-nagios-user=nagios --with-nagios-group=nagios --with-ssl=/usr/bin/openssl --with-ssl-lib=/usr/lib/x86_64-linux-gnu',
                        path=>['/usr/bin','/usr/sbin','/opt/software/nagios/nrpe-2.15',],
        }->

	exec{"makeall1":
                         cwd=>'/opt/software/nagios/nrpe-2.15',
                       command=>'make all',
                        path=>['/usr/bin','/bin','/sbin','/usr/sbin','/opt/software/nagios/nrpe-2.15',],
        }->

	exec{"makeinstall1":
                         cwd=>'/opt/software/nagios/nrpe-2.15',
                       command=>'make install',
                        path=>['/usr/bin','/bin','/sbin','/usr/sbin','/opt/software/nagios/nrpe-2.15',],
        }->

	exec{"makeinstall_xinetd1":
                         cwd=>'/opt/software/nagios/nrpe-2.15',
                       command=>'make install-xinetd',
                        path=>['/usr/bin','/bin','/sbin','/usr/sbin','/opt/software/nagios/nrpe-2.15',],
        }->

	exec{"makeinstall_daemonconf1":
                         cwd=>'/opt/software/nagios/nrpe-2.15',
                       command=>'make install-daemon-config',
                        path=>['/usr/bin','/bin','/sbin','/usr/sbin','/opt/software/nagios/nrpe-2.15',],
        }



}

