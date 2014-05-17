class ruby-webapp {
  include ruby2
  include passenger
   
  file { '/etc/nginx/sites-enabled/ruby-webapp':
    owner => root,
    group => root,
    ensure => file,
    mode => 644,
    source => 'puppet:///modules/ruby-webapp/nginx-site',
    require => Package['nginx-extras']
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

   file { '/etc/monit/conf.d/nginx-ruby-app':
    owner => root,
    group => root,
    ensure => file,
    mode   => 644,
    source => 'puppet:///modules/ruby-webapp/webapp_monitrc',
    require => File['/etc/monit/conf.d'],
  }


  exec { 'Monit: load Nginx monitoring configuration':
     user => root,
     group => root,
     command => '/usr/bin/monit reload',
     require => File['/etc/monit/conf.d/nginx-ruby-app'],
  }

  

}
