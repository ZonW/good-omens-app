import 'package:flutter/material.dart';

class Background6 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Image.asset(
      "assets/img/sunset.jpeg",
      fit: BoxFit.cover,
      height: double.infinity,
      width: double.infinity,
    );
  }
}
