package { 'apache2':
  ensure         => 'installed',
  before => [ Exec ['site1'], Exec ['site2'] ],
  allow_virtual => true,
}
package { 'libapache2-mod-php5':
  ensure => 'installed',
  allow_virtual => true,
}
package { 'libapache2-mod-bw':
  ensure => 'installed',
  allow_virtual => true,
}
package { 'openssl':
  ensure => 'latest',
  allow_virtual => true,
}

host { 'intranet.dexter.com.br':
    ensure  => present,
    ip      => "$ipaddress",
}
host { 'www.dexter.com.br':
    ensure  => present,
    ip      => "$ipaddress",
}
service { 'apache2':
  ensure => 'running',
  enable => true,
  hasrestart => true,
  hasstatus => true,
  require => [ Package ['apache2'], Host ['intranet.dexter.com.br'], Host ['www.dexter.com.br'] ],
}
file { 'apache2.conf':
 path =>'/etc/apache2/apache2.conf',
 ensure => 'present', 
 owner => 'root',
 group => 'root',
 mode => 0644,
 source => '/root/puppet/files/apache/apache2.conf',
 require => Package['apache2'],
 notify  => Service['apache2'],
}
file { 'security.conf':
  path =>'/etc/apache2/conf-available/security.conf',
  ensure => 'present', 
  owner => 'root',
  group => 'root',
  mode => 0644,
  source => '/root/puppet/files/apache/security',
  require => Package['apache2'],
  notify  => Service['apache2'],
}
file { 'httpd.conf':
  path => '/etc/apache2/httpd.conf',
  ensure => 'present', 
  owner => 'root',
  group => 'root',
  mode => 0644,
  source => '/root/puppet/files/apache/httpd.conf',
  require => Package['apache2'],
  notify  => Service['apache2'],
}
file { 'php.ini':
  path => '/etc/php5/apache2/php.ini',
  ensure => 'present', 
  owner => 'root',
  group => 'root',
  mode => 0644,
  source => '/root/puppet/files/apache/php.ini',
  require => Package['libapache2-mod-php5'],
  notify => Service['apache2'],
}
file { 'intranet':
  path => '/etc/apache2/sites-available/intranet.conf',
  ensure => 'present', 
  owner => 'root',
  group => 'root',
  mode => 0644,
  source => '/root/puppet/files/apache/intranet',
  require => Package['apache2'],
  notify => Service['apache2'],
}
exec { 'tar zxvf /root/puppet/files/apache/intranet.tar.gz -C /srv/':
  path => '/usr/bin:/usr/sbin:/bin',
  unless => 'ls /srv/intranet/4linux.php',
  alias => 'site1',
  before => Exec['a2ensite intranet'],
}
exec { 'a2ensite intranet':
  path => '/usr/bin:/usr/sbin:/bin',
  require => File['intranet'],
  notify => Service['apache2'],
  unless => 'ls /etc/apache2/sites-enabled/intranet.conf',
}
exec { 'a2enmod bw':
  path => '/usr/bin:/usr/sbin:/bin',
  require => Package['apache2'],
  notify => Service['apache2'],
  unless => 'ls /etc/apache2/mods-enabled/bw.load',
}
exec { 'a2enmod php5':
  path => '/usr/bin:/usr/sbin:/bin',
  require => Package['apache2'],
  notify => Service['apache2'],
  unless => 'ls /etc/apache2/mods-enabled/php5.load',
}
exec { 'a2enconf security':
  path => '/usr/bin:/usr/sbin:/bin',
  require => Package['apache2'],
  notify => Service['apache2'],
  unless => 'ls /etc/apache2/conf-enabled/security.conf',
}


file { 'internet':
  path => '/etc/apache2/sites-available/internet.conf',
  ensure => 'present', 
  owner => 'root',
  group => 'root',
  mode => 0644,
  source => '/root/puppet/files/apache/internet',
  require => Package['apache2'],
  notify => Service['apache2'],
}

file { 'dexter.key':
  path => '/etc/ssl/dexter.key',
  ensure => 'present',
  owner => 'root',
  group => 'root',
  mode => 0644,
  source => '/root/puppet/files/apache/dexter.key', 
  require => Package['openssl'],
}

file { 'dexter.crt':
  path => '/etc/ssl/dexter.crt',
  ensure => 'present',
  owner => 'root',
  group => 'root',
  mode => 0644,
  source => '/root/puppet/files/apache/dexter.crt', 
  require => Package['openssl'],
}

exec { 'tar zxvf /root/puppet/files/apache/internet.tar.gz -C /srv/':
  path => '/usr/bin:/usr/sbin:/bin',
  unless => 'ls /srv/internet/index.php',
  alias => 'site2',
  before => Exec['a2ensite internet'],
}
exec { 'a2ensite internet':
  path => '/usr/bin:/usr/sbin:/bin',
  require => File['internet'],
  notify => Service['apache2'],
  unless => 'ls /etc/apache2/sites-enabled/internet.conf',
}
exec { "a2enmod ssl":
      path   => "/usr/bin:/usr/sbin:/bin",
      require => Package['apache2'],
      notify  => Service['apache2'],
      unless => 'ls /etc/apache2/mods-enabled/ssl.load',
}

exec { "a2enmod rewrite":
      path   => "/usr/bin:/usr/sbin:/bin",
      require => Package['apache2'],
      notify  => Service['apache2'],
      unless => 'ls /etc/apache2/mods-enabled/rewrite.load',
}


