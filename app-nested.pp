class app {

  class infr {
    package { 'htop': ensure => installed, }
  }

  class web {
    package { 'elinks': ensure => installed, }
  }

}

class { 'app::infr': }
class { 'app::web': }
