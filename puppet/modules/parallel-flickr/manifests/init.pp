class parallel-flickr {

  vcsrepo { "/usr/local/parallel-flickr":
    ensure => present,
    provider => git,
    source => 'https://github.com/straup/parallel-flickr.git',
  }

}
