$package = "isc-dhcp-server"
$service = "isc-dhcp-server"

package { "$package":
  ensure        => installed, 
  allow_virtual => true,
}

file { 'dhcpd.conf': 
  path =>'/etc/dhcp/dhcpd.conf', 
  ensure => present, 
  owner => 'root', 
  group => 'root', 
  mode => 0644, 
  source => '/root/puppet/files/dhcpd/dhcpd.conf',
  require => Package [$package],
  notify => Service[$service],
} 

file { 'isc-dhcp-server': 
  path => '/etc/default/isc-dhcp-server', 
  ensure => present, 
  owner => 'root', 
  group => 'root', 
  mode => 0644, 
  source => '/root/puppet/files/dhcpd/isc-dhcp-server',
  require => Package [$package],
  notify => Service[$service],
} 

service { "$service": 
  ensure => running, 
  enable => true, 
  hasrestart => true, 
  hasstatus => true, 
  require => Package [$package],
}
