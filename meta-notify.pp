file { 'source.list':
  path			=> '/etc/apt/sources.list',
  ensure		=> present,
  owner			=> 'root',
  group			=> 'root',
  source		=> '/root/puppet/files/etc/sources.list',
  notify		=> Exec['aptitude update'],
}

exec {'aptitude update':
  path			=> '/usr/bin:/usr/sbin:/bin',
  refreshonly		=> true,
}
