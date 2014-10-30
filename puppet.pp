package { 'puppet':
  ensure		=> latest,
}

file { 'puppet.conf':
  path			=> '/etc/puppet/puppet.conf',
  source		=> '/root/puppet/files/puppet/puppet.conf',
  require		=> Package['puppet'],
}
