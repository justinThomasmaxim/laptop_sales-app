import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_application_1/API/api_connection.dart';
import 'dart:convert';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _passwordVisible = false;

  Future<void> addPengguna(String username, String password, String email) async {
    String uri = API.createPengguna; // Sesuaikan URI dengan endpoint API Anda
    try {
      var response = await http.post(
        Uri.parse(uri),
        body: {
          'username': username,
          'password': password,
          'email'   : email,
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
                content: Text("Sign In Berhasil"),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.pushNamed(context, "LoginPage");
                    },
                    child: Text("Oke"),
                  ),
                ],
              );
            },
          );
        } else {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text("Gagal"),
                content: Text("Gagal Sign In"),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("Oke"),
                  ),
                ],
              );
            },
          );
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
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/sign-bg.png'), // Ganti dengan path gambar Anda
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          height: 500,
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
                  Text("Sign In" ,style: TextStyle(fontSize: 30),),
                  SizedBox(height: 20,),
                  TextFormField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                      labelText: 'Username (Max 7 Characters)',
                      hintText: 'Enter Your Username',
                    ),
                    maxLength: 7,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your username';
                      }
                      if (value.length > 7) {
                        return 'Username cannot be more than 7 characters';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      hintText: 'Enter Your Email',
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                        return 'Please enter a valid email address';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      labelText: 'Password (Min 10 Characters)',
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
                      if (value.length < 10) {
                        return 'Password must be at least 10 characters';
                      }
                      if (!RegExp(r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[^a-zA-Z0-9]).{10,}$').hasMatch(value)) {
                        return 'Password must contain uppercase, lowercase, number, and special character';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 32),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          addPengguna(
                            _usernameController.text,
                            _passwordController.text,
                            _emailController.text,
                          );
                        });
                      }
                    },
                    child: Text('Sign In'),
                  ),
                  SizedBox(height: 16),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, 'LoginPage');
                    },
                    child: Text('Already have an account? Login'),
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
