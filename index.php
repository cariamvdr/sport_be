<?php
error_reporting(E_ALL);
ini_set('display_errors', 1);

spl_autoload_register(function($class_name) {
    $filename = dirname(__FILE__).DIRECTORY_SEPARATOR.str_replace("\\", DIRECTORY_SEPARATOR, $class_name);
    require_once $filename.".php";
});

if (isset($_SERVER["HTTP_CONTENT_TYPE"]) &&
        stripos($_SERVER["HTTP_CONTENT_TYPE"], "application/json") === 0) {
    $_POST = json_decode(file_get_contents("php://input"));
}