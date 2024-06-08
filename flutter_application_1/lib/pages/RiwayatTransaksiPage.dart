import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_application_1/API/api_connection.dart';
import 'dart:convert';

class RiwayatTransasksiPage extends StatefulWidget {
  @override
  State<RiwayatTransasksiPage> createState() => _RiwayatTransasksiPageState();
}

class _RiwayatTransasksiPageState extends State<RiwayatTransasksiPage> {
  List dataTransaksi = [];

  @override
  void initState() {
    super.initState();
    getTransaksi();
  }

  Future<void> getTransaksi() async {
    String uri = API.readAllTransaksi;
    try {
      var response = await http.get(Uri.parse(uri));

      if (response.statusCode == 200) {
        setState(() {
          dataTransaksi = jsonDecode(response.body);
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
    // Format mata uang
    final priceFormatted = NumberFormat.currency(locale: 'id', symbol: 'Rp. ');

    

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          shadowColor: Colors.black,
          elevation: 5,
          title: Text("Riwayat Transaksi",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              )),
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            color: Color(0xFFEDECF2),
          ),
          child: ListView.builder(
            itemCount: dataTransaksi.length,
            itemBuilder: (context, index) {
              int subtotal = int.parse(dataTransaksi[index]["subtotal"]);
          
              return Padding(
                padding: EdgeInsets.all(10),
                child: Row(
                  children: [
                    // Container(
                    //   width: 70,
                    //   height: 70,
                    //   decoration: BoxDecoration(
                    //     color: Colors.blue,
                    //     shape: BoxShape.circle,
                    //   ),
                    //   child: Center(
                    //       child: Text(
                    //     "${dataTransaksi[index]["tanggal_transaksi"]}",
                    //     style: TextStyle(color: Colors.white, fontSize: 18),
                    //   )),
                    // ),
                    // SizedBox(width: 20),
                    // Container(
                    //   width: 70,
                    //   height: 70,
                    //   decoration: BoxDecoration(
                    //     color: Colors.blue,
                    //     shape: BoxShape.circle,
                    //   ),
                    //   child: Center(
                    //       child: Text(
                    //     // "${dataTransaksi[index]["subtotal"]}",
                    //     priceFormatted.format(subtotal),
                    //     style: TextStyle(color: Colors.white, fontSize: 18),
                    //   )),
                    // ),
                    Container(
                      width: 390,
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          
                          Container(
                            child: Text(
                              // "${dataMahasiswa[index]["nama"]}",
                              "${dataTransaksi[index]["tanggal_transaksi"]}",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18
                              ),
                            ),
                                
                          ),
                          SizedBox(width: 120),
                          Container(
                            child: Text(
                              // "${dataMahasiswa[index]["jurusan"]}",
                              priceFormatted.format(subtotal),
                              style: TextStyle(
                                fontSize: 17
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ));
  }
}
