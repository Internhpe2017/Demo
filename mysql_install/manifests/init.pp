class mysql_install
{
$mysql_client_rpm=hiera('mysql_client_rpm')
$mysql_common_rpm=hiera('mysql_common_rpm')
$mysql_libs_rpm=hiera('mysql_libs_rpm')
$mysql_server_rpm=hiera('mysql_server_rpm')
$soft_path=hiera('soft_path')
$secure_sh=hiera('secure_sh')
$mysql_tar=hiera('mysql_tar')

file {"${soft_path}mysql":
                        ensure => 'directory',
			mode => 0755,
                }
->

file{"${mysql_tar}":
                        path =>"${soft_path}mysql/${mysql_tar}",
                        source=>"puppet:///modules/mysql_install/${mysql_tar}",
                        ensure=>present,
                        mode=>755,
                 }
->
		exec {"untar":
			require => File["${soft_path}mysql/${mysql_tar}"],
			path => ["/usr/sbin/","/usr/bin/"],
			cwd =>"${soft_path}mysql",
			command => "tar -xzf ${mysql_tar}",
			}
->
/*                 file{"${soft_path}mysql/${mysql_client_rpm}":
                        #path =>"${soft_path}mysql/${mysql_client_rpm}",
                        #source=>"puppet:///modules/mysql_install/${mysql_client_rpm}",
                        ensure=>file,
                        mode=>755,
                 }
->
                file{"${soft_path}mysql/${mysql_common_rpm}":
                        #path =>"${soft_path}mysql/${mysql_common_rpm}",
                        #source=>"puppet:///modules/mysql_install/${mysql_common_rpm}",
                        ensure=>file,
                        mode=>755,
                 }
->
                file{"${soft_path}mysql/${mysql_libs_rpm}":
                        #path =>"${soft_path}mysql/${mysql_libs_rpm}",
                        #source=>"puppet:///modules/mysql_install/${mysql_libs_rpm}",
                        ensure=>file,
                        mode=>755,
                 }
->
		 file{"${soft_path}mysql/${mysql_server_rpm}":
                        #path =>"${soft_path}mysql/${mysql_server_rpm}",
                        #source=>"puppet:///modules/mysql_install/${mysql_server_rpm}",
                        ensure=>file,
                        mode=>755,
                 }
->*/
		 file {"${secure_sh}":
                path =>"${soft_path}mysql/${secure_sh}",
                source=>"puppet:///modules/mysql_install/${secure_sh}",
                ensure=>present,
                mode=>755,
                }
		exec{"installing":
                        cwd=>"${soft_path}mysql",
                        command=>"yum localinstall -y *.rpm",
                        path=>['/usr/bin/','/usr/sbin/'],
                 }

		service {'mysqld':
                require => Exec["installing"],
                start => "service mysqld start",
                ensure => 'running',
                }

     		exec {"script":
		require => File["${soft_path}mysql/${secure_sh}"],
		path => ["/usr/bin", "/usr/sbin/" , "/bin/bash/", "/bin/","/usr/local/bin/"],
		#cwd => "${soft_path}",
		command => "bash ${soft_path}mysql/${secure_sh}",
}
}
