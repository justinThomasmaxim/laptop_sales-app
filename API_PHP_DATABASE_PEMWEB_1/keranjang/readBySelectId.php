<?php 

// // Koneksi ke database
// require '../config/connect_db.php';

// // Mengizinkan permintaan CORS dari semua asal
// header("Access-Control-Allow-Origin: *");
// // Mengizinkan metode HTTP tertentu
// header("Access-Control-Allow-Methods: GET, POST, OPTIONS");
// // Mengizinkan header HTTP tertentu
// header("Access-Control-Allow-Headers: Content-Type, Authorization");

// // Memeriksa apakah selectedIds disetel dan merupakan array
// if (isset($_POST['selectedIds'])) {
//     $selectedIds = json_decode($_POST['selectedIds'], true);

//     if (is_array($selectedIds) && count($selectedIds) > 0) {
//         // Mengamankan input dengan escaping
//         $selectedIds = array_map('intval', $selectedIds);
//         $ids_string = implode(',', $selectedIds);

//         // Query untuk memilih data
//         $query = "SELECT k.id_keranjang, k.id_pengguna, k.id_laptop, dln.product, k.jumlah, dln.price FROM keranjang AS k
//         INNER JOIN dataset_laptop_new AS dln ON (k.id_laptop = dln.id_laptop)
//         WHERE id_keranjang = $ids_string";
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

// $selectedIds = ['1', '2', '3'];
// $selectedIds = array_map('intval', $selectedIds); 
// $ids_string = implode(',', $selectedIds);
// $c = explode(',', $ids_string);

// echo json_encode($selectedIds);
// echo json_encode($c);


// Koneksi ke database
require '../config/connect_db.php';

// Mengizinkan permintaan CORS dari semua asal
header("Access-Control-Allow-Origin: *");
// Mengizinkan metode HTTP tertentu
header("Access-Control-Allow-Methods: GET, POST, OPTIONS");
// Mengizinkan header HTTP tertentu
header("Access-Control-Allow-Headers: Content-Type, Authorization");

// Memeriksa apakah selectedIds disetel dan merupakan array
if (isset($_POST['selectedIds'])) {
    $selectedIds = json_decode($_POST['selectedIds'], true);

    if (is_array($selectedIds) && count($selectedIds) > 0) {
        // Mengamankan input dengan escaping
        $selectedIds = array_map('intval', $selectedIds);
        $ids_string = implode(',', $selectedIds);

        // Query untuk memilih data
        $query = "SELECT k.id_keranjang, k.id_pengguna, k.id_laptop, dln.product, k.jumlah, dln.price FROM keranjang AS k
                  INNER JOIN dataset_laptop_new AS dln ON k.id_laptop = dln.id_laptop
                  WHERE k.id_keranjang IN ($ids_string)";
        $result = mysqli_query($conn, $query);
        $rows = [];

        // Mengambil data
        if ($result) {
            while ($row = mysqli_fetch_assoc($result)) {
                $rows[] = $row;
            }
            // Mengembalikan data sebagai JSON
            echo json_encode($rows);
        } else {
            echo json_encode(["error" => "Query gagal: " . mysqli_error($conn)]);
        }
    } else {
        echo json_encode(["error" => "Daftar ID tidak valid"]);
    }
} else {
    echo json_encode(["error" => "selectedIds tidak disetel"]);
}


?>
