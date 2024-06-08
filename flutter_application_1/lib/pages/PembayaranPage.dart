// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:http/http.dart' as http;
// import 'package:flutter_application_1/API/api_connection.dart';
// import 'dart:convert';

// class PembayaranPage extends StatefulWidget {
//   @override
//   State<PembayaranPage> createState() => _PembayaranPageState();
// }

// class _PembayaranPageState extends State<PembayaranPage> {
//   List dataTransaksi = [];
//   List dataKeranjang = [];

//   @override
//   void initState() {
//     super.initState();
//     // getTransaksi();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       final Map<String, dynamic> args =
//           ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
//       final num subtotal = args['subtotal'];
//       final List<int> selectedIds = args['selectedIds'];
//       fetchProdukByIds(selectedIds);
//       getTransaksi();
//     });
//   }

//   Future<void> fetchProdukByIds(List<int> selectedIds) async {
//     String uri = API.readBySelectId; // Perbarui dengan endpoint yang sesuai
//     try {
//       var response = await http.post(
//         Uri.parse(uri),
//         body: {
//           'selectedIds': jsonEncode(selectedIds),
//         },
//       );

//       if (response.statusCode == 200) {
//         setState(() {
//           dataKeranjang = jsonDecode(response.body);
//         });
//       } else {
//         print('Gagal memuat data: ${response.reasonPhrase}');
//       }
//     } catch (e) {
//       print('Error: $e');
//     }
//   }

//   Future<void> getTransaksi() async {
//     String uri = API.readTransaksi;
//     try {
//       var response = await http.get(Uri.parse(uri));

//       if (response.statusCode == 200) {
//         setState(() {
//           dataTransaksi = jsonDecode(response.body);
//         });
//       } else {
//         print('Failed to load data');
//       }
//     } catch (e) {
//       print('Error: $e');
//     }
//   }

//   Future<void> addTransaksi(num subtotal) async {
//     String uri = API.createTransaksi; // Sesuaikan URI dengan endpoint API Anda
//     try {
//       var response = await http.post(
//         Uri.parse(uri),
//         body: {
//           'subtotal': subtotal.toString(),
//         },
//       );

//       if (response.statusCode == 200) {
//         var jsonResponse = jsonDecode(response.body);
//         if (jsonResponse['success']) {
//           String idTransaksi = dataTransaksi[0]['id_transaksi'];
//           for (int i = 0; i < dataKeranjang.length; i++) {
//             String id_keranjang = dataKeranjang[i]['id_keranjang'];
//             String id_laptop = dataKeranjang[i]['id_laptop'];
//             String jumlah = dataKeranjang[i]['jumlah'];
//             print(jumlah);
//             setState(() {
//               // addPembelianLaptop(selectedIds, idTransaksi, '1');
//               addPembelianLaptop(
//                   id_keranjang, id_laptop, idTransaksi, '1', jumlah);
//             });
//           }
//         }
//       } else {
//         print('Failed to load data: ${response.reasonPhrase}');
//       }
//     } catch (e) {
//       print('Error: $e');
//     }
//   }

//   Future<void> addPembelianLaptop(
//       // List<int> selectedIds, String id_transaksi, String id_pengguna) async {
//       String id_keranjang,
//       String id_laptop,
//       String id_transaksi,
//       String id_pengguna,
//       String jumlah) async {
//     String uri =
//         API.createPembelianLaptop; // Sesuaikan URI dengan endpoint API Anda
//     try {
//       var response = await http.post(
//         Uri.parse(uri),
//         // body: {
//         //   'selectedIds': selectedIds.toString(),
//         //   'id_transaksi': id_transaksi,
//         //   'id_pengguna': id_pengguna,
//         // },
//         body: {
//           'id_keranjang': id_keranjang,
//           'id_laptop': id_laptop,
//           'id_transaksi': id_transaksi,
//           'id_pengguna': id_pengguna,
//           'jumlah': jumlah,
//         },
//       );

//       if (response.statusCode == 200) {
//         var jsonResponse = jsonDecode(response.body);
//         if (jsonResponse['success']) {
//           showDialog(
//               context: context,
//               builder: (context) {
//                 return AlertDialog(
//                   title: Text("Success"),
//                   content: Text("Pembayaran Selesai"),
//                   actions: [
//                     FloatingActionButton(
//                       onPressed: () {
//                         Navigator.of(context).pop();
//                         Navigator.pushNamed(context, "/");
//                       },
//                       child: Text("Oke"),
//                     )
//                   ],
//                 );
//               });
//         }
//       } else {
//         print('Failed to load data: ${response.reasonPhrase}');
//       }
//     } catch (e) {
//       print('Error: $e');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     // Mendapatkan argumen dari Navigator
//     final Map<String, dynamic> args =
//         ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
//     final num subtotal = args['subtotal'];
//     final List<int> selectedIds = args['selectedIds'];

//     // Format mata uang
//     final priceFormatted = NumberFormat.currency(locale: 'id', symbol: 'Rp. ');

