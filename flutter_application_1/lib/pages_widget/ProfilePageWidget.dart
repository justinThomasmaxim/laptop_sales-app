// import 'package:flutter/material.dart';
// import 'package:flutter_application_1/widgets/HomeAppBar.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:flutter_application_1/API/api_connection.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// class ProfilePageWidget extends StatefulWidget {
//   final int? idPengguna;
//   // final bool isPelanggan;

//   // ProfilePageWidget({required this.idPengguna, required this.isPelanggan});
//   ProfilePageWidget({required this.idPengguna});

//   @override
//   State<ProfilePageWidget> createState() => _ProfilePageWidgetState();
// }

// class _ProfilePageWidgetState extends State<ProfilePageWidget> {
//   List dataPengguna = [];

//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       int? id_pengguna = widget.idPengguna;
//       getPenggunaById(id_pengguna);
//     });

//     // getPenggunaById(widget.idPengguna);
//   }

//   Future<void> getPenggunaById(int? id_pengguna) async {
//     String uri = API.readByIdPengguna; // Perbarui dengan endpoint yang sesuai
//     try {
//       var response = await http.post(
//         Uri.parse(uri),
//         body: {
//           'id_pengguna': id_pengguna.toString(),
//         },
//       );

//       if (response.statusCode == 200) {
//         setState(() {
//           dataPengguna = jsonDecode(response.body);
//         });
//       } else {
//         print('Gagal memuat data: ${response.reasonPhrase}');
//       }
//     } catch (e) {
//       print('Error: $e');
//     }
//   }


//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Row(
//           children: [HomeAppBar(), Text("Profile")],
//         ),
//         Container(
//           height: 756,
//           padding: EdgeInsets.only(top: 15),
//           decoration: BoxDecoration(
//               color: Color(0xFFEDECF2),
//               borderRadius: BorderRadius.only(
//                 topLeft: Radius.circular(35),
//                 topRight: Radius.circular(35),
//               )),
//           child: SingleChildScrollView(
//             child: Container(
//               padding: EdgeInsets.all(10),
//               child: Column(
//                 children: [
//                   SizedBox(
//                     width: 120,
//                     height: 120,
//                     child: ClipRRect(
//                         borderRadius: BorderRadius.circular(100),
//                         child: Image(image: AssetImage("images/profile.png"))),
//                   ),
//                   SizedBox(
//                     height: 10,
//                   ),
//                   Text(
//                     // "Pengguna ${widget.idPengguna}",
//                     "${dataPengguna[0]['username']}",
//                     style: Theme.of(context).textTheme.headlineMedium,
//                   ),
//                   Text(
//                     // "Email@gmail.com",
//                     "${dataPengguna[0]['email']}",
//                     style: Theme.of(context).textTheme.bodyMedium,
//                   ),
//                   SizedBox(
//                     height: 20,
//                   ),
//                   SizedBox(
//                     width: 200,
//                     child: ElevatedButton(
//                       onPressed: () {
//                         Navigator.pushNamed(context, "EditProfilePage");
//                       },
//                       style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors.orange,
//                           side: BorderSide.none,
//                           shape: StadiumBorder()),
//                       child: Text(
//                         "Edit Profile",
//                         style: TextStyle(color: Colors.black),
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 30),
//                   Divider(),
//                   SizedBox(height: 10),

//                   // MENU
//                   ElevatedButton(
//                     onPressed: () {
//                       Navigator.pushNamed(context, "RiwayatTransaksiPage");
//                     },
//                     child: ListTile(
//                       leading: Container(
//                         width: 40,
//                         height: 40,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(100),
//                           color: Color.fromARGB(255, 98, 141, 214)
//                               .withOpacity(0.1),
//                         ),
//                         child: Icon(
//                           Icons.point_of_sale,
//                           color: Color.fromARGB(255, 98, 141, 214),
//                         ),
//                       ),
//                       title: Text("Riwayat Transaksi",
//                           style: Theme.of(context).textTheme.bodyLarge),
//                     ),
//                   ),
//                   SizedBox(height: 5),
//                   ElevatedButton(
//                     onPressed: () async {
//                       // HttpDatasetLaptop.connectAPI();
//                       SharedPreferences prefs =
//                           await SharedPreferences.getInstance();
//                       await prefs.remove('id_pengguna');

