// import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/API/api_connection.dart';
import 'package:http/http.dart' as http;

// class ProductWidget extends StatefulWidget {
//   @override
//   State<ProductWidget> createState() => _ProductWidgetState();
// }

// class _ProductWidgetState extends State<ProductWidget> {
//   List allLaptop = [];

//   Future<void> getAllLaptop() async {
//     String uri = API.readDatasetLaptop;
//     try {
//       var response = await http.get(Uri.parse(uri));

//       setState(() {
//         allLaptop = jsonDecode(response.body);
//       });
//     } catch (e) {
//       print(e);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GridView.count(
//       childAspectRatio: 0.68,

//       // untuk dapat melakukan scroll
//       // physics: NeverScrollableScrollPhysics(),
//       crossAxisCount: 2,
//       shrinkWrap: true,
//       children: [
//         for (int i = 1; i < 8; i++)
//           Container(
//             padding: EdgeInsets.only(left: 15, right: 15, top: 10),
//             margin: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(20),
//             ),
//             child: Column(
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Container(
//                         padding: EdgeInsets.all(5),
//                         decoration: BoxDecoration(
//                           // color: Color(0xFF4C53A5),
//                           borderRadius: BorderRadius.circular(20),
//                         ),
//                         child: Column(
//                           children: [
//                             InkWell(
//                               // - - - (Berpindah ke halaman ProductPage) - - -
//                               onTap: () {
//                                 Navigator.pushNamed(context, "ProductPage");
//                               },
//                               child: Container(
//                                 margin: EdgeInsets.all(10),
//                                 child: Image.asset(
//                                   "images/LAP1.png",
//                                   width: 110,
//                                   height: 120,
//                                 ),
//                               ),
//                             ),
//                             Container(
//                               padding: EdgeInsets.only(bottom: 8),
//                               alignment: Alignment.centerLeft,
//                               child: Text(
//                                 "Apple Macbook Air",
//                                 style: TextStyle(
//                                   fontSize: 13,
//                                   color: Colors.black,
//                                   // fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ),
//                             Container(
//                               alignment: Alignment.centerLeft,
//                               child: Text(
//                                 "Rp. 14.383.000",
//                                 style: TextStyle(
//                                   fontSize: 16,
//                                   color: Color.fromARGB(255, 255, 136, 0),
//                                   // fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ),
//                             Padding(
//                               padding: EdgeInsets.symmetric(vertical: 10),
//                               child: Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   SizedBox(width: 10),
//                                   Text(
//                                     "500 terjual",
//                                     style: TextStyle(
//                                       fontSize: 14,
//                                       color: Colors.grey,
//                                     ),
//                                   )
//                                 ],
//                               ),
//                             )
//                           ],
//                         ))
//                   ],
//                 )
//               ],
//             ),
//           )
//       ],
//     );
//   }
// }


import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/API/api_connection.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';  // Import the intl package

class ProductWidget extends StatefulWidget {
  @override
  State<ProductWidget> createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget> {
  List allLaptop = [];

  @override
  void initState() {
    super.initState();
    getAllLaptop();
  }

  Future<void> getAllLaptop() async {
    String uri = API.readDatasetLaptop;
    try {
      var response = await http.get(Uri.parse(uri));

      if (response.statusCode == 200) {
        setState(() {
          allLaptop = jsonDecode(response.body);
        });
      } else {
        print('Failed to load data');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final NumberFormat currencyFormatter = NumberFormat.currency(locale: 'id', symbol: 'Rp. ');

    return GridView.count(
      childAspectRatio: 0.68,
      crossAxisCount: 2,
      shrinkWrap: true,
      children: List.generate(
        allLaptop.length, (index) {
        var laptop = allLaptop[index];

         // Konversi harga menjadi angka jika berupa string
        num price = 0;
        if (laptop['price'] != null) {
          price = num.tryParse(laptop['price'].toString()) ?? 0;
        }
        return Container(
          padding: EdgeInsets.only(left: 15, right: 15, top: 10),
          margin: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, "ProductPage", arguments: laptop['id_laptop']);
                          },
                          child: Container(
                            margin: EdgeInsets.all(10),
                            child: Image.asset(
                              "images/LAP1.png",
                              width: 110,
                              height: 120,
                              errorBuilder: (context, error, stackTrace) {
                                return Icon(Icons.error);
                              },
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(bottom: 8),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            laptop['product'] ?? 'Unknown',
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            currencyFormatter.format(price),
                            style: TextStyle(
                              fontSize: 16,
                              color: Color.fromARGB(255, 255, 136, 0),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(width: 10),
                              Text(
                                "0 terjual",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        );
      }),
    );
  }
}
