import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:flutter_application_1/API/api_connection.dart';

class CheckoutPage extends StatefulWidget {
  final List<int> selectedIds;

  CheckoutPage({required this.selectedIds});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  List produkYangDibeli = [];

  @override
  void initState() {
    super.initState();
    fetchProdukByIds();
  }

  Future<void> fetchProdukByIds() async {
    String uri = API.readBySelectId; // Perbarui dengan endpoint yang sesuai
    try {
      var response = await http.post(
        Uri.parse(uri),
        body: {
          'selectedIds': jsonEncode(widget.selectedIds),
        },
      );

      if (response.statusCode == 200) {
        setState(() {
          produkYangDibeli = jsonDecode(response.body);
        });
      } else {
        print('Gagal memuat data: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final priceFormatted = NumberFormat.currency(locale: 'id', symbol: 'Rp. ');
    num subtotal = 0;

    return Scaffold(
      backgroundColor: Color(0xFFEDECF2),
      appBar: AppBar(
        title: Text("Checkout"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 380,
              margin: EdgeInsets.only(top: 30),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Produk yang akan dibeli",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16),

                  // ATRIBUT
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        width: 70,
                        child: Text(
                          "Produk",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        width: 110,
                        child: Text(
                          "Harga",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        width: 70,
                        child: Text(
                          "Jumlah",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        width: 110,
                        child: Text(
                          "Total",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  ...produkYangDibeli.map((produk) {
                    num price = num.tryParse(produk['price'].toString()) ?? 0;
                    int jumlah = int.parse(produk['jumlah']) ?? 1;
                    num total = price * jumlah;

                    setState(() {
                      subtotal = subtotal + total;
                    });

                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Divider(),
                        Container(
                          alignment: Alignment.center,
                          width: 70,
                          child: Text(
                            produk['product'],
                            style: TextStyle(fontSize: 10),
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          width: 110,
                          child: Text(
                            // "Rp. ${NumberFormat('#,##0', 'id_ID').format(produk['price'])}",
                            // "Rp. 1",
                            priceFormatted.format(price),
                            style: TextStyle(fontSize: 10),
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          width: 70,
                          child: Text(
                            produk['jumlah'].toString(),
                            style: TextStyle(fontSize: 10),
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          width: 110,
                          child: Text(
                            // "Rp. ${NumberFormat('#,##0', 'id_ID').format(produk['price'] * produk['jumlah'])}",
                            // "Rp. 1",
                            priceFormatted.format(total),
                            // "${widget.selectedIds}",
                            style: TextStyle(fontSize: 10),
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ],
              ),
            ),
          ),
          Center(
            child: Container(
              width: 380,
              margin: EdgeInsets.only(top: 30),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Text(
                    "Dengan melanjutkan, Saya setuju dengan Syarat & ketentuan yang berlaku",
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                    ),
                    onPressed: () {
                      Navigator.pushNamed(
                        context, "PembayaranPage", 
                        arguments: {
                          'subtotal': subtotal,
                          'selectedIds': widget.selectedIds,
                        },
                      );
                    },
                    child: Text(
                      "Bayar",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}




// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:flutter_application_1/API/api_connection.dart';
// import 'dart:convert';
// import 'package:intl/intl.dart';

// class CheckoutPage extends StatefulWidget {
//   final List<int> selectedIds;

//   CheckoutPage({required this.selectedIds});

//   @override
//   State<CheckoutPage> createState() => _CheckoutPageState();
// }

// class _CheckoutPageState extends State<CheckoutPage> {
//   List produkYangDibeli = [];

//   Future<void> getAllKeranjangById(int id_pengguna) async {
//     String uri = API.readBerdasarkanIdPengguna;
//     try {
//       var response = await http.post(
//         Uri.parse(uri),
//         body: {
//           'id_pengguna': id_pengguna.toString()
//         }, // Kirim id_laptop sebagai payload
//       );

//       if (response.statusCode == 200) {
//         setState(() {
//           produkYangDibeli = jsonDecode(response.body);
//           // checkedItems = {
//           //   for (var item in dataKeranjang)
//           //     int.parse(item['id_keranjang']): false
//           // };
//         });
//       } else {
//         print('Failed to load data: ${response.reasonPhrase}');
//       }
//     } catch (e) {
//       print('Error: $e');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: Color(0xFFEDECF2),
//         appBar: AppBar(
//           title: Text(
//             "Checkout",
//             style: TextStyle(),
//           ),
//         ),
//         body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//           Center(
//             child: Container(
//               width: 380,
//               // height: 300,
//               margin: EdgeInsets.only(top: 30),
//               padding: EdgeInsets.all(10),
//               decoration: BoxDecoration(
//                   color: Colors.white, borderRadius: BorderRadius.circular(10)),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text("Produk yang akan dibeli",
//                       style: TextStyle(fontWeight: FontWeight.bold)),
//                   SizedBox(
//                     height: 16,
//                   ),

//                   // ATRIBUT
//                   Row(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       Container(
//                         alignment: Alignment.center,
//                         width: 70,
//                         child: Text(
//                           "Produk",
//                           style: TextStyle(fontWeight: FontWeight.bold),
//                         ),
//                       ),
//                       // SizedBox(width: 20),
//                       Container(
//                         alignment: Alignment.center,
//                         width: 110,
//                         child: Text(
//                           "Harga",
//                           style: TextStyle(fontWeight: FontWeight.bold),
//                         ),
//                       ),
//                       // SizedBox(width: 20),
//                       Container(
//                         alignment: Alignment.center,
//                         width: 70,
//                         child: Text(
//                           "Jumlah",
//                           style: TextStyle(fontWeight: FontWeight.bold),
//                         ),
//                       ),
//                       // SizedBox(width: 20),
//                       Container(
//                         alignment: Alignment.center,
//                         width: 110,
//                         child: Text(
//                           "Total",
//                           style: TextStyle(fontWeight: FontWeight.bold),
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(
//                     height: 8,
//                   ),
//                   Row(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       Divider(),
//                       Container(
//                         alignment: Alignment.center,
//                         width: 70,
//                         child: Text(
//                           "Lenovo",
//                           style: TextStyle(fontSize: 10),
//                         ),
//                       ),
//                       // SizedBox(width: 20),
//                       Container(
//                         alignment: Alignment.center,
//                         width: 110,
//                         child: Text(
//                           "Rp. 320.000",
//                           style: TextStyle(fontSize: 10),
//                         ),
//                       ),
//                       // SizedBox(width: 20),
//                       Container(
//                         alignment: Alignment.center,
//                         width: 70,
//                         child: Text(
//                           "1",
//                           style: TextStyle(fontSize: 10),
//                         ),
//                       ),
//                       // SizedBox(width: 20),
//                       Container(
//                         alignment: Alignment.center,
//                         width: 110,
//                         child: Text(
//                           "Rp. 320.000",
//                           style: TextStyle(fontSize: 10),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           Center(
//             child: Container(
//               width: 380,
//               // height: 300,
//               margin: EdgeInsets.only(top: 30),
//               padding: EdgeInsets.all(10),
//               decoration: BoxDecoration(
//                   color: Colors.white, borderRadius: BorderRadius.circular(10)),
//               child: Column(
//                 children: [
//                   Text(
//                       "Dengan melanjutkan, Saya setuju dengan Syarat & ketentuan yang berlaku"),
//                   SizedBox(
//                     height: 20,
//                   ),
//                   ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors.blue),
//                       onPressed: () {
//                         Navigator.pushNamed(context, "PembayaranPage");
//                       },
//                       child: Text(
//                         "Bayar",
//                         style: TextStyle(color: Colors.white),
//                       ))
//                 ],
//               ),
//             ),
//           )
//         ]));
//   }
// }


// import 'package:flutter/material.dart';

// class CheckoutPage extends StatelessWidget {
//   final List<int> selectedIds;

//   CheckoutPage({required this.selectedIds});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Checkout'),
//       ),
//       body: Center(
//         child: Text('Selected IDs: ${selectedIds}'),
//       ),
//     );
//   }
// }
