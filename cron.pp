cron { 'cron-updatedb':
  ensure		=> present,
  user			=> 'root',
  command		=> '/usr/bin/updatedb',
  minute		=> 00,
}
