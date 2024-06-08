import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter_application_1/pages_widget/CartPageWidget.dart';
import 'package:flutter_application_1/pages_widget/GeminiPageWidget.dart';
import 'package:flutter_application_1/pages_widget/HomePageWidget.dart';
import 'package:flutter_application_1/pages_widget/ProfilePageWidget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  int? userId;
  late List<Widget> _widgetOptions; // Deklarasikan tetapi jangan inisialisasikan di sini

  @override
  void initState() {
    super.initState();
    _widgetOptions = [ // Inisialisasikan _widgetOptions di sini
      HomePageWidget(),
      CartPageWidget(),
      GeminiPageWidget(),
      // ProfilePageWidget(idPengguna: userId, isPelanggan: false,),
      ProfilePageWidget(idPengguna: userId),
    ];
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getInt('id_pengguna') != null;

    if (isLoggedIn) {
      setState(() {
        userId = prefs.getInt('id_pengguna');
        //  _widgetOptions[3] = ProfilePageWidget(idPengguna: userId, isPelanggan: false,); // Perbarui ProfilePageWidget dengan userId yang diperoleh
         _widgetOptions[3] = ProfilePageWidget(idPengguna: userId); // Perbarui ProfilePageWidget dengan userId yang diperoleh
      });
    } else {
      Navigator.pushReplacementNamed(context, 'LoginPage');
    }
  }

  // List<Widget> _widgetOptions = <Widget>[
  //   HomePageWidget(),
  //   CartPageWidget(),
  //   GeminiPageWidget(),
  //   ProfilePageWidget(idPengguna: userId,)  // CARA MENGAKSES ATRIBUT USERID
  // ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(child: _widgetOptions.elementAt(_selectedIndex)),
      bottomNavigationBar: CurvedNavigationBar(
        index: _selectedIndex,
        items: [
          Icon(Icons.home, size: 30),
          Icon(Icons.shopping_cart, size: 30),
          Image.asset("images/gemini.png", height: 30, width: 30),
          Icon(Icons.person_outline, size: 30),
        ],
        onTap: _onItemTapped,
      ),
    );
  }
}