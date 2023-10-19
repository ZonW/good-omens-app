import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SeeMore extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 335,
          height: 52,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset('assets/img/Vector.svg'),
              SizedBox(height: 12),
              Text(
                'See More',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontFamily: 'Avenir',
                  fontWeight: FontWeight.w300,
                  height: 0,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
