class redis-cache {

  package { 'redis-server':
    ensure => installed,
  }
 
  exec {'Stopping Redis Service before redefining init.d script':
    user => root,
    group => root,
    command => '/etc/init.d/redis-server stop',
  }

  file { '/etc/init.d/redis-server':
    ensure => file,
    owner => root,
    group => root,
    mode => 751,
    source => 'puppet:///modules/redis-cache/redis-server',
  }

  file { '/etc/redis/redis.conf':
    ensure => file,
    owner => root,
    group => root,
    mode => 544,
    content => template('redis-cache/redis.conf.erb'),
  }

  service { 'redis-server':
    ensure => 'running',
  } 

}
