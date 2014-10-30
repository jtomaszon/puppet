package { 'postfix':
  ensure		=> installed,
  allow_virtual		=> true
}

file { 'main.cf':
  path			=> '/etc/postfix/main.cf',
  ensure		=> present,
  owner			=> 'postfix',
  group			=> 'postfix',
  mode			=> 0644,
  source		=> '/root/puppet/files/postfix/main.cf',
  require		=> Package['postfix'],
}

service { 'postfix':
  ensure		=> running,
  enable		=> true,
  subscribe		=> File['main.cf'],
}
