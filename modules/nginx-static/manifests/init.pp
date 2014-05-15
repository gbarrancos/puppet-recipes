class nginx-static {

  package { 'nginx':
    ensure => installed,
  }

  file { '/etc/nginx/nginx.conf':
     owner => root,
     group => root,
     ensure => file,
     mode => 644,
     source => 'puppet:///modules/nginx-static/nginx.conf',
  }

  file { '/etc/monit/conf.d/nginx':
     owner => root,
     group => root,
     ensure => file,
     mode   => 644,
     source => 'puppet:///modules/nginx-static/nginx_monitrc',
  }


  service { 'nginx':
    ensure => running 
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

 #TODO
 #logrotate



}
