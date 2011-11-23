include "mysql"

$dbpassword = "nonesofar"

class { 'mysql::server':
}

mysql::db { "flickr":
  user => "flickr",
  password => $dbpassword,
}
