<?php 

// Database connection
require '../config/connect_db.php';

// Allow CORS requests from any origin
header("Access-Control-Allow-Origin: *");
// Allow specific HTTP methods
header("Access-Control-Allow-Methods: GET, POST, OPTIONS");
// Allow specific HTTP headers
header("Access-Control-Allow-Headers: Content-Type, Authorization");


// // Check if id_laptop is set and is a number

// $id_transaksi = intval($_POST['id_transaksi']);

// // Query to select data
// $query = "INSERT INTO transaksi(subtotal)
// VALUES ($subtotal)";

// $result = mysqli_query($conn, $query);

// // Fetch the data
// if ($result) {
//     echo json_encode(array("success"=>true));
// } else {
//     echo json_encode(array("success"=>false));
// }

// Memeriksa apakah selectedIds disetel dan merupakan array
// if (isset($_POST['selectedIds'])) {
//     $selectedIds = json_decode($_POST['selectedIds'], true);

//     if (is_array($selectedIds) && count($selectedIds) > 0) {
//         // Mengamankan input dengan escaping
//         $selectedIds = array_map('intval', $selectedIds);
//         $ids_string = implode(',', $selectedIds);

//         // Query untuk memilih data
//         $query = "SELECT k.id_keranjang, k.id_pengguna, k.id_laptop, dln.product, k.jumlah, dln.price FROM keranjang AS k
//                   INNER JOIN dataset_laptop_new AS dln ON k.id_laptop = dln.id_laptop
//                   WHERE k.id_keranjang IN ($ids_string)";
//         $result = mysqli_query($conn, $query);
//         $rows = [];

//         // Mengambil data
//         if ($result) {
//             while ($row = mysqli_fetch_assoc($result)) {
//                 $rows[] = $row;
//             }
//             // Mengembalikan data sebagai JSON
//             echo json_encode($rows);
//         } else {
//             echo json_encode(["error" => "Query gagal: " . mysqli_error($conn)]);
//         }
//     } else {
//         echo json_encode(["error" => "Daftar ID tidak valid"]);
//     }
// } else {
//     echo json_encode(["error" => "selectedIds tidak disetel"]);
// }

// $id_keranjang = intval($_POST['id_keranjang']);
// $id_laptop    = intval($_POST['id_laptop']);
// $id_transaksi = intval($_POST['id_transaksi']);
// $id_pengguna  = intval($_POST['id_pengguna']);
// $jumlah       = intval($_POST['jumlah']);

// // Query to select data
// $query = "INSERT INTO pembelian_laptop(id_transaksi, id_pengguna, id_laptop, jumlah)
// VALUES ($id_transaksi, $id_pengguna, $id_laptop, $jumlah)";

// $result = mysqli_query($conn, $query);


// $query1 = "DELETE FROM keranjang 
// WHERE id_keranjang = $id_keranjang";

// $result1 = mysqli_query($conn, $query1);

// // Fetch the data
// if ($result) {
//     echo json_encode(array("success"=>true));
// } else {
//     echo json_encode(array("success"=>false));
// }

$id_keranjang = intval($_POST['id_keranjang']);
$id_laptop    = intval($_POST['id_laptop']);
$id_transaksi = intval($_POST['id_transaksi']);
$id_pengguna  = intval($_POST['id_pengguna']);
$jumlah       = intval($_POST['jumlah']);

// Query to insert data
$query = "INSERT INTO pembelian_laptop (id_transaksi, id_pengguna, id_laptop, jumlah) VALUES ($id_transaksi, $id_pengguna, $id_laptop, $jumlah)";
$result = mysqli_query($conn, $query);

if ($result) {
    // Query to delete from keranjang
    $query1 = "DELETE FROM keranjang WHERE id_keranjang = $id_keranjang";
    $result1 = mysqli_query($conn, $query1);
    
    if ($result1) {
        echo json_encode(array("success" => true));
    } else {
        echo json_encode(array("success" => false, "message" => "Failed to delete from keranjang"));
    }
} else {
    echo json_encode(array("success" => false, "message" => "Failed to insert into pembelian_laptop"));
}

mysqli_close($conn);

?>