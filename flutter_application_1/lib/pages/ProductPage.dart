// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:flutter_application_1/API/api_connection.dart';
// import 'dart:convert';
// import 'package:intl/intl.dart'; // Import the intl package
// // import 'package:flutter_application_1/pages_widget/ProductPageWidget.dart';
// // import 'package:flutter_application_1/widgets/SpesifikasiProduct.dart';

// class ProductPage extends StatefulWidget {
//   @override
//   State<ProductPage> createState() => _ProductPageState();
// }

// class _ProductPageState extends State<ProductPage> {
//   List dataLaptopBerdasarkanId = [];

//   @override
//   void initState() {
//     super.initState();
//     // Ambil nilai id_laptop dari argumen dan panggil getAllLaptopById
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       final String? idLaptopString =
//           ModalRoute.of(context)?.settings.arguments as String?;
//       final int idLaptop = int.tryParse(idLaptopString ?? '') ?? 0;
//       getAllLaptopById(idLaptop);
//     });
//   }

//   Future<void> getAllLaptopById(int idLaptop) async {
//     String uri = API.readBerdasarkanId;
//     try {
//       var response = await http.post(
//         Uri.parse(uri),
//         body: {
//           'id_laptop': idLaptop.toString()
//         }, // Kirim id_laptop sebagai payload
//       );

//       if (response.statusCode == 200) {
//         setState(() {
//           dataLaptopBerdasarkanId = jsonDecode(response.body);
//         });
//       } else {
//         print('Failed to load data: ${response.reasonPhrase}');
//       }
//     } catch (e) {
//       print('Error: $e');
//     }
//   }

//   Future<void> addKeranjang(int idLaptop) async {
//     String uri = API.createKeranjang; // Sesuaikan URI dengan endpoint API Anda
//     try {
//       var response = await http.post(
//         Uri.parse(uri),
//         body: {
//           'id_pengguna': '1', // Ganti dengan id_pengguna yang sesuai
//           'id_laptop'  : idLaptop.toString(),
//           'jumlah'     : '1',
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
//                   content: Text(
//                       "Produk berhasil dimasukkan pada keranjang"),
//                   actions: [
//                     FloatingActionButton(
//                       onPressed: () {
//                         Navigator.of(
//                                 context)
//                             .pop();
//                         Navigator.pushNamed(context, "/");
//                       },
//                       child: Text("Oke"),
//                     )
//                   ],
//                 );
//               });
//         } else {
//            showDialog(
//               context: context,
//               builder: (context) {
//                 return AlertDialog(
//                   title: Text("Success"),
//                   content: Text(
//                       "Gagal menambahkan produk ke keranjang"),
//                   actions: [
//                     FloatingActionButton(
//                       onPressed: () {
//                         Navigator.of(
//                                 context)
//                             .pop();
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

//   // Fungsi untuk membagi teks menjadi dua bagian
//   List<String> splitText(String text) {
//     List<String> words = text.split(' ');
//     if (words.length <= 2) {
//       return [text, ''];
//     } else {
//       String firstPart = words.take(2).join(' ');
//       String secondPart = words.skip(2).join(' ');
//       return [firstPart, secondPart];
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     // Mendapatkan id_laptop dari argumen
//     final String? idLaptopString =
//         ModalRoute.of(context)?.settings.arguments as String?;
//     // // Menampilkan nilai idLaptopString untuk debug
//     // print('idLaptopString: $idLaptopString');

//     final int idLaptop = int.tryParse(idLaptopString ?? '') ?? 0;

//     final priceFormatted = NumberFormat.currency(locale: 'id', symbol: 'Rp. ');

//     num price = 0;
//     if (dataLaptopBerdasarkanId[0]['price'] != null) {
//       price = num.tryParse(dataLaptopBerdasarkanId[0]['price'].toString()) ?? 0;
//     }

//     // // Menampilkan nilai idLaptop untuk debug
//     // print('idLaptop: $idLaptop');

//     return Scaffold(
//       backgroundColor: Color(0xFFEDECF2),
//       appBar: AppBar(
//         title: Text(
//           "Product",
//           style: TextStyle(),
//         ),
//       ),
//       body: dataLaptopBerdasarkanId.isEmpty
//           ? Center(child: CircularProgressIndicator())
//           : ListView(
//               children: [
//                 Container(
//                   height: 700,
//                   padding: EdgeInsets.only(top: 15),
//                   decoration: BoxDecoration(
//                       // color: Color.fromARGB(255, 59, 47, 117),
//                       borderRadius: BorderRadius.only(
//                           topLeft: Radius.circular(35),
//                           topRight: Radius.circular(35))),
//                   child: Column(
//                     children: [
//                       // ProductPageWidget(idLaptop: idLaptop),
//                       // SpesifikasiProduct(idLaptop: idLaptop),

