// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:flutter_application_1/API/api_connection.dart';
// import 'dart:convert';
// import 'package:intl/intl.dart';

// class CartItem extends StatefulWidget {
//   @override
//   State<CartItem> createState() => _CartItemState();
// }

// class _CartItemState extends State<CartItem> {
//   List dataKeranjang = [];
//   int jumlah = 1;

//   // void _tambahJumlahBarang(int index) {
//   //   setState(() {
//   //     jumlah++;
//   //   });
//   // }

//   // void _kurangJumlahBarang(int index) {
//   //   setState(() {
//   //     if (jumlah > 1) {
//   //       jumlah--;
//   //     }
//   //   });
//   // }

//   void _tambahJumlahBarang(int index) {
//     setState(() {
//       dataKeranjang[index]['jumlah'] =
//           (int.parse(dataKeranjang[index]['jumlah'].toString()) + 1).toString();
//     });
//   }

//   void _kurangJumlahBarang(int index) {
//     setState(() {
//       if (int.parse(dataKeranjang[index]['jumlah'].toString()) > 1) {
//         dataKeranjang[index]['jumlah'] =
//             (int.parse(dataKeranjang[index]['jumlah'].toString()) - 1)
//                 .toString();
//       }
//     });
//   }

//   @override
//   void initState() {
//     super.initState();
//     // Ambil nilai id_laptop dari argumen dan panggil getAllLaptopById

//     getAllKeranjang(1);
//   }

//   Future<void> getAllKeranjang(int id_pengguna) async {
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
//           dataKeranjang = jsonDecode(response.body);
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
//     // return GridView.count(
//     //   crossAxisCount: 1,
//     //   shrinkWrap: true,
//     //   children: List.generate(dataKeranjang.length, (index) {
//     //     var keranjang = dataKeranjang[index];
//     //     setState(() {
//     //       // jumlah = keranjang['jumlah'];
//     //       jumlah = int.tryParse(keranjang['jumlah'].toString()) ?? 1;
//     //     });
//     //     return Container(
//     //       height: 110,
//     //       margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
//     //       padding: EdgeInsets.all(10),
//     //       decoration: BoxDecoration(
//     //         color: Colors.white,
//     //         borderRadius: BorderRadius.circular(10),
//     //       ),
//     //       child: Row(
//     //         children: [
//     //           Container(
//     //             height: 70,
//     //             width: 70,
//     //             margin: EdgeInsets.only(right: 15),
//     //             child: Image.asset("images/5.png", fit: BoxFit.cover),
//     //           ),
//     //           Padding(
//     //             padding: EdgeInsets.symmetric(vertical: 10),
//     //             child: Column(
//     //               crossAxisAlignment: CrossAxisAlignment.start,
//     //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//     //               children: [
//     //                 Text(
//     //                   // "Apple Macbook Air",
//     //                   keranjang['product'],
//     //                   style: TextStyle(
//     //                     fontSize: 18,
//     //                     fontWeight: FontWeight.bold,
//     //                     color: Color(0xFF4C53A5),
//     //                   ),
//     //                 ),
//     //                 Text(
//     //                   // "\Rp.14.383.000",
//     //                   keranjang['price'],
//     //                   style: TextStyle(
//     //                     fontSize: 14,
//     //                     fontWeight: FontWeight.bold,
//     //                     color: Color(0XFF4C53A5),
//     //                   ),
//     //                 )
//     //               ],
//     //             ),
//     //           ),
//     //           Spacer(),
//     //           Padding(
//     //             padding: EdgeInsets.symmetric(vertical: 5),
//     //             child: Column(
//     //               crossAxisAlignment: CrossAxisAlignment.end,
//     //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//     //               children: [
//     //                 ElevatedButton(
//     //                   onPressed: () {},
//     //                   child: Icon(
//     //                     Icons.delete,
//     //                     color: Color(0xFF4C53A5),
//     //                   ),
//     //                 ),
//     //                 Row(
//     //                   children: [
//     //                     Container(
//     //                       width: 40,
//     //                       height: 40,
//     //                       decoration: BoxDecoration(
//     //                           color: Colors.white,
//     //                           borderRadius: BorderRadius.circular(20),
//     //                           boxShadow: [
//     //                             BoxShadow(
//     //                               color: Colors.grey.withOpacity(0.5),
//     //                               spreadRadius: 1,
//     //                               blurRadius: 10,
//     //                             )
//     //                           ]),
//     //                       child: FloatingActionButton(
//     //                         backgroundColor: Colors.blue,
//     //                         onPressed: () => _tambahJumlahBarang(jumlah),
//     //                         child: Icon(
//     //                           CupertinoIcons.plus,
//     //                           size: 16,
//     //                           color: Colors.white,
//     //                         ),
//     //                       ),
//     //                     ),
//     //                     Container(
//     //                       margin: EdgeInsets.symmetric(horizontal: 10),
//     //                       child: Text(
//     //                         "${jumlah}",
//     //                         style: TextStyle(
//     //                           fontSize: 14,
//     //                           fontWeight: FontWeight.bold,
//     //                           color: Color(0xFF4C53A5),
//     //                         ),
//     //                       ),
//     //                     ),
//     //                     Container(
//     //                       width: 40,
//     //                       height: 40,
//     //                       decoration: BoxDecoration(
//     //                           color: Colors.white,
//     //                           borderRadius: BorderRadius.circular(20),
//     //                           boxShadow: [
//     //                             BoxShadow(
//     //                               color: Colors.grey.withOpacity(0.5),
//     //                               spreadRadius: 1,
//     //                               blurRadius: 10,
//     //                             )
//     //                           ]),
//     //                       child: FloatingActionButton(
//     //                         backgroundColor: Colors.blue,
//     //                         onPressed: () => _kurangJumlahBarang(jumlah),
//     //                         child: Icon(
//     //                           CupertinoIcons.minus,
//     //                           size: 16,
//     //                           color: Colors.white,
//     //                         ),
//     //                       ),
//     //                     ),
//     //                   ],
//     //                 )
//     //               ],
//     //             ),
//     //           )
//     //         ],
//     //       ),
//     //     );
//     //   }),
//     // );

