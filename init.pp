class  git_install {
        $var="git_dep.tar.gz"
        Exec {
                path => ['/bin','/sbin/','/usr/bin/','/usr/sbin/'],
        }

        file { "/opt/software/${var}":
                 path => "/opt/software/${var}",
                 source => "puppet:///modules/git_install/${var}",
                 ensure => "present",
                 owner => root,
                 mode => 777,
                 }
        exec { "git1":
                cwd => "/opt/software/",
                 path => ['/bin','/sbin/','/usr/bin/','/usr/sbin/'],
                command => "tar -xzvf ${var}",
                require => File["/opt/software/${var}"],
             }
        exec { "git2":
                cwd => "/opt/software/",
                command => "yum localinstall *.rpm",
                require => Exec["git1"],
             }
}

