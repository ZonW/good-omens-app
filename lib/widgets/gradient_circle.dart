import 'dart:ui';

import 'package:flutter/material.dart';

class GradientCircle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;

    return ImageFiltered(
      imageFilter: ImageFilter.blur(sigmaX: 25.0, sigmaY: 25.0),
      child: Container(
        height: screenWidth * 0.8,
        width: screenWidth * 0.8,
        decoration: BoxDecoration(
          gradient: RadialGradient(
            radius: 0.5,
            colors: [
              Colors.white,
              Color(0xFFFF7BCA),
              Color(0x611A73E8),
              Color(0xFFBDAFE3),
              Colors.transparent
            ],
            stops: [0.12, 0.55, 0.8, 0.9, 1.0],
          ),
        ),
      ),
    );
  }
}
