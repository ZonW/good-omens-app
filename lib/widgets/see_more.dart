import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SeeMore extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 50),
      color: Colors.transparent,
      child: Column(
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
    );
  }
}
