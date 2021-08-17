import 'package:flutter/material.dart';

class PricingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Text(
              'Do you have any subscription plans or packages?',
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 17.0, color: Colors.black),
            ),
            Text(
              'No - We have negotiated the lowest possible rates with all our space partners and you are already getting the benefits of a typical premium tier plan',
              style: TextStyle(fontSize: 15.0),
            ),
          ],
        ),
      ),
    );
  }
}
