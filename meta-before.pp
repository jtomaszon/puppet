package { 'postfix':
  ensure		=> present,
  allow_virtual		=> true,
}

host { "$fqdn":
  ensure 		=> present,
  ip			=> "$ipaddress",
  host_aliases		=> "$hostname",
  before		=> Package['postfix'],
}

file { 'hostname':
  path	  => '/etc/hostname',
  ensure  => present,
  owner   => 'root',
  group   => 'root',
  mode	  => 0644,
  content => "$fqdn",
  before  => Host["$fqdn"],
} 

file { 'mailname': 
  path	  => '/etc/mailname',
  ensure  => present,
  owner   => root,
  group   => root,
  mode    => 0644,
  content => "$fqdn",
  before  => File['hostname'],
}

service { 'postfix':
  ensure		=> running,
  require		=> 
			[ 
				File["/etc/hostname"], 
				File["/etc/mailname"]
			],
}