//                       // PRODUCT PAGE
//                       Column(
//                         children: [
//                           Container(
//                             height: 160,
//                             margin: EdgeInsets.symmetric(
//                                 horizontal: 15, vertical: 10),
//                             padding: EdgeInsets.all(10),
//                             decoration: BoxDecoration(
//                               color: Colors.white,
//                               borderRadius: BorderRadius.circular(10),
//                             ),
//                             child: Row(
//                               children: [
//                                 Container(
//                                   height: 70,
//                                   width: 70,
//                                   margin: EdgeInsets.only(right: 15),
//                                   child: Image.asset("images/5.png",
//                                       fit: BoxFit.cover),
//                                 ),
//                                 Padding(
//                                   padding: EdgeInsets.symmetric(vertical: 10),
//                                   child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       Text(
//                                         // "Apple Macbook Air",
//                                         dataLaptopBerdasarkanId[0]['product'],
//                                         style: TextStyle(
//                                           fontSize: 18,
//                                           fontWeight: FontWeight.bold,
//                                           color: Color(0xFF4C53A5),
//                                         ),
//                                       ),
//                                       Text(
//                                         // "Sambutlah Apple MacBook Pro ",
//                                         "Sambutlah ${dataLaptopBerdasarkanId[0]['company'] + " " + dataLaptopBerdasarkanId[0]['product']}",
//                                         style: TextStyle(
//                                           fontSize: 14,
//                                           // fontWeight: FontWeight.bold,
//                                           color: Color(0XFF4C53A5),
//                                         ),
//                                       ),
//                                       Row(
//                                         children: [
//                                           Column(
//                                             children: [
//                                               Column(
//                                                 children: [Text("500 terjual")],
//                                               )
//                                             ],
//                                           ),
//                                           SizedBox(width: 20),
//                                           Column(
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.start,
//                                             children: [
//                                               Text(
//                                                 // "Rp. 21.435.000",
//                                                 // "Rp. ${dataLaptopBerdasarkanId[0]['price']}",
//                                                 priceFormatted.format(price),
//                                                 style: TextStyle(
//                                                   fontSize: 12,
//                                                   // fontWeight: FontWeight.bold,
//                                                   color: Color(0XFF4C53A5),
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                         ],
//                                       ),
//                                       Row(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.center,
//                                         children: [
//                                           Container(
//                                             width: 120,
//                                             height: 20,
//                                             child: FloatingActionButton(
//                                               backgroundColor: Colors.white,
//                                               // splashColor: Colors.amber,
//                                               onPressed: () {
//                                                 setState(() {
//                                                   addKeranjang(idLaptop);
//                                                 });

//                                               },
//                                               child: Text(
//                                                 "Masukan Ke Keranjang",
//                                                 style: TextStyle(
//                                                     fontSize: 8,
//                                                     color: Colors.orange),
//                                               ),
//                                             ),
//                                           ),
//                                           SizedBox(
//                                             width: 10,
//                                           ),
//                                           Container(
//                                             width: 120,
//                                             height: 20,
//                                             child: FloatingActionButton(
//                                               backgroundColor: Colors.orange,
//                                               // splashColor: Colors.amber,
//                                               onPressed: () {
//                                                 Navigator.pushNamed(
//                                                   context,
//                                                   "BeliSekarangPage",
//                                                   arguments: idLaptop);
//                                               },
//                                               child: Text(
//                                                 "Beli Sekarang",
//                                                 style: TextStyle(
//                                                     fontSize: 8,
//                                                     color: Colors.white),
//                                               ),
//                                             ),
//                                           )
//                                         ],
//                                       )
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           )
//                         ],
//                       ),

