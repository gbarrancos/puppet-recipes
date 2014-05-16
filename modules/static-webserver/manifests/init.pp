class static-webserver {
  include nginx

  file { '/etc/nginx/sites-enabled/main':
    owner => root,
    group => root,
    ensure => file,
    mode => 644,
    source => 'puppet:///modules/static-webserver/main_site',
  }
  
  service { 'nginx':
    ensure => running,
    restart => '',
  }

 # TODO:
 # - logrotate

}
