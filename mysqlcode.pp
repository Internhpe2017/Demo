class mysql_install::mysqlcode
{
$bin="mysql-community-client-5.6.35-2.el7.x86_64.rpm"
$bin2="mysql-community-common-5.6.35-2.el7.x86_64.rpm"
$bin3="mysql-community-libs-5.6.35-2.el7.x86_64.rpm"
$bin4="mysql-community-server-5.6.35-2.el7.x86_64.rpm"
/*file {"/tmp/mysql.tar.gz":
ensure => 'file',
source =>'puppet:///modules/mysql/mysql.tar.gz',
}*/
 
/**
	exec {"remove-postfix":
		path => ["/usr/sbin/","/usr/bin/"],
		command => "rpm -e postfix-2.10.1-6.el7.x86_64",
		}


	exec {"remove-maria":
		path => ["/usr/sbin/","/usr/bin/"],
		command => "rpm -e mariadb-libs-5.5.44-2.el7.centos.x86_64",
		}
**/

	        file { '/opt/software/mysql/':
                        ensure => 'directory',
                        mode   => '0750',
                }

		 file{"$bin":
                        path =>"/opt/software/mysql/$bin",
                        source=>"puppet:///modules/mysql_install/$bin",
                        ensure=>present,
                        mode=>755,
       		 }

		file{"$bin2":
                        path =>"/opt/software/mysql/$bin2",
                        source=>"puppet:///modules/mysql_install/$bin2",
                        ensure=>present,
                        mode=>755,
                 }

		file{"$bin3":
                        path =>"/opt/software/mysql/$bin3",
                        source=>"puppet:///modules/mysql_install/$bin3",
                        ensure=>present,
                        mode=>755,
                 }
		file{"$bin4":
                        path =>"/opt/software/mysql/$bin4",
                        source=>"puppet:///modules/mysql_install/$bin4",
                        ensure=>present,
                        mode=>755,
                 }

		exec{"installing":
                        cwd=>'/opt/software/mysql/',
                        command=>'yum localinstall *.rpm -y -y',
                        path=>['/usr/bin/','/usr/sbin/',],
        }



/*exec {"untar":
require => File["/tmp/mysql.tar.gz"],
path => ["/usr/sbin/","/usr/bin/"],
cwd =>'/tmp/',
command => "tar -xzf mysql.tar.gz",
}*/

/*exec {"installing":
require => Exec["untar"],
path => ["/usr/sbin/","/usr/bin/"],
cwd => '/tmp/mysql/',
command => "yum localinstall -y nogpgcheck *.rpm",
}*/

service {'mysqld':
require => Exec["installing"],
start => "service mysqld start",
ensure => 'running',
}

file {'/tmp/my.sh':
require => Service["mysqld"],
ensure => 'file',
source => 'puppet:///modules/mysql_install/my.sh',
mode => '0755',
}

exec {"script":
require => File["/tmp/my.sh"],
path => ["/usr/bin", "/usr/sbin/" , "/bin/bash/", "/bin/","/usr/local/bin/"],
command => "/tmp/my.sh",
}

}

