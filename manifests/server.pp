#
# Simple class to set up and configure Redis
# TODO: Document all cases
#
# Usage:
#
# For a master instance:
#
#   class { 'redis::server':
#      work_dir    => '/redis/',
#      client_pwd  => 'changemeMaster',
#      config_bind => '10.13.0.0',
#      maxmemory   => '3221225472'
#   }
#
# If you want another node replication from that master, and still use this node for Read Only:
#
#   class { 'redis::server':
#      work_dir    => '/home/redis/',
#      client_pwd  => 'changemeClient',
#      config_bind => '10.13.0.0',
#      master_ip   => '10.13.0.230',
#      master_auth => 'changemeMaster'
#   } 


class redis::server(

   $daemonize       = 'yes',
   $pckg_name       = 'redis',
   $port            = '6379',
   $work_dir        = '/datos/redis/',
   $config_bind     = '127.0.0.1',
   $client_pwd      = '',
   $config_loglevel = 'notice',
   $config_timeout  = '300',
   $logfile         = '/var/log/redis/redis.log',
   $loglevel        = 'notice',
   $databases       = '16',
   $snapshot        = { '900' => '1', '300' => '10', '60' => '10000' },
   $ensure          = 'running',
   $master_ip       = '',
   $master_port     = '6379',
   $master_auth     = '',
   $maxmemory       = '1000000000'

   ){

   include redis::service
   Class['redis::server'] -> Class['redis::service']
   
   package { "$pckg_name":
      ensure => present
   }

   file { ["/etc/redis", "$work_dir"]:
      owner   => 'redis',
      group   => 'redis',
      ensure  => directory,
      require => Package["$pckg_name"],
   }

   file { '/etc/redis.conf':
      content => template('redis/redis.conf.erb'),
      mode    => 0644,
      notify  => Service['redis'],
      owner   => 'root',
      group   => 'root',
      require => Package["$pckg_name"],
   }

   sysctl::conf { 'vm.overcommit_memory' : value => '1' }
  
}

