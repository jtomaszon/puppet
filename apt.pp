file { 'sources.list':
  alias			=> 'sources',
  path			=> '/etc/apt/sources.list',
  ensure		=> present,
  source		=> '/root/infr-puppet/files/apt/sources.list',
  notify		=> Exec['apt-udp']
}

exec { 'aptitude update':
  alias			=> 'apt-udp',
  path			=> '/usr/bin',
  onlyif => "/bin/sh -c '[ ! -f /var/cache/apt/pkgcache.bin ] || /usr/bin/find /etc/apt/* -cnewer /var/cache/apt/pkgcache.bin | /bin/grep . > /dev/null'",
}
