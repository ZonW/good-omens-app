import 'package:flutter/material.dart';

class Background2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Image.asset(
      "assets/img/palette.png",
      fit: BoxFit.cover,
      height: double.infinity,
      width: double.infinity,
    );
  }
}
