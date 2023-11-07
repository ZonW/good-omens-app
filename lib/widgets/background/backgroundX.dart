import 'package:flutter/material.dart';

class BackgroundX extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Container(color: Colors.black),
      ],
    );
  }
}
