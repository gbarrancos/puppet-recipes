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
    require => Exec['Adding Phusion Key'],
  }

  exec { 'PackageListUpdate':
     command => '/usr/bin/apt-get update',
     user => root,
     require => File['/etc/apt/sources.list.d/passenger.list'],
  }

  package { 'nginx-extras': 
    ensure => latest,
    require => Exec['PackageListUpdate'],
  }
 
  package { 'passenger':
    ensure => installed,
    require => Package['nginx-extras'],
  }

  service { 'nginx':
    restart => '',
    ensure => running, 
    require => Package['passenger']
  } 
  
  file { '/etc/nginx/nginx.conf':
    owner => root,
    group => root,
    ensure => file,
    mode => 644,
    content => template('ruby-webapp/nginx.conf.erb'),
    require => Package['passenger'],
  }
  
}





