class nagios_install::nagplugins 
{
require'nagios_install::core'
$plugin=hiera('nagios-plugin','no data')
$path=hiera('soft_path','no data')
       
	file{"$plugin":
                        path =>"${path}/nagios/${plugin}",
                        source=>"puppet:///modules/nagios_install/${plugin}",
                        ensure=>present,
                        mode=>755,
		}->
	
	exec{"untar2":
                         cwd=>"${path}/nagios",
                       command=>'tar -xzf nagios-plugins-2.2.0.tar.gz',
                        path=>['/usr/bin','/usr/sbin',],
        }->

	exec{"./configure2":
                         cwd=>"${path}/nagios/nagios-plugins-2.2.0",
                       command=>'./configure --with-nagios-user=nagios --with-nagios-group=nagios --with-openssl',
                        path=>['/usr/bin','/usr/sbin',"${path}/nagios/nagios-plugins-2.2.0",],
        }->

	exec{"make2":
                         cwd=>"${path}/nagios/nagios-plugins-2.2.0",
                       command=>'make',
                        path=>['/usr/bin','/bin','/sbin','/usr/sbin','${path}/nagios/nagios-plugins-2.2.0',],
        }->

	exec{"makeinstall2":
                         cwd=>"${path}/nagios/nagios-plugins-2.2.0",
                       command=>'make install',
                        path=>['/usr/bin','/bin','/sbin','/usr/sbin','${path}/nagios/nagios-plugins-2.2.0',],
        }



}

