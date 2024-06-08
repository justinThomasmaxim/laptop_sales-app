import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/CartItem.dart';
import 'package:flutter_application_1/widgets/HomeAppBar.dart';

class CartPageWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
        children: [
          Row(
            children: [
              HomeAppBar(),
              Text("Cart")
            ],
          ),
          Container(
            height: 3000,
            padding: EdgeInsets.only(top: 15),
            decoration: BoxDecoration(
              color: Color(0xFFEDECF2),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(35),
                topRight: Radius.circular(35)
              )),
              child: Column(
                children: [
                  CartItem(),
                  // CartCheckout()
                ],
              ),
          )
        ],
      );
  }
}
