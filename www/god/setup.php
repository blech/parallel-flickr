<?php

    include("include/init.php");

    $tables = db_fetch("SHOW TABLES");

    // There aren't any tables, so this is initial setup. Create the database, and away we go.
    if ( $tables['ok'] && count($tables['rows']) == 0 ) {

        $schemas = array(
          "main"    => file_get_contents(FLAMEWORK_WWW_DIR . "/../schema/db_main.schema"),
          "tickets" => file_get_contents(FLAMEWORK_WWW_DIR . "/../schema/db_tickets.schema"),
          "users"   => file_get_contents(FLAMEWORK_WWW_DIR . "/../schema/db_users.schema")
        );

        $GLOBALS['smarty']->assign('error', false);

        foreach ($schemas as $class => $schema) {

            $schema_queries = preg_split('/;/', $schema);

            foreach ($schema_queries as $class => $query) {

                $result = _db_query($query, $class);

                if (!$result['ok']) {
                   $GLOBALS['smarty']->assign('error', $result);
                   break;
                 }
             }
        
        }

        $GLOBALS['smarty']->display("page_god_setup.txt");

    } else {

        // There are tables in the database, so don't let anyone touch anything.
        error_404();

    }


    exit();

?>
