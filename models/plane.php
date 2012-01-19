<?php
    function planeCreate( $pid, $tid ) {
        db(
            "INSERT INTO
                planes 
            SET
                pid = :pid,
                tid = :tid",
            compact( 'pid', 'tid' )
        );
    }
    function planeListing() {
        $res = db(
            "SELECT
                *
            FROM
                planes"
        );
        $rows = array();
        while ( $row = mysql_fetch_array( $res ) ) {
            $rows[ $row[ 'pid' ] ] = $row;
        }
        return $rows;
    }
    function planeDelete( $pid ) {
        db(
            "DELETE FROM
                planes
            WHERE
                pid = :pid
            LIMIT 1",
            compact( 'pid' )
        );
    }
    function planeUpdate( $pid, $tid ) {
        db(
            "UPDATE
                planes
            SET
                tid = :tid,
            WHERE
                pid = :pid
            LIMIT 1",
            compact( 'pid', 'tid' )
        );
    }
    function planeItem( $pid ) {
        $res = db(
            "SELECT
                *
            FROM
                planes
            WHERE
                pid = :pid
            LIMIT 1",
            compact( 'pid' )
        );
        return mysql_fetch_array( $res );
    }
?>
