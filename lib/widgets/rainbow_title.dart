import 'package:flutter/material.dart';

class RainbowTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(text: 'G', style: TextStyle(color: Colors.red)),
          TextSpan(text: 'o', style: TextStyle(color: Colors.orange)),
          TextSpan(text: 'o', style: TextStyle(color: Colors.yellow)),
          TextSpan(text: 'd', style: TextStyle(color: Colors.green)),
          TextSpan(text: ' ', style: TextStyle(color: Colors.blue)),
          TextSpan(text: 'O', style: TextStyle(color: Colors.blue)),
          TextSpan(text: 'm', style: TextStyle(color: Colors.indigo)),
          TextSpan(text: 'e', style: TextStyle(color: Colors.purple)),
          TextSpan(text: 'n', style: TextStyle(color: Colors.pink)),
          TextSpan(text: 's', style: TextStyle(color: Colors.red)),
        ],
        style: DefaultTextStyle.of(context).style,
      ),
    );
  }
}
