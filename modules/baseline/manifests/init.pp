class baseline {

  group { 'admin':
    ensure => 'present',
  }

  user  { 'deploy':
    ensure => 'present',
    home => '/home/deploy',
    password => 'l3r0l3r0',
    groups => ["admin"], #added to sudoers by default on Ubuntu
  }

  file { "/home/deploy":
    ensure => 'directory',
    owner => 'deploy',
    group => 'deploy',
    mode => '0750',
  }

  file { '/etc/ssh/sshd_config':
     ensure => file,
     mode   => 600,
     source => 'puppet:///modules/baseline/sshd_config',
  }

  service { 'ssh':
    ensure    => running,
    enable    => true,
    subscribe => File['/etc/ssh/sshd_config'],
  }

  #TODO:
  #activate ssh public key authentication for 'deploy', disable password
  #only allow deploy to login via ssh
  #allow only port 22 SSH
  #install monit!
}

