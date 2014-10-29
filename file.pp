file { 'testfile': 
  path			=> '/tmp/testfile',
  ensure		=> 'present',
  owner			=> 'admin',
  group			=> 'admin',
  mode			=> 0600,
  content		=> "Testing new features on Puppet\n",
}
