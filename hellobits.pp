file { 'debian_package':
  path => '/etc/apt/sources.list.d/hellobits.list',
  content => 'deb [arch=amd64] http://apt.hellobits.com/ trusty main',
}

exec { "wget -q -O - http://apt.hellobits.com/hellobits.key | apt-key add -":
  path => ["/bin", "/usr/bin", "/usr/sbin"],
  unless => 'apt-key list | grep E7F5C236',
}

exec { "aptitude update":
  alias => 'apt-udp',
  command => "/usr/bin/aptitude update",
  onlyif => "/bin/sh -c '[ ! -f /var/cache/apt/pkgcache.bin ] || /usr/bin/find /etc/apt/* -cnewer /var/cache/apt/pkgcache.bin | /bin/grep . > /dev/null'",
}

exec { "aptitude purge ruby":
  alias => 'purge',
  command => "/usr/bin/aptitude purge ruby",
  before => Package['ruby-2.2'],
}

package { "ruby-2.2":
  ensure => latest,
  require => Exec['apt-udp'],
}
