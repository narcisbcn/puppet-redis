

class redis::service{

   service { 'redis':
      enable     => true,
      ensure     => running,
      hasrestart => true,
      require    => Package['redis'], 
   }

}
