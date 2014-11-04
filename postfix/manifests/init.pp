define  postfix ($myorigin, $myhostname) {
  package {'postfix': ensure => present, allow_virtual => true }
  file { 'main.cf':
    ensure => present,
    path => '/etc/postfix/main.cf',
    owner => 'root',
    group => 'root',
    mode => 0644,
    content => template('postfix/main.cf.erb'),
    notify => Service['postfix'],
    require => Package['postfix'],
  }
  service {'postfix':
    ensure => running,
    enable => true,
    require => [ Package['postfix'], File['main.cf'],]
  }

}
