class nagios_install::core 
{
$nag_tar=hiera('nagios','no data')
$path=hiera('soft_path','no data')
$nag_path=hiera('nag_path','no data')
      file { '/opt/software/nagios/':
                        ensure => 'directory',
                        mode   => '0750',
	#		path => '${path}'
                }->

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
                         cwd=>"${path}/nagios",
                       command=>'usermod -a -G nagcmd nagios',
                        path=>['/usr/bin','/usr/sbin',],
        }->
       
	file{"$nag_tar":
                        path =>"${path}/nagios/${nag_tar}",
                        source=>"puppet:///modules/nagios_install/${nag_tar}",
                        ensure=>present,
                        mode=>755,
		}->
	
	exec{"untar":
                         cwd=>"${path}/nagios",
                       command=>'tar -xzf nagios-4.1.1.tar.gz',
                        path=>['/usr/bin','/usr/sbin',],
        }->

	exec{"./configure":
                         cwd=>"${path}/${nag_path}",
                       command=>'./configure --with-command-group=nagcmd',
                        path=>['/usr/bin','/usr/sbin',"${path}/${nag_path}",],
        }->


	exec{"makeall":
                         cwd=>"${path}/${nag_path}",
                       command=>'make all',
                        path=>['/usr/bin','/bin','/sbin','/usr/sbin','${path}/${nag_path}',],
        }->

	exec{"makeinstall":
                         cwd=>"${path}/${nag_path}",
                       command=>'make install',
                        path=>['/usr/bin','/bin','/sbin','/usr/sbin','${path}/${nag_path}',],
        }->

	exec{"makeinstall_commandmode":
                         cwd=>"${path}/${nag_path}",
                       command=>'make install-commandmode',
                        path=>['/usr/bin','/bin','/sbin','/usr/sbin','${path}/${nag_path}',],
        }->

	exec{"makeinstall_init":
                         cwd=>"${path}/${nag_path}",
                       command=>'make install-init',
                        path=>['/usr/bin','/bin','/sbin','/usr/sbin','${path}/${nag_path}',],
        }->

	exec{"makeinstall_config":
                         cwd=>"${path}/${nag_path}",
                       command=>'make install-config',
                        path=>['/usr/bin','/bin','/sbin','/usr/sbin','${path}/${nag_path}'],
        }->

	exec{"makeinstall_webconf":
                         cwd=>"${path}/${nag_path}",
                       command=>'make install-webconf',
                        path=>['/usr/bin','/bin','/sbin','/usr/sbin','${path}/${nag_path}',],
        }->

	exec{"usermode":
                         cwd=>"${path}/${nag_path}",
                       command=>'usermod -G nagcmd apache',
                        path=>['/usr/bin','/usr/sbin',],
        }


}

