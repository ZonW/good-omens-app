import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Background1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ImageFiltered(
      imageFilter: ImageFilter.blur(sigmaX: 50.0, sigmaY: 50.0),
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Positioned(
            top: 0,
            left: 0,
            child: SvgPicture.asset('assets/img/Eclipse1.svg',
                semanticsLabel: 'eclipse'),
          ),
          Positioned(
            top: 0,
            left: 0,
            child: SvgPicture.asset('assets/img/Eclipse2.svg',
                semanticsLabel: 'eclipse'),
          ),
        ],
      ),
    );
  }
}
