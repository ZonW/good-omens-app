import 'package:flutter/material.dart';

class Background4 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Image.asset(
      "assets/img/bubble.jpeg",
      fit: BoxFit.cover,
      height: double.infinity,
      width: double.infinity,
    );
  }
}