//     return Column(
//         children: List.generate(dataKeranjang.length, (index) {
//       var keranjang = dataKeranjang[index];
//       setState(() {
//         // jumlah = keranjang['jumlah'];
//         jumlah = int.tryParse(keranjang['jumlah'].toString()) ?? 1;
//       });
//       // for (int i = 0; i < 3; i++)
//       return Container(
//         height: 110,
//         margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
//         padding: EdgeInsets.all(10),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(10),
//         ),
//         child: Row(
//           children: [
//             Container(
//               height: 70,
//               width: 70,
//               margin: EdgeInsets.only(right: 15),
//               child: Image.asset("images/5.png", fit: BoxFit.cover),
//             ),
//             Padding(
//               padding: EdgeInsets.symmetric(vertical: 10),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     // "Apple Macbook Air",
//                     keranjang['product'],
//                     style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                       color: Color(0xFF4C53A5),
//                     ),
//                   ),
//                   Text(
//                     // "\Rp.14.383.000",
//                     "Rp. ${keranjang['price']}",
//                     style: TextStyle(
//                       fontSize: 14,
//                       fontWeight: FontWeight.bold,
//                       color: Color(0XFF4C53A5),
//                     ),
//                   )
//                 ],
//               ),
//             ),
//             Spacer(),
//             Padding(
//               padding: EdgeInsets.symmetric(vertical: 5),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.end,
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   ElevatedButton(
//                     onPressed: () {},
//                     child: Icon(
//                       Icons.delete,
//                       color: Color(0xFF4C53A5),
//                     ),
//                   ),
//                   Row(
//                     children: [
//                       Container(
//                         width: 40,
//                         height: 40,
//                         decoration: BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: BorderRadius.circular(20),
//                             boxShadow: [
//                               BoxShadow(
//                                 color: Colors.grey.withOpacity(0.5),
//                                 spreadRadius: 1,
//                                 blurRadius: 10,
//                               )
//                             ]),
//                         child: FloatingActionButton(
//                           backgroundColor: Colors.blue,
//                           onPressed: () => _tambahJumlahBarang(index),
//                           child: Icon(
//                             CupertinoIcons.plus,
//                             size: 16,
//                             color: Colors.white,
//                           ),
//                         ),
//                       ),
//                       Container(
//                         margin: EdgeInsets.symmetric(horizontal: 10),
//                         child: Text(
//                           "${jumlah}",
//                           style: TextStyle(
//                             fontSize: 14,
//                             fontWeight: FontWeight.bold,
//                             color: Color(0xFF4C53A5),
//                           ),
//                         ),
//                       ),
//                       Container(
//                         width: 40,
//                         height: 40,
//                         decoration: BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: BorderRadius.circular(20),
//                             boxShadow: [
//                               BoxShadow(
//                                 color: Colors.grey.withOpacity(0.5),
//                                 spreadRadius: 1,
//                                 blurRadius: 10,
//                               )
//                             ]),
//                         child: FloatingActionButton(
//                           backgroundColor: Colors.blue,
//                           onPressed: () => _kurangJumlahBarang(index),
//                           child: Icon(
//                             CupertinoIcons.minus,
//                             size: 16,
//                             color: Colors.white,
//                           ),
//                         ),
//                       ),
//                     ],
//                   )
//                 ],
//               ),
//             )
//           ],
//         ),
//       );
//     }));

//     // return Column(
//     //   children: [
//     //     // for (int i = 0; i < 3; i++)
//     //       Container(
//     //         height: 110,
//     //         margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
//     //         padding: EdgeInsets.all(10),
//     //         decoration: BoxDecoration(
//     //           color: Colors.white,
//     //           borderRadius: BorderRadius.circular(10),
//     //         ),
//     //         child: Row(
//     //           children: [
//     //             Container(
//     //               height: 70,
//     //               width: 70,
//     //               margin: EdgeInsets.only(right: 15),
//     //               child: Image.asset("images/5.png", fit: BoxFit.cover),
//     //             ),
//     //             Padding(
//     //               padding: EdgeInsets.symmetric(vertical: 10),
//     //               child: Column(
//     //                 crossAxisAlignment: CrossAxisAlignment.start,
//     //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//     //                 children: [
//     //                   Text(
//     //                     "Apple Macbook Air",
//     //                     style: TextStyle(
//     //                       fontSize: 18,
//     //                       fontWeight: FontWeight.bold,
//     //                       color: Color(0xFF4C53A5),
//     //                     ),
//     //                   ),
//     //                   Text(
//     //                     "\Rp.14.383.000",
//     //                     style: TextStyle(
//     //                       fontSize: 14,
//     //                       fontWeight: FontWeight.bold,
//     //                       color: Color(0XFF4C53A5),
//     //                     ),
//     //                   )
//     //                 ],
//     //               ),
//     //             ),
//     //             Spacer(),
//     //             Padding(
//     //               padding: EdgeInsets.symmetric(vertical: 5),
//     //               child: Column(
//     //                 crossAxisAlignment: CrossAxisAlignment.end,
//     //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//     //                 children: [
//     //                   ElevatedButton(
//     //                     onPressed: () {

//     //                     },
//     //                     child: Icon(
//     //                       Icons.delete,
//     //                       color: Color(0xFF4C53A5),
//     //                     ),
//     //                   ),
//     //                   Row(
//     //                     children: [
//     //                       Container(
//     //                         width: 40,
//     //                         height: 40,
//     //                         decoration: BoxDecoration(
//     //                             color: Colors.white,
//     //                             borderRadius: BorderRadius.circular(20),
//     //                             boxShadow: [
//     //                               BoxShadow(
//     //                                 color: Colors.grey.withOpacity(0.5),
//     //                                 spreadRadius: 1,
//     //                                 blurRadius: 10,
//     //                               )
//     //                             ]),
//     //                         child: FloatingActionButton(
//     //                           backgroundColor: Colors.blue,
//     //                           onPressed: () =>
//     //                           _tambahJumlahBarang(i),
//     //                           child: Icon(
//     //                             CupertinoIcons.plus,
//     //                             size: 16,
//     //                             color: Colors.white,
//     //                           ),
//     //                         ),
//     //                       ),
//     //                       Container(
//     //                         margin: EdgeInsets.symmetric(horizontal: 10),
//     //                         child: Text(
//     //                           "${jumlah_barang[i]}",
//     //                           style: TextStyle(
//     //                             fontSize: 14,
//     //                             fontWeight: FontWeight.bold,
//     //                             color: Color(0xFF4C53A5),
//     //                           ),
//     //                         ),
//     //                       ),
//     //                       Container(
//     //                         width: 40,
//     //                         height: 40,
//     //                         decoration: BoxDecoration(
//     //                             color: Colors.white,
//     //                             borderRadius: BorderRadius.circular(20),
//     //                             boxShadow: [
//     //                               BoxShadow(
//     //                                 color: Colors.grey.withOpacity(0.5),
//     //                                 spreadRadius: 1,
//     //                                 blurRadius: 10,
//     //                               )
//     //                             ]),
//     //                         child: FloatingActionButton(
//     //                           backgroundColor: Colors.blue,
//     //                           onPressed: () => _kurangJumlahBarang(i),
//     //                           child: Icon(
//     //                             CupertinoIcons.minus,
//     //                             size: 16,
//     //                             color: Colors.white,
//     //                           ),
//     //                         ),
//     //                       ),
//     //                     ],
//     //                   )
//     //                 ],
//     //               ),
//     //             )
//     //           ],
//     //         ),
//     //       )
//     //   ],
//     // );
//   }
// }

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/CheckoutPage.dart';
import 'package:flutter_application_1/pages/EditKeranjangPage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_application_1/API/api_connection.dart';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartItem extends StatefulWidget {
  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  List dataKeranjang = [];
  Map<int, bool> checkedItems = {};
  int? userId;

  @override
  void initState() {
    super.initState();
    // Ambil nilai id_laptop dari argumen dan panggil getAllLaptopById

    getAllKeranjang();
  }

  Future<void> getAllKeranjang() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? userId = prefs.getInt('id_pengguna');
    String uri = API.readBerdasarkanIdPengguna;
    try {
      var response = await http.post(
        Uri.parse(uri),
        body: {
          'id_pengguna': userId.toString()
        }, // Kirim id_laptop sebagai payload
      );

      if (response.statusCode == 200) {
        setState(() {
          dataKeranjang = jsonDecode(response.body);
          checkedItems = {
            for (var item in dataKeranjang)
              int.parse(item['id_keranjang']): false
          };
        });
      } else {
        print('Failed to load data: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> deleteKeranjang(int idKeranjang) async {
    String uri = API.deleteKeranjang; // Sesuaikan URI dengan endpoint API Anda
    try {
      var response = await http.post(
        Uri.parse(uri),
        body: {
          'id_keranjang':
              idKeranjang.toString(), // Ganti dengan id_pengguna yang sesuai
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
                  content: Text("Produk berhasil dihapus pada keranjang"),
                  actions: [
                    FloatingActionButton(
                      onPressed: () {
                        // Navigator.of(context).pop();
                        // Navigator.of(context).pop();
                        Navigator.of(context).pushNamed('/');
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
                  content: Text("Gagal menghapus produk pada keranjang "),
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

  void _confirmDeleteKeranjang(int idKeranjang) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Konfirmasi'),
          content: Text(
              'Apakah Anda yakin ingin menghapus produk ini dari keranjang?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Batal'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                deleteKeranjang(idKeranjang);
              },
              child: Text('Hapus'),
            ),
          ],
        );
      },
    );
  }

  void _checkout() {
    List<int> selectedIds = checkedItems.entries
        .where((entry) => entry.value)
        .map((entry) => entry.key)
        .toList();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CheckoutPage(selectedIds: selectedIds),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final priceFormatted = NumberFormat.currency(locale: 'id', symbol: 'Rp. ');

    return Column(
      children: [
        Column(
            children: List.generate(dataKeranjang.length, (index) {
          var keranjang = dataKeranjang[index];

          num price = 0;
          if (keranjang['price'] != null) {
            price = num.tryParse(keranjang['price'].toString()) ?? 1;
          }

          int idKeranjang = int.parse(keranjang['id_keranjang']);

          // for (int i = 0; i < 3; i++)
          return Container(
            height: 110,
            margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Checkbox(
                  value: checkedItems[idKeranjang] ?? false,
                  onChanged: (bool? value) {
                    setState(() {
                      checkedItems[idKeranjang] = value ?? false;
                    });
                  },
                ),
                Container(
                  height: 70,
                  width: 70,
                  margin: EdgeInsets.only(right: 15),
                  child: Image.asset("images/5.png", fit: BoxFit.cover),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        // "Apple Macbook Air",
                        keranjang['product'],
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF4C53A5),
                        ),
                      ),
                      Text(
                        // "\Rp.14.383.000",
                        // "Rp. ${keranjang['price']}",
                        priceFormatted.format(price),
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Color(0XFF4C53A5),
                        ),
                      )
                    ],
                  ),
                ),
                Spacer(),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // ElevatedButton(
                      //   onPressed: () {
                      //     Navigator.push(
                      //       context,
                      //       MaterialPageRoute(
                      //         builder: (context) =>
                      //             EditKeranjangPage(idKeranjang: idKeranjang),
                      //       ),
                      //     );
                      //   },
                      //   child: Icon(Icons.edit, color: Colors.black, size: 15),
                      //   style: ElevatedButton.styleFrom(
                      //     // alignment: Alignment.center,
                      //     backgroundColor: Colors.blue,
                      //     minimumSize: Size(35, 35),
                      //     fixedSize: Size(35, 35),
                      //   ),
                      // ),
                      // SizedBox(width: 10),
                      // Text("${keranjang['jumlah']}"),
                      // SizedBox(width: 10),
                      // ElevatedButton(
                      //   onPressed: () {
                      //     setState(() {
                      //       // deleteKeranjang(idKeranjang);
                      //        _confirmDeleteKeranjang(idKeranjang);
                      //     });
                      //   },
                      //   child: Icon(
                      //     Icons.delete,
                      //     color: Color(0xFF4C53A5),
                      //   ),
                      //   style: ElevatedButton.styleFrom(
                      //     // alignment: Alignment.center,

                      //     minimumSize: Size(35, 35),
                      //     fixedSize: Size(35, 35),
                      //   ),
                      // ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors
                              .blue, // Ubah warna background sesuai keinginan Anda
                          shape: BoxShape.circle, // Membuat bentuk lingkaran
                        ),
                        child: IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    EditKeranjangPage(idKeranjang: idKeranjang),
                              ),
                            );
                          },
                          icon: Icon(Icons.edit, color: Colors.white, size: 20),
                        ),
                      ),
                      SizedBox(width: 10),
                      Text("${keranjang['jumlah']}"),
                      SizedBox(width: 10),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors
                              .orange, // Ubah warna background sesuai keinginan Anda
                          shape: BoxShape.circle, // Membuat bentuk lingkaran
                        ),
                        child: IconButton(
                          onPressed: () {
                            setState(() {
                              _confirmDeleteKeranjang(idKeranjang);
                            });
                          },
                          icon: Icon(
                            Icons.delete,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        })),
        Container(
          child: ElevatedButton(
            onPressed: _checkout,
            child: Text(
              'Checkout',
              style: TextStyle(color: Colors.white),
            ),
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 15),
              fixedSize: Size(120, 40),
              textStyle: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          
        ),
      ],
    );
  }
}
