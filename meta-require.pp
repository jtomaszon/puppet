file { '/opt/puppet':
  ensure		=> directory,
}

file { '/opt/puppet/helloworld':
  ensure		=> present,
  mode			=> 755,
  require		=> File['/opt/puppet'],
  content		=> "This is test file\n",
}
