class ruby-webapp {
  include ruby2
  include passenger
   
  file { '/etc/nginx/nginx.conf':
    owner => root,
    group => root,
    ensure => file,
    mode => 644,
    source => 'puppet:///modules/ruby-webapp/nginx.conf',
  }

  file { '/etc/nginx/sites-enabled/ruby-webapp':
    owner => root,
    group => root,
    ensure => file,
    mode => 644,
    source => 'puppet:///modules/ruby-webapp/nginx-site',
  }

  file { '/usr/share/nginx/ruby-webapp':
    owner => root,
    group => root,
    ensure => directory,
  }

  file { '/usr/share/nginx/ruby-webapp/config.ru':
    owner => root,
    group => root,
    ensure => file,
    mode => 644,
    source => 'puppet:///modules/ruby-webapp/config.ru', 
  }

}
