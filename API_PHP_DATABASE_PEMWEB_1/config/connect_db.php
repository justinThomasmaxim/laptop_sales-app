<?php 

$hostname = "localhost";
$username = "root";
$password = "";
$db_name  = "electron";

$conn = mysqli_connect($hostname, $username, $password, $db_name);

// Memeriksa Hubungan
if (!$conn) {
    die("Connection failed: " . mysqli_connect_error());
}

?>