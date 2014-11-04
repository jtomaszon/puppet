class filial::ftp::server {

  package { 'vsftpd': ensure => installed, }
  service { 'vsftpd': ensure => running, require => Package['vsftpd'] }

}
class { 'filial::ftp::server': }
