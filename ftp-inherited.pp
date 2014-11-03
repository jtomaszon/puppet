class ftp1 {
package { 'vsftpd':
  ensure => 'installed',  }
}
class ftp2 inherits ftp1 {
service { 'vsftpd':
  ensure => 'running',
  require => Package ['vsftpd'], }
}
class { 'ftp2': }