//                       Navigator.pushReplacementNamed(context, 'LoginPage');
//                     },
//                     child: ListTile(
//                       leading: Container(
//                         width: 40,
//                         height: 40,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(100),
//                           color: Color.fromARGB(255, 98, 141, 214)
//                               .withOpacity(0.1),
//                         ),
//                         child: Icon(
//                           Icons.logout,
//                           color: Color.fromARGB(255, 98, 141, 214),
//                         ),
//                       ),
//                       title: Text("Logout",
//                           style: Theme.of(context).textTheme.bodyLarge),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         )
//       ],
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/HomeAppBar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_application_1/API/api_connection.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProfilePageWidget extends StatefulWidget {
  final int? idPengguna;

  ProfilePageWidget({required this.idPengguna});

  @override
  State<ProfilePageWidget> createState() => _ProfilePageWidgetState();
}

class _ProfilePageWidgetState extends State<ProfilePageWidget> {
  Map<String, dynamic> dataPengguna = {};
  Map<String, dynamic> dataPelanggan = {};
  bool hasProfile = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      int? id_pengguna = widget.idPengguna;
      getPenggunaById(id_pengguna);
    });
  }

  Future<void> getPenggunaById(int? id_pengguna) async {
    String uriPengguna = API.readByIdPengguna; // Endpoint untuk mendapatkan data pengguna
    String uriPelanggan = API.readPelangganById; // Endpoint untuk mendapatkan data pelanggan

    try {
      // Fetch data pengguna
      var responsePengguna = await http.post(
        Uri.parse(uriPengguna),
        body: {'id_pengguna': id_pengguna.toString()},
      );

      if (responsePengguna.statusCode == 200) {
        var penggunaResponse = jsonDecode(responsePengguna.body);
        if (penggunaResponse.isNotEmpty) {
          setState(() {
            dataPengguna = penggunaResponse[0];
          });
        }
      } else {
        print('Gagal memuat data pengguna: ${responsePengguna.reasonPhrase}');
      }

      // Fetch data pelanggan
      var responsePelanggan = await http.post(
        Uri.parse(uriPelanggan),
        body: {'id_pengguna': id_pengguna.toString()},
      );

      if (responsePelanggan.statusCode == 200) {
        var pelangganResponse = jsonDecode(responsePelanggan.body);
        if (pelangganResponse.isNotEmpty) {
          setState(() {
            dataPelanggan = pelangganResponse[0];
            hasProfile = true;
          });
        }
      } else {
        print('Gagal memuat data pelanggan: ${responsePelanggan.reasonPhrase}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [HomeAppBar(), Text("Profile")],
        ),
        Container(
          height: 756,
          padding: EdgeInsets.only(top: 15),
          decoration: BoxDecoration(
              color: Color(0xFFEDECF2),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(35),
                topRight: Radius.circular(35),
              )),
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  SizedBox(
                    width: 120,
                    height: 120,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image(image: AssetImage("images/profile.png"))),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    hasProfile 
                      ? dataPelanggan['nama_pelanggan'] ?? 'Nama Pelanggan Tidak Diketahui'
                      : dataPengguna['username'] ?? 'Username Tidak Diketahui',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  Text(
                    dataPengguna['email'] ?? 'Email Tidak Diketahui',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: 200,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, "EditProfilePage");
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                          side: BorderSide.none,
                          shape: StadiumBorder()),
                      child: Text(
                        "Edit Profile",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  Divider(),
                  SizedBox(height: 10),

                  // MENU
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, "RiwayatTransaksiPage");
                    },
                    child: ListTile(
                      leading: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Color.fromARGB(255, 98, 141, 214)
                              .withOpacity(0.1),
                        ),
                        child: Icon(
                          Icons.point_of_sale,
                          color: Color.fromARGB(255, 98, 141, 214),
                        ),
                      ),
                      title: Text("Riwayat Transaksi",
                          style: Theme.of(context).textTheme.bodyLarge),
                    ),
                  ),
                  SizedBox(height: 5),
                  ElevatedButton(
                    onPressed: () async {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      await prefs.remove('id_pengguna');

                      Navigator.pushReplacementNamed(context, 'LoginPage');
                    },
                    child: ListTile(
                      leading: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Color.fromARGB(255, 98, 141, 214)
                              .withOpacity(0.1),
                        ),
                        child: Icon(
                          Icons.logout,
                          color: Color.fromARGB(255, 98, 141, 214),
                        ),
                      ),
                      title: Text("Logout",
                          style: Theme.of(context).textTheme.bodyLarge),
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}


