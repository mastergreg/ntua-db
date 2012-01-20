<?php
if ( empty( $pid ) ) {
    ?><h2>Εισαγωγή νέου αεροσκάφους</h2><?php
}
else {
    ?><h2>Επεξεργασία αεροσκάφους <?php
    echo htmlspecialchars( $pid );
    ?></h2><?php
}
?>
Πληκτρολογήστε τις πληροφορίες του νέου αεροσκάφους:
<form action='plane/<?php
    if ( empty( $pid ) ) {
        ?>create<?php
    }
    else {
        $update = True;
        ?>update<?php
    }
    ?>' method='post'>
    <?php
    if ( !empty( $pid ) ) {
        ?><input type='hidden' name='pid' value='<?php
        echo $pid;
        ?>' /><?php
    }
    ?>
    <div>
        <label>Κωδικός αεροσκάφους:</label> <input type='text' name='pid' value='<?php
        echo htmlspecialchars( $pid );
        ?>' <?php
        if ( isset( $errors[ 'nopid' ] ) ) {
            ?> class='error' <?php
        }
        if ( $update ) {
            ?> class='update' disabled='disabled'<?
        }
        ?> />
    </div>
    <div>
    <label>Όνομα τύπου:</label> <select name='tid'
        <?php
        if ( isset( $errors[ 'notid' ] ) ) {
            ?> class='error'<?php
        }
        ?>>
        <?php
        echo $tid;
        foreach ( $types as $type ) {
            ?><option value='<?php
            echo htmlspecialchars( $type[ 'tid' ] );
            ?>'<?php
            if ( $tid == $type[ 'tid' ] ) {
                echo ' SELECTED';
            }
            ?>><?php
            echo htmlspecialchars( $type[ 'name' ] );
            ?></option><?php
        }
        ?>
        </select>
    </div>
    <input type='submit' value='Αποθήκευση' />
</form>