//     return Scaffold(
//       backgroundColor: Color(0xFFEDECF2),
//       appBar: AppBar(
//         title: Text(
//           "Pembayaran",
//           style: TextStyle(),
//         ),
//       ),
//       body: Center(
//         child: Container(
//           padding: EdgeInsets.only(top: 15, bottom: 15, left: 20, right: 20),
//           width: 300,
//           height: 260,
//           decoration: BoxDecoration(
//               color: Colors.white, borderRadius: BorderRadius.circular(5)),
//           child: Column(
//             children: [
//               Text("Bayar Sekarang", style: TextStyle(fontSize: 30)),
//               SizedBox(
//                 height: 10,
//               ),
//               Text("Total yang harus dibayarkan"),
//               SizedBox(
//                 height: 10,
//               ),
//               Text(
//                   // "Rp. 64.000",
//                   priceFormatted.format(subtotal),
//                   style: TextStyle(color: Colors.orange)),
//               SizedBox(
//                 height: 10,
//               ),
//               ElevatedButton(
//                 onPressed: () {
//                   setState(() {
//                     addTransaksi(subtotal);
//                   });
//                 },
//                 child:
//                     Text("Konfirmasi", style: TextStyle(color: Colors.white)),
//                 style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//               Text(
//                   "Laman ini akan otomatis tertutup saat pembayaran di konfirmasi"),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_application_1/API/api_connection.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class PembayaranPage extends StatefulWidget {
  @override
  State<PembayaranPage> createState() => _PembayaranPageState();
}

class _PembayaranPageState extends State<PembayaranPage> {
  List dataTransaksi = [];
  List dataKeranjang = [];
  num subtotal = 0;
  List<int> selectedIds = [];
  int? userId;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final Map<String, dynamic>? args =
          ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
      if (args != null) {
        subtotal = args['subtotal'];
        selectedIds = List<int>.from(args['selectedIds']);
        fetchProdukByIds(selectedIds);
        getTransaksi();
      }
    });
  }

  Future<void> fetchProdukByIds(List<int> selectedIds) async {
    String uri = API.readBySelectId; // Perbarui dengan endpoint yang sesuai
    try {
      var response = await http.post(
        Uri.parse(uri),
        body: {
          'selectedIds': jsonEncode(selectedIds),
        },
      );

      if (response.statusCode == 200) {
        setState(() {
          dataKeranjang = jsonDecode(response.body);
        });
      } else {
        print('Gagal memuat data: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> getTransaksi() async {
    String uri = API.readTransaksi;
    try {
      var response = await http.get(Uri.parse(uri));

      if (response.statusCode == 200) {
        setState(() {
          dataTransaksi = jsonDecode(response.body);
        });
      } else {
        print('Failed to load data');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> addTransaksi(num subtotal) async {
    String uri = API.createTransaksi; // Sesuaikan URI dengan endpoint API Anda
    try {
      var response = await http.post(
        Uri.parse(uri),
        body: {
          'subtotal': subtotal.toString(),
        },
      );

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        if (jsonResponse['success'] && dataTransaksi.isNotEmpty) {
          String idTransaksi = dataTransaksi[0]['id_transaksi'];
          for (int i = 0; i < dataKeranjang.length; i++) {
            String id_keranjang = dataKeranjang[i]['id_keranjang'];
            String id_laptop = dataKeranjang[i]['id_laptop'];
            String jumlah = dataKeranjang[i]['jumlah'];
            print(jumlah);
            setState(() {
              addPembelianLaptop(id_keranjang, id_laptop, idTransaksi, jumlah);
            });
          }
        }
      } else {
        print('Failed to load data: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> addPembelianLaptop(
      String id_keranjang,
      String id_laptop,
      String id_transaksi,
      String jumlah) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? userId = prefs.getInt('id_pengguna');
    String uri =
        API.createPembelianLaptop; // Sesuaikan URI dengan endpoint API Anda
    try {
      var response = await http.post(
        Uri.parse(uri),
        body: {
          'id_keranjang': id_keranjang,
          'id_laptop': id_laptop,
          'id_transaksi': id_transaksi,
          'id_pengguna': userId.toString(),
          'jumlah': jumlah,
        },
      );

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        if (jsonResponse['success']) {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text("Success"),
                  content: Text("Pembayaran Selesai"),
                  actions: [
                    FloatingActionButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.pushNamed(context, "/");
                      },
                      child: Text("Oke"),
                    )
                  ],
                );
              });
        }
      } else {
        print('Failed to load data: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    // Mendapatkan argumen dari Navigator
    final Map<String, dynamic>? args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    if (args != null) {
      subtotal = args['subtotal'];
      selectedIds = List<int>.from(args['selectedIds']);
    }

    // Format mata uang
    final priceFormatted = NumberFormat.currency(locale: 'id', symbol: 'Rp. ');

    return Scaffold(
      backgroundColor: Color(0xFFEDECF2),
      appBar: AppBar(
        title: Text(
          "Pembayaran",
          style: TextStyle(),
        ),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.only(top: 15, bottom: 15, left: 20, right: 20),
          width: 300,
          height: 260,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(5)),
          child: Column(
            children: [
              Text("Bayar Sekarang", style: TextStyle(fontSize: 30)),
              SizedBox(
                height: 10,
              ),
              Text("Total yang harus dibayarkan"),
              SizedBox(
                height: 10,
              ),
              Text(
                  priceFormatted.format(subtotal),
                  style: TextStyle(color: Colors.orange)),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    addTransaksi(subtotal);
                  });
                },
                child:
                    Text("Konfirmasi", style: TextStyle(color: Colors.white)),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                  "Laman ini akan otomatis tertutup saat pembayaran di konfirmasi"),
            ],
          ),
        ),
      ),
    );
  }
}
