<?php 

// Database connection
require '../config/connect_db.php';

// Allow CORS requests from any origin
header("Access-Control-Allow-Origin: *");
// Allow specific HTTP methods
header("Access-Control-Allow-Methods: GET, POST, OPTIONS");
// Allow specific HTTP headers
header("Access-Control-Allow-Headers: Content-Type, Authorization");


// Check if id_keranjang is set and is a number

$id_keranjang   = intval($_POST['id_keranjang']);

$query = "DELETE FROM keranjang 
WHERE id_keranjang = $id_keranjang";

$result = mysqli_query($conn, $query);

// Fetch the data
if ($result) {
    echo json_encode(array("success"=>true));
} else {
    echo json_encode(array("success"=>false));
}

?>