<?php
error_log("site.log");
error_reporting(E_ALL);
session_start();
if (!isset($_SESSION['css'])) {
    $_SESSION['css'] = '<link rel="stylesheet" type="text/css" href="/site.css">';
}

?>