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
if (isset($_POST['id_pengguna']) && is_numeric($_POST['id_pengguna'])) {
    $id_pengguna = intval($_POST['id_pengguna']);

    // Query to select data
    $query = "SELECT k.id_keranjang, k.id_pengguna, k.id_laptop, dln.product, k.jumlah, dln.price FROM keranjang AS k
    INNER JOIN dataset_laptop_new AS dln ON (k.id_laptop = dln.id_laptop)
    WHERE k.id_pengguna = $id_pengguna;";
    $result = mysqli_query($conn, $query);
    $rows = [];

    // Fetch the data
    if ($result) {
        while ($row = mysqli_fetch_assoc($result)) {
            $rows[] = $row;
        }
        // Return the data as JSON
        echo json_encode($rows);
    } else {
        echo json_encode(["error" => "Query failed: " . mysqli_error($conn)]);
    }
} else {
    echo json_encode(["error" => "Invalid id_pengguna"]);
}

// Query to select data
// $query = "SELECT k.id_keranjang, k.id_pengguna, k.id_laptop, dln.product, k.jumlah, dln.price FROM keranjang AS k
// INNER JOIN dataset_laptop_new AS dln ON (k.id_laptop = dln.id_laptop)
// WHERE k.id_pengguna = 1;";
// $result = mysqli_query($conn, $query);
// $rows = [];

// // Fetch the data
// if ($result) {
//     while ($row = mysqli_fetch_assoc($result)) {
//         $rows[] = $row;
//     }
//     // Return the data as JSON
//     echo json_encode($rows);
// } else {
//     echo json_encode(["error" => "Query failed: " . mysqli_error($conn)]);
// }
?>
