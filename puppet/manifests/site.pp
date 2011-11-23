import "modules"
import "nodes"

group { "puppet": ensure => present }

exec { "apt-get-update":
    command => "/usr/bin/apt-get update",

    /* Don't bother running this if we have a recent package cache */
    unless  => "/usr/bin/find /var/cache/apt/ -name pkgcache.bin -mtime -7 | /bin/grep .",
}

Package {
  require => Exec["apt-get-update"]
}
