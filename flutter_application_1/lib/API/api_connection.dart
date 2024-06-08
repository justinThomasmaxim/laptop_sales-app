class API {
  
  // static const hostName = "http://192.168.1.4/semester_4/API_PHP_DATABASE_PEMWEB_1";
  static const hostName = "http://localhost:3000";
  // static const hostName = "https://electronsphpapi.000webhostapp.com";
  

  static const datasetLaptop    = "$hostName/dataset_laptop_new";
  static const keranjang        = "$hostName/keranjang";
  static const transaksi        = "$hostName/transaksi";
  static const pembelian_laptop = "$hostName/pembelian_laptop";
  static const pengguna         = "$hostName/pengguna";
  static const pelanggan        = "$hostName/pelanggan";

  // DATASET LAPTOP
  static const readDatasetLaptop = "$datasetLaptop/read.php";
  static const readBerdasarkanId = "$datasetLaptop/readBerdasarkanId.php";

  // KERANJANG
  static const createKeranjang            = "$keranjang/create.php";
  static const readBerdasarkanIdPengguna  = "$keranjang/readBerdasarkanIdPengguna.php";
  static const readBerdasarkanIdKeranjang = "$keranjang/readBerdasarkanIdKeranjang.php";
  static const readBySelectId             = "$keranjang/readBySelectId.php";
  static const updateKeranjang            = "$keranjang/update.php";
  static const deleteKeranjang            = "$keranjang/delete.php";

  // TRANSAKSI
  static const createTransaksi        = "$transaksi/create.php";
  static const readTransaksi          = "$transaksi/read.php";
  static const readAllTransaksi       = "$transaksi/readAllTransaksi.php";

  // PEMBELIAN LAPTOP
  static const createPembelianLaptop  = "$pembelian_laptop/create.php";
  static const BeliSekarang           = "$pembelian_laptop/createBeliSekarang.php";

  // PENGGUNA
  static const createPengguna         = "$pengguna/create.php";
  static const readPengguna           = "$pengguna/read.php";
  static const readByIdPengguna       = "$pengguna/readByIdPengguna.php";

  static const createPelanggan        = "$pelanggan/create.php";
  static const updatePelanggan        = "$pelanggan/update.php";
  static const readPelangganById      = "$pelanggan/readByIdPengguna.php";
}