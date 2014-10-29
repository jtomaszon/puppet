file { 'link': 
  path		=> '/tmp/link',
  ensure	=> link,
  target	=> '/tmp/testfile',
}
