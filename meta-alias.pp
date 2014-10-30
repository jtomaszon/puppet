file { 'main.cf':
  path		=> '/etc/postfix/main.cf',
  source	=> '/root/puppet/files/postfix/main.cf',
  notify	=> Service['pfx'],
}

service { 'postfix':
  alias		=> 'pfx',
  ensure	=> running,
  enable	=> true,
}
