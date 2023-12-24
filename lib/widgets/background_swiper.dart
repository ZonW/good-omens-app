import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

final List<String> images = [
  'assets/img/gradient1.png',
  'assets/img/palette.png',
  'assets/img/bubble.jpeg',
  'assets/img/astro.jpeg',
  'assets/img/sunset.jpeg',
  'assets/img/dune.jpeg',
  'assets/img/surfing.jpeg',
  "assets/img/4ab8f48b92ddc27a53ebdaae2b29aeb3.jpeg",
  "assets/img/04d1fd74cbf93eabbf41ee54a2c57ede.jpeg",
  "assets/img/8aa8e982ae4ecea96e86c6ca81abcbc3.jpeg",
  "assets/img/8d00e64a2543103d090ef99c8b11ac48.jpeg",
  "assets/img/57a9b08e531021ff5445a3c6f2353a4a.jpeg",
  "assets/img/86b33c997b2f285a3febc956877ac0aa.jpeg",
  "assets/img/115ca8ab2db08ee9b9ad1c6894b2abdc.jpeg",
  "assets/img/a6f1ad42e114ba5f86cb2e8bd1bdd62a.jpeg",
  "assets/img/aa1e6688600ce92bdcae36ac651460f5.jpeg",
  "assets/img/c2c14fa3e8f294a27f299c0867c5622a.jpeg",
  "assets/img/d244b755cda2c5ba5746c7e79ac3029d.jpeg",
  "assets/img/da2489de243ed126e8bc4b1ffd30f5dc.jpeg",
  "assets/img/ec6804e0c922a3ac35ddb68bc43bc8ad.jpeg",
  "assets/img/fff36dca5684b681b5631e795bdc83a6.jpeg",
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
