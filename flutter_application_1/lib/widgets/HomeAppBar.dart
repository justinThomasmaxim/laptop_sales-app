import 'package:flutter/material.dart';

class HomeAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(25),
      child: Row(
          children: [
            Padding(
              padding: EdgeInsets.only(
                left: 20,
              ),
              child: Text(
                "ElecTrons",
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                ),
              ),
            
            )
          ]
        ),
    );
  }
}
