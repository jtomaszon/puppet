file { 'main.cf':
  path		=> '/etc/postfix/main.cf',
  source	=> '/root/puppet/files/postfix/main.cf',
  notify	=> Service['psf'],
}

package { 'postfix':
  ensure	=> present,
  allow_virtual => true,
}

service { 'postfix':
  alias		=> 'psf',
  ensure	=> running,
  enable	=> true,
  subscribe	=> File['main.cf'],
}
