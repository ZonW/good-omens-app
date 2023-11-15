import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:good_omens/pages/home/chat.dart';
import 'package:good_omens/pages/home/personal_query.dart';

import 'package:good_omens/widgets/get_background.dart';
import 'package:good_omens/widgets/see_more.dart';

import 'package:good_omens/pages/profile/profile.dart';

class GuidancePage extends StatefulWidget {
  final String bible;
  final String guidance;
  int theme;

  GuidancePage({
    super.key,
    required this.bible,
    required this.guidance,
    required this.theme,
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

    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pop(widget.theme);
        return false;
      },
      child: Scaffold(
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
              onPressed: () async {
                int themeOut = await Navigator.of(context).push(
                  PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          ProfileNav(),
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
                setState(() {
                  widget.theme = themeOut;
                });
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
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => ChatPage()));
                  }),
            ],
          ),
        ),
        body: Stack(
          children: [
            // Background images
            getBackground(widget.theme),
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
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(height: 20),
                              FadeTransition(
                                opacity:
                                    _animation ?? AlwaysStoppedAnimation(0),
                                child: Text(
                                  widget.guidance,
                                  style:
                                      Theme.of(context).textTheme.displayMedium,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Buttom arrow button

                      Positioned(
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: FadeTransition(
                          opacity: _animation ?? AlwaysStoppedAnimation(0),
                          child: GestureDetector(
                            onVerticalDragUpdate: (details) {
                              setState(() {
                                _offsetY += details.delta.dy;
                              });
                            },
                            onVerticalDragEnd: (details) async {
                              if (_offsetY < 0) {
                                int outTheme = await Navigator.of(context).push(
                                  PageRouteBuilder(
                                    pageBuilder: (context, animation,
                                            secondaryAnimation) =>
                                        QueryPage(
                                      bible: widget.bible,
                                      theme: widget.theme,
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
                                        Duration(milliseconds: 1000),
                                  ),
                                );
                                setState(() {
                                  widget.theme = outTheme;
                                });
                              }
                              setState(() {
                                _offsetY = 0.0;
                              });
                            },
                            child: SeeMore(),
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
      ),
    );
  }
}
