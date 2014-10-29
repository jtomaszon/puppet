user { 'admin':
  ensure		=> 'present',
  gid			=> 'admin',
  home			=> '/home/admin',
  password		=> '$1$BsbCU3ZW$TH/o4P3G2lRS7ud1cJtza/',
  password_max_age	=> '99999',
  password_min_age	=> '0',
  shell			=> '/bin/bash',
  uid			=> '1050',
}
