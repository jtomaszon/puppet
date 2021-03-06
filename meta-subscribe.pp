file { 'main.cf':
  path		=> '/etc/postfix/main.cf',
  ensure	=> present,
  owner		=> 'postfix',
  group		=> 'postfix',
  mode		=> 0644,
  source	=> '/root/puppet/files/postfix/main.cf'
}

service { 'postfix':
  ensure	=> running,
  subscribe	=> File['main.cf'],
}
