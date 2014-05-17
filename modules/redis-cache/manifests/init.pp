class redis-cache {

  package { 'redis-server':
    ensure => installed,
  }
 
  exec {'Stopping Redis Service before redefining init.d script':
    user => root,
    group => root,
    command => '/etc/init.d/redis-server stop',
  }

  $initial_redis_port = 6379
  
  file { '/etc/init.d/redis-server':
    ensure => file,
    owner => root,
    group => root,
    mode => 751,
    content => template('redis-cache/redis-server.erb'),
  }

  file { '/etc/redis/redis.conf':
    ensure => file,
    owner => root,
    group => root,
    mode => 644,
    content => template('redis-cache/redis.conf.erb'),
  }
 
  file { '/etc/monit/conf.d/redis-server':
    ensure => file,
    owner => root,
    group => root,
    content => template('redis-cache/monit.erb')
  }

  service { 'redis-server':
    ensure => 'running',
  }

  file { '/etc/ufw/applications.d/redis-server':
    ensure => file,
    mode => 644,
    owner => root,
    group => root,
    content => template('redis-cache/redis-ufw-rule.erb'),
  }

  exec { 'Activate Redis TCP connections':
    user => root,
    group => root,
    command => '/usr/sbin/ufw allow Redis'
  } 
 
  exec {'Reload Monit with Redis Monitoring':
     user => root,
     group => root,
     command => '/usr/bin/monit reload'
  }
}
