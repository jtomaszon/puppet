class app-ftp($packages=["htop", "elinks", "vsftpd"], $ftp_conf="/etc/vsftpd.conf") {
  package { $packages:
    ensure => 'installed'
  }
  file { 'vsftpd':
    path => $ftp_conf,
    ensure => 'present',
    mode   => 0644,
    owner  => 'root',
    group  => 'root',
  }
}
class { 'app-ftp': }

