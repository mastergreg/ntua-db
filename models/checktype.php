<?php
    function checktypeCreate( $name, $maxscore ) {
        db(
            "INSERT INTO
                checktypes
            SET
                name = :name,
                maxscore = :maxscore",
            compact( 'name', 'maxscore' )
        );
    }
    function checktypeListing() {
        $res = db(
            "SELECT
                *
            FROM
                checktypes"
        );
        $rows = array();
        while ( $row = mysql_fetch_array( $res ) ) {
            $rows[ $row[ 'chkid' ] ] = $row;
        }
        return $rows;
    }
?>
