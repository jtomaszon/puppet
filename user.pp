$user = 'deploy'

user { $user:
  ensure		=> present,
  home			=> "/home/$user",
  managehome		=> true,
  password		=> '$1$cPPWLDHw$MvISxeMG6H/1Y0QbmfRbc/',
  password_max_age	=> '99999',
  password_min_age	=> '0',
  shell			=> '/bin/bash',
}

file { 'home':
  path			=> "/home/$user",
  ensure		=> directory,
  owner			=> $user,
  group			=> $user,
  mode			=> 0700,
}
