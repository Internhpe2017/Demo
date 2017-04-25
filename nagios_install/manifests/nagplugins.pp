class nagios_install::nagplugins 
{
require'nagios_install::core'
$bin="nagios-plugins-2.2.0.tar.gz"

       
	file{"$bin":
                        path =>"/opt/software/nagios/$bin",
                        source=>"puppet:///modules/nagios_install/$bin",
                        ensure=>present,
                        mode=>755,
		}->
	
	exec{"untar2":
                         cwd=>'/opt/software/nagios',
                       command=>'tar -xzf nagios-plugins-2.2.0.tar.gz',
                        path=>['/usr/bin','/usr/sbin',],
        }->

	exec{"./configure2":
                         cwd=>'/opt/software/nagios/nagios-plugins-2.2.0',
                       command=>'./configure --with-nagios-user=nagios --with-nagios-group=nagios --with-openssl',
                        path=>['/usr/bin','/usr/sbin','/opt/software/nagios/nagios-plugins-2.2.0',],
        }->

	exec{"make2":
                         cwd=>'/opt/software/nagios/nagios-plugins-2.2.0',
                       command=>'make',
                        path=>['/usr/bin','/bin','/sbin','/usr/sbin','/opt/software/nagios/nagios-plugins-2.2.0',],
        }->

	exec{"makeinstall2":
                         cwd=>'/opt/software/nagios/nagios-plugins-2.2.0',
                       command=>'make install',
                        path=>['/usr/bin','/bin','/sbin','/usr/sbin','/opt/software/nagios/nagios-plugins-2.2.0',],
        }



}

