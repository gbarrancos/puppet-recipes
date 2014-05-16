class ruby2 {

  package { 'ruby2.0':
     ensure => installed,
  }

  package { 'ruby2.0-dev':
     ensure => installed,
  }

  file { '/etc/alternatives/ruby':
     ensure => link,
     target => "/usr/bin/ruby2.0",
     mode => 775,
  }

  file { '/etc/alternatives/gem':
     ensure => link,
     target => "/usr/bin/gem2.0",
     mode => 775,
  }



}
