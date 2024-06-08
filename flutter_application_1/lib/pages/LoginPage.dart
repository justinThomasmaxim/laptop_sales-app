// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:flutter_application_1/API/api_connection.dart';

// class LoginPage extends StatefulWidget {
//   @override
//   _LoginPageState createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   final _formKey = GlobalKey<FormState>();
//   final TextEditingController _usernameController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   bool _passwordVisible = false;
//   String? errorMessage;

//   Future<void> getPenggunaByUserAndPass(String username, String password) async {
//     String uri = API.readPengguna; // Sesuaikan URI dengan endpoint API Anda
//     try {
//       var response = await http.post(
//         Uri.parse(uri),
//         body: {
//           'username': username,
//           'password': password,
//         },
//       );

//       if (response.statusCode == 200) {
//         var jsonResponse = jsonDecode(response.body);

//         if (jsonResponse['success'] == true) {
//           var userId = jsonResponse['id_pengguna'];
//           if (userId != null) {
//             SharedPreferences prefs = await SharedPreferences.getInstance();
//             await prefs.setInt('id_pengguna', int.parse(userId));

//             Navigator.pushReplacementNamed(context, '/');
//           } else {
//             setState(() {
//               errorMessage = 'Invalid user ID';
//             });
//           }
//         } else {
//           setState(() {
//             errorMessage = jsonResponse['message'] ?? 'Unknown error occurred';
//           });
//         }
//       } else {
//         setState(() {
//           errorMessage = 'Failed to load data: ${response.reasonPhrase}';
//         });
//       }
//     } catch (e) {
//       setState(() {
//         errorMessage = 'Error: $e';
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Login"),
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: ListView(
//             children: [
//               TextFormField(
//                 controller: _usernameController,
//                 decoration: InputDecoration(
//                   labelText: 'Username',
//                   hintText: 'Enter Your Username',
//                 ),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter your username';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 16),
//               TextFormField(
//                 controller: _passwordController,
//                 decoration: InputDecoration(
//                   labelText: 'Password',
//                   hintText: 'Enter Your Password',
//                   suffixIcon: IconButton(
//                     icon: Icon(
//                       _passwordVisible ? Icons.visibility : Icons.visibility_off,
//                     ),
//                     onPressed: () {
//                       setState(() {
//                         _passwordVisible = !_passwordVisible;
//                       });
//                     },
//                   ),
//                 ),
//                 obscureText: !_passwordVisible,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter your password';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 32),
//               if (errorMessage != null)
//                 Text(
//                   errorMessage!,
//                   style: TextStyle(color: Colors.red),
//                 ),
//               SizedBox(height: 16),
//               ElevatedButton(
//                 onPressed: () {
//                   if (_formKey.currentState!.validate()) {
//                     getPenggunaByUserAndPass(
//                       _usernameController.text,
//                       _passwordController.text,
//                     );
//                   }
//                 },
//                 child: Text('Login'),
//               ),
//               SizedBox(height: 16),
//               TextButton(
//                 onPressed: () {
//                   Navigator.pushNamed(context, 'SignInPage');
//                 },
//                 child: Text('Don\'t have an account? Sign Up'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_application_1/API/api_connection.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _passwordVisible = false;
  String? errorMessage;

  Future<void> getPenggunaByUserAndPass(String username, String password) async {
    String uri = API.readPengguna; // Sesuaikan URI dengan endpoint API Anda
    try {
      var response = await http.post(
        Uri.parse(uri),
        body: {
          'username': username,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);

        if (jsonResponse['success'] == true) {
          var userId = jsonResponse['id_pengguna'];
          if (userId != null) {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            await prefs.setInt('id_pengguna', int.parse(userId));

            Navigator.pushReplacementNamed(context, '/');
          } else {
            setState(() {
              errorMessage = 'Invalid user ID';
            });
          }
        } else {
          setState(() {
            errorMessage = jsonResponse['message'] ?? 'Unknown error occurred';
          });
        }
      } else {
        setState(() {
          errorMessage = 'Failed to load data: ${response.reasonPhrase}';
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Error: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/login-bg.png'), // Ganti dengan path gambar Anda
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          height: 400,
          decoration: BoxDecoration(
            color: Colors.white, // Warna background kontainer
            borderRadius: BorderRadius.circular(10), // BorderRadius untuk sudut

            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5), // Warna bayangan
                spreadRadius: 5, // Radius penyebaran bayangan
                blurRadius: 7, // Radius blur bayangan
                offset: Offset(0, 3), // Penyesuaian posisi bayangan
              ),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  Text("Login" ,style: TextStyle(fontSize: 30),),
                  SizedBox(height: 20,),
                  TextFormField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                      labelText: 'Username',
                      hintText: 'Enter Your Username',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your username';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      hintText: 'Enter Your Password',
                      suffixIcon: IconButton(
                        icon: Icon(
                          _passwordVisible ? Icons.visibility : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            _passwordVisible = !_passwordVisible;
                          });
                        },
                      ),
                    ),
                    obscureText: !_passwordVisible,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 32),
                  if (errorMessage != null)
                    Text(
                      errorMessage!,
                      style: TextStyle(color: Colors.red),
                    ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        getPenggunaByUserAndPass(
                          _usernameController.text,
                          _passwordController.text,
                        );
                      }
                    },
                    child: Text('Login'),
                  ),
                  SizedBox(height: 16),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, 'SignInPage');
                    },
                    child: Text('Don\'t have an account? Sign Up'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
