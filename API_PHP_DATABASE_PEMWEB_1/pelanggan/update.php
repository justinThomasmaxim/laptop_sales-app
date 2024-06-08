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

$id_pengguna    = intval($_POST['id_pengguna']);
$nama_pelanggan = $_POST['nama_pelanggan'];
$alamat         = $_POST['alamat'];
$nomor_telepon  = $_POST['nomor_telepon'];

$query = "UPDATE pelanggan 
SET nama_pelanggan = '$nama_pelanggan', alamat = '$alamat', nomor_telepon = '$nomor_telepon'
WHERE id_pengguna = $id_pengguna";

$result = mysqli_query($conn, $query);

// Fetch the data
if ($result) {
    echo json_encode(array("success"=>true));
} else {
    echo json_encode(array("success"=>false));
}

?>