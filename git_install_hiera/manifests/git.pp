class git_install::git {
             
             $var=hiera('git_tar','not found')
             notice("tar file is :${var}:")
              $soft_path=hiera('soft_path')
                    
        Exec{
            path=>["/usr/bin","/bin","/usr/sbin","/opt/software/git-2.12.0",]
        }


                file { "${soft_path}/${var}":
                ensure => "present",
                source => "puppet:///modules/git_install/${var}",
                owner => root,
                mode => 755
                     }->
                exec { "git_files untar" :
                cwd => "${soft_path}",
                command => "tar -xzf ${var}",
                }->
                exec { "configure" :
                cwd => "${soft_path}/git-2.12.0",
                command => "make configure",
                }->
		exec { "configure2" :
                cwd => "${soft_path}/git-2.12.0",
                command => "./configure --prefix=/usr/local",
                }->
		exec { "makeinstall" :
                cwd => "${soft_path}/git-2.12.0",
                command => "make install",
                }


}
