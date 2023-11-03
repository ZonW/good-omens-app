import 'package:flutter/material.dart';

class Background5 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Image.asset(
      "assets/img/astro.jpeg",
      fit: BoxFit.cover,
      height: double.infinity,
      width: double.infinity,
    );
  }
}
