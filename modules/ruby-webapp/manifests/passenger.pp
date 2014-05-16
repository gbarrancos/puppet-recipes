class passenger {
  
  exec { 'Adding Phusion Key':
    command => '/usr/bin/apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 561F9B9CAC40B2F7',
    user => root,
  }

  package { 'apt-transport-https':
    ensure => installed,  
  }

  package { 'ca-certificates':
    ensure => installed,
  }

  file { '/etc/apt/sources.list.d/passenger.list':
    source => 'puppet:///modules/ruby-webapp/passenger.list',
    owner => root,
    group => root,
  }

  exec { 'Updating packages list':
     command => '/usr/bin/apt-get update',
     user => root,
  }

  package { 'nginx-extras': 
    ensure => installed,
  }
 
  package { 'passenger':
    ensure => installed
  }

  service { 'nginx':
    restart => '',
    ensure => running, 
  } 
  
  file { '/etc/nginx/nginx.conf':
    owner => root,
    group => root,
    ensure => file,
    mode => 644,
    content => template('ruby-webapp/nginx.conf.erb'),
  }
  
}





