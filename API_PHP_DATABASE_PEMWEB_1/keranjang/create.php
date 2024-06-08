<?php 

// Database connection
require '../config/connect_db.php';

// Allow CORS requests from any origin
header("Access-Control-Allow-Origin: *");
// Allow specific HTTP methods
header("Access-Control-Allow-Methods: GET, POST, OPTIONS");
// Allow specific HTTP headers
header("Access-Control-Allow-Headers: Content-Type, Authorization");


// Check if id_laptop is set and is a number

$id_pengguna = intval($_POST['id_pengguna']);
$id_laptop   = intval($_POST['id_laptop']);
$jumlah      = intval($_POST['jumlah']);

// Query to select data
$query = "INSERT INTO keranjang(id_pengguna, id_laptop, jumlah)
VALUES ($id_pengguna, $id_laptop, $jumlah)";

$result = mysqli_query($conn, $query);

// Fetch the data
if ($result) {
    echo json_encode(array("success"=>true));
} else {
    echo json_encode(array("success"=>false));
}

?>