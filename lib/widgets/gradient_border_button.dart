import 'package:flutter/material.dart';

class GradientBorderButton extends StatelessWidget {
  final VoidCallback onTap;
  final String textContent;
  final double? width;
  final double? height;

  GradientBorderButton(
      {required this.onTap,
      required this.textContent,
      this.width,
      this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFE99FA8), // Top Left color
            Color(0xFFD7CEE7), // Center color
            Color(0xFF91A0CD), // Bottom Right color
          ],
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: onTap,
          child: Stack(
            children: [
              Positioned.fill(
                child: Container(
                  margin: EdgeInsets.all(
                      1), // Adjust the value of the margin to control the thickness of the border
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              Center(
                child: Text(
                  textContent,
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
