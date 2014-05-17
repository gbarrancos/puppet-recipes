class monit {

  package { 'monit':
    ensure => installed,
 
  }
 
  file { '/etc/monit/conf.d':
    ensure => directory,
    purge => true,
    recurse => true,
    owner => root,
    group => root,
    mode => 755,
    require => Package['monit']
  }

  file { '/etc/monit/monitrc':
     owner => root,
     group => root,
     ensure => file,
     mode   => 700,
     source => 'puppet:///modules/baseline/monitrc'
  }

  service { 'monit':
    ensure => running,
    restart => ''
  }


}
