class nagios_install::nagconf 
{
require'nagios_install::nrpe'

	file{"nagios_conf":
                path=>"/etc/xinetd.d/nrpe",
                content=>template("nagios_install/nrpe"),
               
            }->

	file{"nagios_conf2":
                path=>"/usr/local/nagios/etc/nagios.cfg",
                content=>template("nagios_install/nagios.cfg"),

            }->
	 file { '/usr/local/nagios/etc/servers':
                        ensure => 'directory',
                        mode   => '0755',
                }->

	file {'/tmp/my.sh':
	
		ensure => 'file',
		source => 'puppet:///modules/nagios_install/my.sh',
		mode => '0755',
		}->

	exec {"script":
		require => File["/tmp/my.sh"],
		path => ["/usr/bin", "/usr/sbin/" , "/bin/bash/", "/bin/","/usr/local/bin/"],
		command => "/tmp/my.sh",
		}
	


}

