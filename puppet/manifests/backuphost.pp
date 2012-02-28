cron { "backup_contacts":
  command => "php /usr/local/parallel-flickr/bin/backup_contacts.php",
  user => "www-data"
  hour => 3,
  minute => 0,
  require => Vcsrepo["/usr/local/parallel-flickr"]
}

cron { "backup_faves":
  command => "php /usr/local/parallel-flickr/bin/backup_faves.php",
  user => "www-data",
  hour => 3,
  minute => 15
  require => Vcsrepo["/usr/local/parallel-flickr"]
}

cron { "backup_photos":
  command => "php /usr/local/parallel-flickr/bin/backup_photos.php",
  user => "www-data",
  hour => 3,
  minute => 30
  require => Vcsrepo["/usr/local/parallel-flickr"]
}
