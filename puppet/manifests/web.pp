include "apache"

# Configure Apache VHost
apache::vhost { "parallel-flickr":
  priority => '10',
  port => '80',
  docroot => '/usr/local/parallel-flickr/www',
  require => [Vcsrepo["/usr/local/parallel-flickr"], Package["httpd"]],
  template => "parallel-flickr/parallel-flickr.conf.erb"
}

# temporarily disabled due to bug in puppet.
#
#@a2mod { "Enable rewrite mod":
#  name => "rewrite",
#  ensure => 'present',
#  provider => a2mod,
#  notify => Service['httpd'],
#}
#
# workaround is here:

file { "/etc/apache2/mods-enabled/rewrite.load":
  ensure => link,
  target => "/etc/apache2/mods-available/rewrite.load",
  require => Package["httpd"],
}

file { "/usr/local/parallel-flickr/www/templates_c":
  require => Vcsrepo["/usr/local/parallel-flickr"],
  owner => "www-data",
  mode => '0744',
}

vcsrepo { "/usr/local/parallel-flickr":
  ensure => latest,
  provider => git,
  source => 'https://github.com/straup/parallel-flickr.git',
  require => Package["git"],
}

import "database-common"

$sitename = '🐼  | parallel-flickr'
$parallel_flickr_environment = 'prod'
$flickr_api_key = ''
$flickr_api_secret = ''
$crypto_cookie_secret = ''
$crypto_password_secret = ''
$crypto_crumb_secret = ''
$flickr_static_path = ''

file { "parallel-flickr-config":
  path => "/usr/local/parallel-flickr/www/include/config.php",
  content => template("parallel-flickr/config.php.erb"),
  owner => root,
  group => www-data,
  mode => 440,
  require => Vcsrepo["/usr/local/parallel-flickr"]
}
              
# Ensure PHP is present with relevant modules.
package { [ "git", "php5", "libapache2-mod-php5", "php5-mysql", "php5-curl", "php5-mcrypt" ]: ensure => latest }
