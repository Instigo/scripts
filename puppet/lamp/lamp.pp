# execute 'apt-get update'
exec { 'apt-update':                     # resource to execute
    command => '/usr/bin/apt-get update' # command to run
}

# install apache2 package
package { 'apache2':
    require => Exec['apt-update'],  # require 'apt-update'
    ensure => installed,
}

# ensure apache2 service is running
service { 'apache2':
    ensure => running,
}

# install mysql-server package
package { 'mysql-server':
    require => Exec['apt-update'],  # require 'apt-udpate' before installation
    ensure => installed,
}

# ensure mysql service is running
service { 'mysql':
    ensure => running,
}

# install php5 package
package { 'php5':
    require => Exec['apt-update'],
}

# ensure info.php file exists
file { '/var/www/html/info.php':
    ensure => file,
    content => '<?php phpinfo(); ?>', # phpinfo code
    require => Package['apache2'],    # require apache2 package before creating
}
