import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:good_omens/main.dart';
import 'package:good_omens/pages/profile/auth_page.dart';
import 'package:good_omens/models/user.dart' as user_model;
import 'package:good_omens/pages/profile/signup_page.dart';
import 'package:good_omens/pages/profile/verify_email_page.dart';
import 'package:good_omens/services/user.dart';
import 'package:provider/provider.dart';
import 'package:good_omens/widgets/get_background.dart';
import 'package:good_omens/widgets/see_more.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:good_omens/widgets/three_body.dart';
import 'dart:convert';
import 'package:good_omens/end-points/api.dart';
import 'package:good_omens/pages/profile/profile.dart';
import 'package:good_omens/pages/home/explaination.dart';
import 'package:http/http.dart';
import 'package:screenshot/screenshot.dart';

class VersePage extends StatefulWidget {
  final Future<List<String>> generateOutputFuture;
  final String bible;
  final String book;
  final String chapter;
  final String verse;
  final String content;
  final String verseId;
  int theme;

  VersePage({
    super.key,
    required this.bible,
    required this.book,
    required this.chapter,
    required this.verse,
    required this.content,
    required this.verseId,
    required this.theme,
    required this.generateOutputFuture,
  });
  @override
  _VersePageState createState() => _VersePageState();
}

class _VersePageState extends State<VersePage>
    with SingleTickerProviderStateMixin {
  double _offsetY = 0.0;
  bool isLoading = false;
  AnimationController? _controller;
  Animation<double>? _animation;
  final ScreenshotController screenshotController = ScreenshotController();
  String? userId = FirebaseAuth.instance.currentUser?.uid;
  int subscription = 0;

  @override
  void initState() {
    super.initState();
    print(widget.verse);
    print(widget.content);
    print(widget.book);
    print(widget.chapter);
    print(widget.bible);
    print(widget.verseId);
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
    _controller?.stop();
    _controller?.dispose(); // Dispose of the AnimationController
    super.dispose();
  }

  Future<bool> _onWillPop() async {
    return false;
  }

  Future<void> handleGesture(BuildContext context) async {
    // Navigate to the ExplanationPage and await the result
    int themeOut = await Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            ExplainationPage(
                bible: widget.bible,
                verseId: widget.verseId,
                generateOutputFuture: widget.generateOutputFuture,
                theme: widget.theme),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = 0.0;
          const end = 1.0;
          const curve = Curves.easeInOut;

          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          var opacityAnimation = animation.drive(tween);

          return FadeTransition(
            opacity: opacityAnimation,
            child: child,
          );
        },
        transitionDuration: Duration(milliseconds: 500),
      ),
    );

    // Update the theme with the result from ExplanationPage
    setState(() {
      widget.theme = themeOut;
      _offsetY = 0.0; // Reset the offset after the navigation
    });
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
            //profile button
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
            //share button
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
            getBackground(widget.theme),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Transform.translate(
                offset: Offset(0, _offsetY),
                child: Opacity(
                  opacity: opacity,
                  child: Stack(
                    children: [
                      Center(
                        child: FadeTransition(
                          opacity: _animation ?? AlwaysStoppedAnimation(0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              if (!isLoading) ...[
                                SizedBox(
                                  height: 10,
                                ),
                                Text(widget.content,
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayMedium
                                        ?.copyWith(
                                          fontStyle: FontStyle.italic,
                                        )),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  "${widget.book} ${widget.chapter}:${widget.verse}",
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ],
                              SizedBox(
                                  height: screenHeight *
                                      0.20), // To avoid overlap with the Positioned widget
                            ],
                          ),
                        ),
                      ),
                      if (widget.content.isNotEmpty && !isLoading)
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
                                await handleGesture(context);
                              },
                              onTap: () async {
                                await handleGesture(context);
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
            if (isLoading)
              Center(
                child: ThreeBodySimulation(),
              ),
          ],
        ),
      ),
    );
  }
}
