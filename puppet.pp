$url = "http://apt.puppetlabs.com/puppetlabs-release-trusty.deb"
$tmpFile = "/tmp/puppetlabs-release-trusty.deb"

exec { 'puppet-release': 
  command => "/usr/bin/wget $url -qO $tmpFile && /usr/bin/dpkg -i $tmpFile",
  unless => '/bin/ls /etc/apt/sources.list.d/puppetlabs.list',
}	

exec { "aptitude update":
  alias	=> 'apt-udp',
  command => "/usr/bin/aptitude update",
  require => Exec['puppet-release'],
  onlyif => "/bin/sh -c '[ ! -f /var/cache/apt/pkgcache.bin ] || /usr/bin/find /etc/apt/* -cnewer /var/cache/apt/pkgcache.bin | /bin/grep . > /dev/null'",
}

package { 'puppet':
  ensure => latest,
  require => Exec['apt-udp'],
}

file { 'puppet.conf':
  path			=> '/etc/puppet/puppet.conf',
  source		=> '/root/puppet/files/puppet/puppet.conf',
  require		=> Package['puppet'],
}
