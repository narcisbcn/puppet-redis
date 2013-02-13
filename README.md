puppet-redis
============

Dependency
----------

 - This node requires a sysctl class to tuning some sysct parameters 


Usage
-----

If you want to install just a master instance:

<pre>
class { 'redis::server':
   work_dir    => '/redis/',
   client_pwd  => 'changemeMaster',
   config_bind => '10.13.0.0',
   maxmemory   => '3221225472',
 }
 </pre>


Once you have created your master node, then you can create a replication node used as a backup and Read Only queries:

<pre>
class { 'redis::server':
   work_dir    => '/home/redis/',
   client_pwd  => 'changemeClient',
   config_bind => '10.13.0.0',
   master_ip   => '10.13.0.230',
   master_auth => 'changemeMaster',
 } 
</pre>
