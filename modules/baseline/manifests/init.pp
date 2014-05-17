class baseline {

  file { '/etc/ssh/sshd_config':
     ensure => file,
     owner => root,
     group => root,
     mode   => 600,
     source => 'puppet:///modules/baseline/sshd_config',
  }

  service { 'ssh':
    ensure    => running,
    enable    => true,
    subscribe => File['/etc/ssh/sshd_config'],
  }

  exec { 'ssh Firewall rule':
      user => root,
      group => root,
      command => '/usr/sbin/ufw allow 22',
  }	

  exec { 'Activate Firewall':
      user => root,
      group => root,
      command => '/usr/sbin/ufw enable'  
  }
  
  include monit
  
}

