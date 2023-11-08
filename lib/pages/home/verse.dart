import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:good_omens/pages/profile/auth_page.dart';
import 'package:good_omens/models/user.dart' as user_model;
import 'package:good_omens/pages/profile/signup_page.dart';
import 'package:good_omens/pages/profile/verify_email_page.dart';
import 'package:good_omens/services/user.dart';

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
  @override
  _VersePageState createState() => _VersePageState();
}

class _VersePageState extends State<VersePage>
    with SingleTickerProviderStateMixin {
  double _offsetY = 0.0;
  String verseId = '';
  String bible = '';
  String verse = '';
  String book = '';
  String chapter = '';
  String content = '';
  String input = '';
  String output = '';
  String explanation = '';
  String guidance = '';
  bool isLoading = false;
  AnimationController? _controller;
  Animation<double>? _animation;
  final ScreenshotController screenshotController = ScreenshotController();
  String? userId = FirebaseAuth.instance.currentUser?.uid;
  //default theme/ black screen
  int theme = 999;
  int subscription = 0;

  late Future<List<String>> outputDataFuture;

  @override
  void initState() {
    super.initState();
    if (userId == null) {
      // If userId is null, navigate to Profile and do not build the current screen
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => ProfileNav()),
        );
      });
    }

    // If userId is not null, check if the user is logged in and email is verified
    if (FirebaseAuth.instance.currentUser != null &&
        !FirebaseAuth.instance.currentUser!.emailVerified) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => AuthPage()),
        );
      });
    }
    initializeUserData(userId);

    fetchVerse();

    _controller = AnimationController(
      duration: const Duration(seconds: 3), // Adjust the duration as needed
      vsync: this,
      value: 0,
    );
    _animation = CurvedAnimation(
      parent: _controller!,
      curve: Curves.easeIn,
    );
  }

  @override
  void dispose() {
    _controller?.stop();
    _controller?.dispose(); // Dispose of the AnimationController
    super.dispose();
  }

  Future<void> fetchVerse() async {
    setState(() {
      isLoading = true;
    });
    Response response;
    if (userId == null) {
      response = await http.post(
        Uri.parse(ApiConstants.verseEndpoint),
      );
    } else {
      response = await http.post(
        Uri.parse(ApiConstants.verseEndpoint),
        body: {'firebase_id': userId},
      );
    }

    if (response.statusCode == 200) {
      if (mounted) {
        setState(
          () {
            verseId = jsonDecode(response.body)["Id"].toString();
            chapter = jsonDecode(response.body)["Chapter"].toString();
            verse = jsonDecode(response.body)["Verse"].toString();
            book = jsonDecode(response.body)["Book"];
            content = jsonDecode(response.body)["Content"];
            bible = "$book $chapter:$verse $content";
            _controller?.forward();
            isLoading = false;
          },
        );

        outputDataFuture = generateOutput();
      }
    } else {
      // Handle error

      verse = response.body;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Cannot fetch verse for now. Please try again later.'),
        ),
      );
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<List<String>> generateOutput() async {
    final response = await _getResponse();

    if (response.statusCode == 200) {
      String res = jsonDecode(response.body)["Explain"];
      List<String> paragraphs = res.split('\n\n');

      if (paragraphs.length == 2) {
        setState(() {
          _controller?.forward();
        });
        return paragraphs;
      } else {
        // If we did not get exactly 2 paragraphs, recursive call.
        await generateOutput();
      }
    } else {
      // Handle error
      print(response.body);
      Navigator.of(context).pop();
    }
    return [];
  }

  Future<http.Response> _getResponse() async {
    return await http.post(
      Uri.parse(
        ApiConstants.explainEndpoint,
      ),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'id': verseId,
        'verse': bible,
        'input': input,
      }),
    );
  }

  Future<void> initializeUserData(userId) async {
    UserService userService = UserService();
    try {
      user_model.User? value = await userService.getUserById(userId);

      if (value == null) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => ProfileNav()),
        );
      }

      setState(() {
        theme = value?.toJson()['theme'];
        subscription = value?.toJson()['subscription'];
      });
      print(theme);
    } catch (error) {
      print('Error fetching user data: $error');
      // Handle the error here
    }
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
                theme = themeOut;
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
          getBackground(theme),
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
                              Text(content,
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
                                "$book $chapter:$verse",
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
                    if (content.isNotEmpty && !isLoading)
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
                                // if the swipe is in upward direction
                                int themeOut = await Navigator.of(context).push(
                                  PageRouteBuilder(
                                    pageBuilder: (context, animation,
                                            secondaryAnimation) =>
                                        ExplainationPage(
                                            bible: bible,
                                            verseId: verseId,
                                            generateOutputFuture:
                                                outputDataFuture,
                                            theme: theme),
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
                                setState(() {
                                  theme = themeOut;
                                });
                              }
                              setState(() {
                                _offsetY =
                                    0.0; // Reset the offset after the navigation
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
          if (isLoading)
            Center(
              child: ThreeBodySimulation(),
            ),
        ],
      ),
    );
  }
}
