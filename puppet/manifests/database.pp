include "mysql"

import "database-common"

class { 'mysql::server':
}

mysql::db { "flickr":
  user => "flickr",
  password => $dbpassword,
}
