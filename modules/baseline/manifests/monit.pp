class monit {

  package { 'monit':
    ensure => installed,
 
  }

  file { '/etc/monit/monitrc':
     owner => root,
     group => root,
     ensure => file,
     mode   => 600,
     source => 'puppet:///modules/baseline/monitrc'
  }

  service { 'monit':
    ensure => running 
  }


}
