import "apache"

# Configure Apache VHost
apache::vhost { "parallel-flickr":
  priority => '10',
  port => '80',
  docroot => '/usr/local/parallel-flickr/www',
  require => Vcsrepo["/usr/local/parallel-flickr"],
}

file { "/usr/local/parallel-flickr/www/templates_c":
  require => Vcsrepo["/usr/local/parallel-flickr"],
  owner => "www-data",
  mode => '0744',
}

vcsrepo { "/usr/local/parallel-flickr":
  ensure => present,
  provider => git,
  source => 'https://github.com/straup/parallel-flickr.git',
  require => Package["git"],
}
              
# Ensure PHP is present with relevant modules.
package { [ "git", "php5", "libapache2-mod-php5", "php5-mysql", "php5-curl", "php5-mcrypt" ]: ensure => latest }
