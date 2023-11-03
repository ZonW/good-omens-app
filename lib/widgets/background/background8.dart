import 'package:flutter/material.dart';

class Background8 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Image.asset(
      "assets/img/surfing.jpeg",
      fit: BoxFit.cover,
      height: double.infinity,
      width: double.infinity,
    );
  }
}
