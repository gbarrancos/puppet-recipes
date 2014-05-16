class static-webserver {
  include nginx

  file { '/etc/nginx/sites-enabled/main':
    owner => root,
    group => root,
    ensure => file,
    mode => 644,
    source => 'puppet:///modules/static-webserver/main_site',
  }
 
  package { 'logrotate':
    ensure => installed,
  }
 
  service { 'nginx':
    ensure => running,
    restart => '',
  }
  
  file { '/etc/logrotate.d/nginx':
   owner => root,
   group => root,
   ensure => file,
   mode => 644,
   source => 'puppet:///modules/static-webserver/nginx_logrotate'

  }

}
