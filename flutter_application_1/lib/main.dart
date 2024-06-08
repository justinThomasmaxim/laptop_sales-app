import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/BeliSekarangPage.dart';
import 'package:flutter_application_1/pages/CheckoutPage.dart';
import 'package:flutter_application_1/pages/EditKeranjangPage.dart';
import 'package:flutter_application_1/pages/EditProfilePage.dart';
import 'package:flutter_application_1/pages/HomePage.dart';
import 'package:flutter_application_1/pages/LoginPage.dart';
import 'package:flutter_application_1/pages/PembayaranPage.dart';
import 'package:flutter_application_1/pages/ProductPage.dart';
import 'package:flutter_application_1/pages/RiwayatTransaksiPage.dart';
import 'package:flutter_application_1/pages/SignIn.dart';

// void main() => runApp(MyApp());
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        "/"                     : (context) => HomePage(),
        'SignInPage'            : (context) => SignInPage(),
        'LoginPage'             : (context) => LoginPage(),
        "ProductPage"           : (context) => ProductPage(),
        "BeliSekarangPage"      : (context) => BeliSekarangPage(),
        // "CheckoutPage": (context) => CheckoutPage(),
        "PembayaranPage"        : (context) => PembayaranPage(),
        "RiwayatTransaksiPage"  : (context) => RiwayatTransasksiPage(),
        "EditProfilePage"       : (context) => EditProfilePage(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == 'CheckoutPage') {
          final args = settings.arguments as List<int>;
          return MaterialPageRoute(
            builder: (context) {
              return CheckoutPage(selectedIds: args);
            },
          );
        } else if (settings.name == 'EditKeranjangPage') {
          final idKeranjang = settings.arguments as int;
          return MaterialPageRoute(
            builder: (context) {
              return EditKeranjangPage(idKeranjang: idKeranjang);
            },
          );
        }
        assert(false, 'Need to implement ${settings.name}');
        return null;
      },
    );
  }
}
