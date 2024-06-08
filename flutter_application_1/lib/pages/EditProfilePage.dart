// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:flutter_application_1/API/api_connection.dart';

// class EditProfilePage extends StatefulWidget {
//   @override
//   State<EditProfilePage> createState() => _EditProfilePageState();
// }

// class _EditProfilePageState extends State<EditProfilePage> {
//   List produkYangDibeli = [];

//   @override
//   void initState() {
//     super.initState();
//   }

//   Future<void> addPelanggan(String namaPelanggan, String alamat, String nomorTelepon) async {
//     String uri = API.createPelanggan; // Sesuaikan URI dengan endpoint API Anda
//     try {
//       var response = await http.post(
//         Uri.parse(uri),
//         body: {
//           'id_pengguna'   : '1', // Ganti dengan id_pengguna yang sesuai
//           'nama_pelanggan': namaPelanggan,
//           'alamat'        : alamat,
//           'nomorTelepon'  : nomorTelepon,
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
//                   content: Text("Profile berhasil diedit"),
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
//         } else {
//           showDialog(
//               context: context,
//               builder: (context) {
//                 return AlertDialog(
//                   title: Text("Success"),
//                   content: Text("Profile gagal diedit"),
//                   actions: [
//                     FloatingActionButton(
//                       onPressed: () {
//                         Navigator.of(context).pop();
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

//   Future<void> updatePelanggan(String namaPelanggan, String alamat, String nomorTelepon) async {
//     String uri = API.updatePelanggan; // Sesuaikan URI dengan endpoint API Anda
//     try {
//       var response = await http.post(
//         Uri.parse(uri),
//         body: {
//           'id_pengguna'   : '1', // Ganti dengan id_pengguna yang sesuai
//           'nama_pelanggan': namaPelanggan,
//           'alamat'        : alamat,
//           'nomorTelepon'  : nomorTelepon,
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
//                   content: Text("Profile berhasil diedit"),
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
//         } else {
//           showDialog(
//               context: context,
//               builder: (context) {
//                 return AlertDialog(
//                   title: Text("Success"),
//                   content: Text("Profile gagal diedit"),
//                   actions: [
//                     FloatingActionButton(
//                       onPressed: () {
//                         Navigator.of(context).pop();
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
//     return Scaffold(

//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_application_1/API/api_connection.dart';

class EditProfilePage extends StatefulWidget {
 
  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();
  final _namaController = TextEditingController();
  final _alamatController = TextEditingController();
  final _nomorTeleponController = TextEditingController();
  int? _userId;
  bool _isNewProfile = false;

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  Future<void> _loadUserProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? userId = prefs.getInt('id_pengguna');

    if (userId != null) {
      // Fetch existing profile data from API
      String uri = API.readPelangganById; // Ganti dengan endpoint API yang sesuai
      var response = await http.post(Uri.parse(uri), body: {'id_pengguna': userId.toString()});

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        if (jsonResponse['success'] && jsonResponse['data'] != null) {
          setState(() {
            _userId = userId;
            _namaController.text = jsonResponse['data']['nama_pelanggan'] ?? '';
            _alamatController.text = jsonResponse['data']['alamat'] ?? '';
            _nomorTeleponController.text = jsonResponse['data']['nomor_telepon'] ?? '';
            _isNewProfile = false;
          });
        } else {
          setState(() {
            _userId = userId;
            _isNewProfile = true;
          });
        }
      } else {
        setState(() {
          _userId = userId;
          _isNewProfile = true;
        });
      }
    } else {
      Navigator.pushReplacementNamed(context, 'LoginPage');
    }
  }

  Future<void> _submitProfile() async {
    if (_formKey.currentState!.validate()) {
      if (_isNewProfile) {
        await _addPelanggan(
          _namaController.text,
          _alamatController.text,
          _nomorTeleponController.text,
        );
      } else {
        await _updatePelanggan(
          _namaController.text,
          _alamatController.text,
          _nomorTeleponController.text,
        );
      }
    }
  }

  Future<void> _addPelanggan(String namaPelanggan, String alamat, String nomorTelepon) async {
    String uri = API.createPelanggan; // Ganti dengan endpoint API yang sesuai
    try {
      var response = await http.post(
        Uri.parse(uri),
        body: {
          'id_pengguna'   : _userId.toString(),
          'nama_pelanggan': namaPelanggan,
          'alamat'        : alamat,
          'nomor_telepon' : nomorTelepon,
        },
      );

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        if (jsonResponse['success']) {
          _showDialog("Success", "Profile berhasil dibuat");
        } else {
          _showDialog("Error", "Profile gagal dibuat");
        }
      } else {
        print('Failed to load data: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> _updatePelanggan(String namaPelanggan, String alamat, String nomorTelepon) async {
    String uri = API.updatePelanggan; // Ganti dengan endpoint API yang sesuai
    try {
      var response = await http.post(
        Uri.parse(uri),
        body: {
          'id_pengguna'   : _userId.toString(),
          'nama_pelanggan': namaPelanggan,
          'alamat'        : alamat,
          'nomor_telepon' : nomorTelepon,
        },
      );

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        if (jsonResponse['success']) {
          _showDialog("Success", "Profile berhasil diedit");
        } else {
          _showDialog("Error", "Profile gagal diedit");
        }
      } else {
        print('Failed to load data: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  void _showDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            FloatingActionButton(
              onPressed: () {
                Navigator.of(context).pop();
                if (title == "Success") {
                  Navigator.pushNamed(context, "/");
                }
              },
              child: Text("Oke"),
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Profile"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _namaController,
                decoration: InputDecoration(labelText: "Nama Pelanggan"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Nama Pelanggan tidak boleh kosong";
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _alamatController,
                decoration: InputDecoration(labelText: "Alamat"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Alamat tidak boleh kosong";
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _nomorTeleponController,
                decoration: InputDecoration(labelText: "Nomor Telepon"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Nomor Telepon tidak boleh kosong";
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitProfile,
                child: Text("Submit"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