//                       // SPESIFIKASI PRODUK
//                       Container(
//                         // height: 220,
//                         height: 260,
//                         margin:
//                             EdgeInsets.symmetric(horizontal: 15, vertical: 10),
//                         padding: EdgeInsets.all(10),
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text("Spesifikasi Produk"),
//                             SizedBox(
//                               height: 16,
//                             ),
//                             Row(
//                               children: [
//                                 Container(
//                                   width: 100,
//                                   child: Text("Kategori"),
//                                 ),
//                                 SizedBox(width: 140),
//                                 Container(
//                                   child: Text(
//                                       "${dataLaptopBerdasarkanId[0]['model_name']}"),
//                                 )
//                               ],
//                             ),
//                             SizedBox(
//                               height: 8,
//                             ),
//                             Row(
//                               children: [
//                                 Container(
//                                   width: 100,
//                                   child: Text("Brand"),
//                                 ),
//                                 SizedBox(width: 140),
//                                 Container(
//                                   child: Text(
//                                       "${dataLaptopBerdasarkanId[0]['product']}"),
//                                 )
//                               ],
//                             ),
//                             SizedBox(
//                               height: 8,
//                             ),
//                             Row(
//                               children: [
//                                 Container(
//                                   width: 100,
//                                   child: Text("CPU"),
//                                 ),
//                                 SizedBox(width: 140),
//                                 // Container(
//                                 //   child: Text("${dataLaptopBerdasarkanId[0]['cpu']}"),
//                                 // )
//                                 Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: splitText(dataLaptopBerdasarkanId[0]
//                                               ['cpu'] ??
//                                           'Unknown')
//                                       .map((text) => Text(text))
//                                       .toList(),
//                                 ),
//                               ],
//                             ),
//                             SizedBox(
//                               height: 8,
//                             ),
//                             Row(
//                               children: [
//                                 Container(
//                                   width: 100,
//                                   child: Text("Graphic"),
//                                 ),
//                                 SizedBox(width: 140),
//                                 // Container(
//                                 //   child: Text("${dataLaptopBerdasarkanId[0]['gpu']}"),
//                                 // )
//                                 Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: splitText(dataLaptopBerdasarkanId[0]
//                                               ['gpu'] ??
//                                           'Unknown')
//                                       .map((text) => Text(text))
//                                       .toList(),
//                                 ),
//                               ],
//                             ),
//                             SizedBox(
//                               height: 8,
//                             ),
//                             Row(
//                               children: [
//                                 Container(
//                                   width: 100,
//                                   child: Text("Screen"),
//                                 ),
//                                 SizedBox(width: 140),
//                                 Container(
//                                   child: Text(
//                                       "${dataLaptopBerdasarkanId[0]['inches']} inci"),
//                                 )
//                               ],
//                             ),
//                             SizedBox(
//                               height: 8,
//                             ),
//                             Row(
//                               children: [
//                                 Container(
//                                   width: 100,
//                                   child: Text("Stock"),
//                                 ),
//                                 SizedBox(width: 140),
//                                 Container(
//                                   child: Text(
//                                       "${dataLaptopBerdasarkanId[0]['quantity']}"),
//                                 )
//                               ],
//                             ),
//                           ],
//                         ),
//                       )
//                     ],
//                   ),
//                 )
//               ],
//             ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_application_1/API/api_connection.dart';
import 'dart:convert';
import 'package:intl/intl.dart'; // Import the intl package
import 'package:shared_preferences/shared_preferences.dart';

class ProductPage extends StatefulWidget {
  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  List dataLaptopBerdasarkanId = [];
  int? userId;

