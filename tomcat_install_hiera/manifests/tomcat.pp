class tomcat_install::tomcat {
              
           $var=hiera('tom_tar','no file found')
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
                exec { "tomcat_files untar" :
                cwd => "${soft_path}",
                command => "tar -xzf ${var}",
                }->
                exec { "tomcat_rpm localinstall" :
                cwd => "${soft_path}/tomcat",
                command => "yum localinstall *.rpm -y",
                }

}

