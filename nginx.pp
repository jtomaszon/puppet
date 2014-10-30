file { 'debian_package':
  path => '/etc/apt/sources.list.d/nginx.list',
  content => 'deb http://ppa.launchpad.net/nginx/stable/ubuntu trusty main',
}

exec { "apt-key adv --keyserver keyserver.ubuntu.com --recv-keys C300EE8C":
  path => ["/bin", "/usr/bin", "/usr/sbin"],
  unless => 'apt-key list | grep C300EE8C',
}

exec { "aptitude update":
  alias => 'apt-udp',
  command => "/usr/bin/aptitude update",
  onlyif => "/bin/sh -c '[ ! -f /var/cache/apt/pkgcache.bin ] || /usr/bin/find /etc/apt/* -cnewer /var/cache/apt/pkgcache.bin | /bin/grep . > /dev/null'",
}

package { "nginx":
  ensure => latest,
  require => Exec['apt-udp'],
}