  @override
  void initState() {
    super.initState();
    // Ambil nilai id_laptop dari argumen dan panggil getAllLaptopById
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final String? idLaptopString =
          ModalRoute.of(context)?.settings.arguments as String?;
      final int idLaptop = int.tryParse(idLaptopString ?? '') ?? 0;
      getAllLaptopById(idLaptop);
    });
  }

  Future<void> getAllLaptopById(int idLaptop) async {
    String uri = API.readBerdasarkanId;
    try {
      var response = await http.post(
        Uri.parse(uri),
        body: {
          'id_laptop': idLaptop.toString()
        }, // Kirim id_laptop sebagai payload
      );

      if (response.statusCode == 200) {
        setState(() {
          dataLaptopBerdasarkanId = jsonDecode(response.body);
        });
      } else {
        print('Failed to load data: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> addKeranjang(int idLaptop) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? userId = prefs.getInt('id_pengguna');
    String uri = API.createKeranjang; // Sesuaikan URI dengan endpoint API Anda
    try {
      var response = await http.post(
        Uri.parse(uri),
        body: {
          'id_pengguna': userId.toString(), // Ganti dengan id_pengguna yang sesuai
          'id_laptop': idLaptop.toString(),
          'jumlah': '1',
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
                  content: Text("Produk berhasil dimasukkan pada keranjang"),
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
        } else {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text("Success"),
                  content: Text("Gagal menambahkan produk ke keranjang"),
                  actions: [
                    FloatingActionButton(
                      onPressed: () {
                        Navigator.of(context).pop();
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

  // Fungsi untuk membagi teks menjadi dua bagian
  List<String> splitText(String text) {
    List<String> words = text.split(' ');
    if (words.length <= 2) {
      return [text, ''];
    } else {
      String firstPart = words.take(2).join(' ');
      String secondPart = words.skip(2).join(' ');
      return [firstPart, secondPart];
    }
  }

  @override
  Widget build(BuildContext context) {
    // Mendapatkan id_laptop dari argumen
    final String? idLaptopString =
        ModalRoute.of(context)?.settings.arguments as String?;
    final int idLaptop = int.tryParse(idLaptopString ?? '') ?? 0;

    final priceFormatted = NumberFormat.currency(locale: 'id', symbol: 'Rp. ');

    num price = 0;
    if (dataLaptopBerdasarkanId.isNotEmpty &&
        dataLaptopBerdasarkanId[0]['price'] != null) {
      price = num.tryParse(dataLaptopBerdasarkanId[0]['price'].toString()) ?? 0;
    }

    return Scaffold(
      backgroundColor: Color(0xFFEDECF2),
      appBar: AppBar(
        title: Text(
          "Product",
          style: TextStyle(),
        ),
      ),
      body: dataLaptopBerdasarkanId.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView(
              children: [
                Container(
                  height: 700,
                  padding: EdgeInsets.only(top: 15),
                  decoration: BoxDecoration(
                      // color: Color.fromARGB(255, 59, 47, 117),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(35),
                          topRight: Radius.circular(35))),
                  child: Column(
                    children: [
                      // PRODUCT PAGE
                      Column(
                        children: [
                          Container(
                            height: 160,
                            margin: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 10),
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  height: 70,
                                  width: 70,
                                  margin: EdgeInsets.only(right: 15),
                                  child: Image.asset("images/5.png",
                                      fit: BoxFit.cover),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        dataLaptopBerdasarkanId[0]['product'],
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF4C53A5),
                                        ),
                                      ),
                                      Text(
                                        "Sambutlah ${dataLaptopBerdasarkanId[0]['company'] + " " + dataLaptopBerdasarkanId[0]['product']}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Color(0XFF4C53A5),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Column(
                                            children: [
                                              Column(
                                                children: [Text("500 terjual")],
                                              )
                                            ],
                                          ),
                                          SizedBox(width: 20),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                priceFormatted.format(price),
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: Color(0XFF4C53A5),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: 120,
                                            height: 20,
                                            child: FloatingActionButton(
                                              backgroundColor: Colors.white,
                                              onPressed: () {
                                                setState(() {
                                                  addKeranjang(idLaptop);
                                                });
                                              },
                                              child: Text(
                                                "Masukan Ke Keranjang",
                                                style: TextStyle(
                                                    fontSize: 8,
                                                    color: Colors.orange),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Container(
                                            width: 120,
                                            height: 20,
                                            child: FloatingActionButton(
                                              backgroundColor: Colors.orange,
                                              onPressed: () {
                                                Navigator.pushNamed(
                                                  context,
                                                  "BeliSekarangPage",
                                                  arguments: idLaptop,
                                                );
                                              },
                                              child: Text(
                                                "Beli Sekarang",
                                                style: TextStyle(
                                                    fontSize: 8,
                                                    color: Colors.white),
                                              ),
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),

                      // SPESIFIKASI PRODUK
                      Container(
                        height: 260,
                        margin:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Spesifikasi Produk"),
                            SizedBox(
                              height: 16,
                            ),
                            Row(
                              children: [
                                Container(
                                  width: 100,
                                  child: Text("Kategori"),
                                ),
                                SizedBox(width: 140),
                                Container(
                                  child: Text(
                                      "${dataLaptopBerdasarkanId[0]['model_name']}"),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Row(
                              children: [
                                Container(
                                  width: 100,
                                  child: Text("Brand"),
                                ),
                                SizedBox(width: 140),
                                Container(
                                  child: Text(
                                      "${dataLaptopBerdasarkanId[0]['product']}"),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Row(
                              children: [
                                Container(
                                  width: 100,
                                  child: Text("CPU"),
                                ),
                                SizedBox(width: 140),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: splitText(dataLaptopBerdasarkanId[0]
                                              ['cpu'] ??
                                          'Unknown')
                                      .map((text) => Text(text))
                                      .toList(),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Row(
                              children: [
                                Container(
                                  width: 100,
                                  child: Text("Graphic"),
                                ),
                                SizedBox(width: 140),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: splitText(dataLaptopBerdasarkanId[0]
                                              ['gpu'] ??
                                          'Unknown')
                                      .map((text) => Text(text))
                                      .toList(),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Row(
                              children: [
                                Container(
                                  width: 100,
                                  child: Text("Screen"),
                                ),
                                SizedBox(width: 140),
                                Container(
                                  child: Text(
                                      "${dataLaptopBerdasarkanId[0]['inches']} inci"),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Row(
                              children: [
                                Container(
                                  width: 100,
                                  child: Text("Stock"),
                                ),
                                SizedBox(width: 140),
                                Container(
                                  child: Text(
                                      "${dataLaptopBerdasarkanId[0]['quantity']}"),
                                )
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
    );
  }
}
