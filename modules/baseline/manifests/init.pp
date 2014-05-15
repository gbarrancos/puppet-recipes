class baseline {

  group { 'admin':
    ensure => 'present',
  }

  user  { 'deploy':
    ensure => 'present',
    home => '/home/deploy',
    shell => '/bin/bash',
    groups => ["admin"], #added to sudoers by default on Ubuntu
  }

  file { "/home/deploy":
    ensure => directory,
    owner => deploy,
    group => deploy,
    mode => '0750',
  }

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
  
  #TODO:
  #activate ssh public key authentication for 'deploy', disable password
  #only allow deploy to login via ssh
}

