user { 'aluno':
  ensure           => present,
  managehome	   => true,
  password         => '$1$Q9uBc09P$9aJDPnbhXmReh.N/rZOJv.',
  password_max_age => '99999',
  password_min_age => '0',
  shell            => '/bin/bash',
}

package { 'vsftpd': 
  ensure        => installed, 
  allow_virtual => true,
}

file { 'vsftpd.conf': 
  path =>'/etc/vsftpd.conf', 
  ensure => present, 
  owner => 'root', 
  group => 'root', 
  mode => 0644, 
  source => '/root/puppet/files/vsftpd/vsftpd.conf', 
  notify => Service['vsftpd'],
} 

file { 'vsftpd.chroot_list': 
  path =>'/etc/vsftpd.chroot_list', 
  ensure => present, 
  owner => 'root', 
  group => 'root', 
  mode => 0644, 
  source => '/root/puppet/files/vsftpd/vsftpd.chroot_list', 
  notify => Service['vsftpd'],
} 

service { "vsftpd": 
  ensure => running, 
  enable => true, 
  hasrestart => true, 
  hasstatus => true, 
  require => Package ['vsftpd'],
} 
