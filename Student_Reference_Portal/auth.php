<?php
session_start();

function requireLogin() {
    if (empty($_SESSION['user_id'])) {
        header('Location: login.php');
        exit;
    }
}

define('ROLE_STUDENT', 1);
define('ROLE_TUTOR',   2);
define('ROLE_ADMIN',   3);
?>