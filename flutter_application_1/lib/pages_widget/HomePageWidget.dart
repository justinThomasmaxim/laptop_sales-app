import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/HomeAppBar.dart';
import 'package:flutter_application_1/widgets/MerkWidget.dart';
import 'package:flutter_application_1/widgets/ProductWidget.dart';


class HomePageWidget extends StatefulWidget {
  @override
  State<HomePageWidget> createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Row(
          children: [HomeAppBar(), Text("Home")],
        ),
        Container(
          padding: EdgeInsets.only(top: 15),
          decoration: BoxDecoration(
              color: Color(0xFFEDECF2),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(35),
                topRight: Radius.circular(35),
              )),
          child: Column(children: [
            Container(
                margin: EdgeInsets.symmetric(horizontal: 15),
                padding: EdgeInsets.symmetric(horizontal: 15),
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 5),
                      height: 50,
                      width: 270,
                      child: TextFormField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Search",
                        ),
                      ),
                    )
                  ],
                )),
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.symmetric(
                vertical: 20,
                horizontal: 10,
              ),
            ),
            MerkWidget(),
            ProductWidget()
          ]),
        )
      ],
    );
  }
}


// _widgetOptions.elementAt(_selectedIndex),