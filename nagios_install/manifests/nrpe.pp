class nagios_install::nrpe 
{
require'nagios_install::nagplugins'
$nrpe=hiera('nrpe','no data')
$path=hiera('soft_path','no data')
$nrpe_path=hiera('nrpe_path','no data')       
	file{"$nrpe":
                        path =>"${path}/nagios/${nrpe}",
                        source=>"puppet:///modules/nagios_install/${nrpe}",
                        ensure=>present,
                        mode=>755,
		}->
	
	exec{"untar1":
                         cwd=>"${path}/nagios",
                       command=>'tar -xzf nrpe-2.15.tar.gz',
                        path=>['/usr/bin','/usr/sbin',],
        }->

	exec{"./configure1":
                         cwd=>"${path}/${nrpe_path}",
                       command=>'./configure --enable-command-args --with-nagios-user=nagios --with-nagios-group=nagios --with-ssl=/usr/bin/openssl --with-ssl-lib=/usr/lib/x86_64-linux-gnu',
                        path=>['/usr/bin','/usr/sbin',"${path}/${nrpe_path}",],
        }->

	exec{"makeall1":
                         cwd=>"${path}/${nrpe_path}",
                       command=>'make all',
                        path=>['/usr/bin','/bin','/sbin','/usr/sbin',"${path}/${nrpe_path}",],
        }->

	exec{"makeinstall1":
                         cwd=>"${path}/${nrpe_path}",
                       command=>'make install',
                        path=>['/usr/bin','/bin','/sbin','/usr/sbin',"${path}/${nrpe_path}",],
        }->

	exec{"makeinstall_xinetd1":
                         cwd=>"${path}/${nrpe_path}",
                       command=>'make install-xinetd',
                        path=>['/usr/bin','/bin','/sbin','/usr/sbin',"${path}/${nrpe_path}",],
        }->

	exec{"makeinstall_daemonconf1":
                         cwd=>"${path}/${nrpe_path}",
                       command=>'make install-daemon-config',
                        path=>['/usr/bin','/bin','/sbin','/usr/sbin',"${path}/${nrpe_path}",],
        }



}


