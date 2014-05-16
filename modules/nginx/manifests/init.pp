class nginx {

  package { 'nginx':
    ensure => installed,
  }

  file { '/etc/nginx/nginx.conf':
     owner => root,
     group => root,
     ensure => file,
     mode => 644,
     source => 'puppet:///modules/nginx/nginx.conf',
  }

  file { '/etc/nginx/sites-enabled':
     owner => root,
     group => root,
     ensure => directory,
     mode => 644,
     recurse => true,
     purge => true,
  }

  file { '/etc/nginx/sites-available':
     owner => root,
     group => root,
     ensure => directory,
     mode => 644,
     recurse => true,
     purge => true,
  }

  file { '/etc/monit/conf.d/nginx':
     owner => root,
     group => root,
     ensure => file,
     mode   => 644,
     source => 'puppet:///modules/nginx/nginx_monitrc',
  }

  exec { 'Incoming Http Requests at Port 80':
    user => root,
    group => root,
    command => '/usr/sbin/ufw allow 80'
  } 

  exec { 'Monit: load Nginx monitoring configuration':
     user => root,
     group => root,
     command => '/usr/bin/monit reload'
  }

}
