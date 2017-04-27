class tomcat_install::tomcat_dependencies {
	
	require 'tomcat_install::tomcat'

          $var=hiera('tomi_tar','not found')
          notice("the tar file is :${var}:")
           $soft_path=hiera('soft_path')

        Exec{
            path=>["/usr/bin","/bin","/usr/sbin"]
        }


                file { "${soft_path}/${var}":
                ensure => "present",
                source => "puppet:///modules/tomcat_install/${var}",
                owner => root,
                mode => 755
                     }->
                exec { "tomcat-dependencies untar" :
                cwd => "${soft_path}",
                command => "tar -xzf ${var}",
                }->
                exec { "tomcat-dependencies localinstall" :
                cwd => "${soft_path}/tomcat-web-interface",
                command => "yum localinstall *.rpm -y",
                }->
		file { "changing port":
		path => "/etc/tomcat/server.xml",
		content => template("tomcat_install/server.xml"),
		owner => "root",
		group => "tomcat",
		mode => 644,
		}->
		file { "users xml file":
                path => "/etc/tomcat/tomcat-users.xml",
                content => template("tomcat_install/tomcat-users.xml"),
                owner => "root",
		group => "tomcat",
		mode => 640,
		}->
		exec { "starting tomcat service" :
		command => "service tomcat start",
		}

}
