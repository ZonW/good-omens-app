import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

final List<String> images = [
  'assets/img/gradient1.png',
  'assets/img/gradient2.png',
  'assets/img/titleBG.png',
  'assets/img/palette.png',
  'assets/img/bubble.jpeg',
  'assets/img/astro.jpeg',
  'assets/img/sunset.jpeg',
  'assets/img/dune.jpeg',
  'assets/img/surfing.jpeg',
];
int _currentIndex = 0;

class ImageSelector extends StatefulWidget {
  final Function(int) onIndexChanged;
  final int initialIndex;
  ImageSelector({required this.onIndexChanged, required this.initialIndex});

  @override
  _ImageSelectorState createState() => _ImageSelectorState();
}

class _ImageSelectorState extends State<ImageSelector> {
  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        initialPage: widget.initialIndex,
        autoPlay: false,
        aspectRatio: 2,
        enlargeCenterPage: true,
        viewportFraction: 0.3,
        enlargeFactor: 0.3,
        onPageChanged: (index, reason) {
          setState(() {
            _currentIndex = index;
          });
          widget.onIndexChanged(index);
        },
      ),
      items: images.map((item) {
        int index = images.indexOf(item);
        return Builder(
          builder: (BuildContext context) {
            return Container(
              margin: EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                border: Border.all(
                  color: index == _currentIndex
                      ? Colors.transparent
                      : Colors
                          .transparent, // Making the base border transparent
                  width: 1.0,
                ),
                gradient: index == _currentIndex
                    ? LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color(0xFFE99FA8), // Top Left color
                          Color(0xFFD7CEE7), // Center color
                          Color(0xFF91A0CD), // Bottom Right color
                        ],
                      )
                    : null, // Gradient only for the selected index
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                child: Image.asset(item, fit: BoxFit.cover),
              ),
            );
          },
        );
      }).toList(),
    );
  }
}
