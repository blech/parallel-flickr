# Packages and configuration common to all nodes.

package { ["htop", "sysstat"]: ensure => 'latest' }

service { "procps": }

file { "/etc/sysctl.d/60-parallel-flickr.conf":
  ensure => present,
  owner => root,
  group => root,
  mode => 0644,
  source => 'puppet:///modules/parallel-flickr/sysctl.conf',
  notify => Service["procps"],
}
