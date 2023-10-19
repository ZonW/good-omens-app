import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:good_omens/pages/home/personal_query.dart';
import 'package:good_omens/widgets/background1.dart';
import 'package:good_omens/widgets/background2.dart';
import 'package:good_omens/widgets/see_more.dart';

import 'package:good_omens/pages/profile/profile.dart';

class GuidancePage extends StatefulWidget {
  final String bible;
  final String guidance;

  GuidancePage({
    super.key,
    required this.bible,
    required this.guidance,
  });
  @override
  _GuidanceState createState() => _GuidanceState();
}

class _GuidanceState extends State<GuidancePage>
    with SingleTickerProviderStateMixin {
  double _offsetY = 0.0;
  AnimationController? _controller;
  Animation<double>? _animation;

  TextEditingController inputController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 3), // Adjust the duration as needed
      vsync: this,
      value: 0,
    );

    _animation = CurvedAnimation(
      parent: _controller!,
      curve: Curves.easeIn,
    );

    _controller!.forward();
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double opacity =
        (1.0 - (_offsetY.abs() / screenHeight * 4)).clamp(0.0, 1.0);

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(62),
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: const Icon(
              Icons.menu,
              color: Color(0xFFFFFFFF),
              size: 30,
            ),
            onPressed: () {
              Navigator.of(context).push(
                PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        Profile(),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      const begin = Offset(-1.0, 0.0);
                      const end = Offset.zero;
                      const curve = Curves.easeOut;

                      var tween = Tween(begin: begin, end: end)
                          .chain(CurveTween(curve: curve));
                      var offsetAnimation = animation.drive(tween);

                      return SlideTransition(
                        position: offsetAnimation,
                        child: child,
                      );
                    },
                    transitionDuration: Duration(milliseconds: 500)),
              );
            },
          ),
          title: SvgPicture.asset('assets/img/Good Omens.svg', height: 20),
          centerTitle: true,
          actions: [
            IconButton(
                icon: const Icon(
                  Icons.share,
                  color: Color(0xFFFFFFFF),
                  size: 30,
                ),
                onPressed: () {}),
          ],
        ),
      ),
      body: Stack(
        children: [
          // Background images
          Background2(),
          // Main Content
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Transform.translate(
              offset: Offset(0, _offsetY),
              child: Opacity(
                opacity: opacity,
                child: Stack(
                  children: [
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(height: 20),
                          FadeTransition(
                            opacity: _animation ?? AlwaysStoppedAnimation(0),
                            child: Text(
                              widget.guidance,
                              style: Theme.of(context).textTheme.displayMedium,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Buttom arrow button

                    Positioned(
                      bottom: screenHeight * 0.10, //10% from bottom

                      child: FadeTransition(
                        opacity: _animation ?? AlwaysStoppedAnimation(0),
                        child: Align(
                          alignment: Alignment.center,
                          child: GestureDetector(
                            onVerticalDragUpdate: (details) {
                              setState(() {
                                _offsetY += details.delta.dy;
                              });
                            },
                            onVerticalDragEnd: (details) async {
                              if (_offsetY < 0) {
                                await Navigator.of(context).push(
                                  PageRouteBuilder(
                                    pageBuilder: (context, animation,
                                            secondaryAnimation) =>
                                        QueryPage(
                                      bible: widget.bible,
                                    ),
                                    transitionsBuilder: (context, animation,
                                        secondaryAnimation, child) {
                                      const begin = 0.0;
                                      const end = 1.0;
                                      const curve = Curves.easeInOut;

                                      var tween = Tween(begin: begin, end: end)
                                          .chain(CurveTween(curve: curve));
                                      var opacityAnimation =
                                          animation.drive(tween);

                                      return FadeTransition(
                                        opacity: opacityAnimation,
                                        child: child,
                                      );
                                    },
                                    transitionDuration:
                                        Duration(milliseconds: 500),
                                  ),
                                );
                              }
                              setState(() {
                                _offsetY = 0.0;
                              });
                            },
                            child: SeeMore(),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}