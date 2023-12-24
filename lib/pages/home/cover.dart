import 'dart:io';
import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:good_omens/main.dart';
import 'package:good_omens/pages/home/verse.dart';
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

class CoverPage extends StatefulWidget {
  @override
  _CoverPageState createState() => _CoverPageState();
}

class _CoverPageState extends State<CoverPage>
    with SingleTickerProviderStateMixin {
  double _offsetY = 0.0;
  String verseId = '';
  String bible = '';
  String verse = '';
  String book = '';
  String chapter = '';
  String content = '';
  String input = '';
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
        // //wait for 2 seconds
        // await Future.delayed(const Duration(seconds: 2));

        verseId = jsonDecode(response.body)["Id"].toString();
        chapter = jsonDecode(response.body)["Chapter"].toString();
        verse = jsonDecode(response.body)["Verse"].toString();
        book = jsonDecode(response.body)["Book"];
        content = jsonDecode(response.body)["Content"];
        bible = "$book $chapter:$verse $content";
        _controller?.forward();
        isLoading = false;

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
      List<String> paragraphs = res.split('&&');
      setState(() {
        _controller?.forward();
      });
      return paragraphs;
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
      if (subscription == 0) {
        Provider.of<UserSubscription>(context, listen: false)
            .setSubscription(false);
      } else if (subscription == 1) {
        Provider.of<UserSubscription>(context, listen: false)
            .setSubscription(true);
      }
    } catch (error) {
      print('Error fetching user data: $error');
      // Handle the error here
    }
  }

  Future<bool> _onWillPop() async {
    return false;
  }

  Future<void> handleGesture(BuildContext context) async {
    // Await the result Navigate to the VersePage

    await fetchVerse();

    int themeOut = await Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => VersePage(
          bible: bible,
          book: book,
          chapter: chapter,
          verse: verse,
          content: content,
          verseId: verseId,
          generateOutputFuture: outputDataFuture,
          theme: theme,
        ),
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
      theme = themeOut;
      _offsetY = 0.0; // Reset the offset after the navigation
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double opacity = 1.0 - (_offsetY / 100).clamp(0, 1.0);
    const textGradient = LinearGradient(
      colors: [
        Color(0xFFE99FA8),
        Color(0xFFFFFFFF),
        Color(0xFFBDAFE3),
        Color(0xFFFFFFFF),
      ],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    );
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: const Color(0xFF1E1E1E),
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
                      transitionDuration: const Duration(milliseconds: 500)),
                );
                setState(() {
                  theme = themeOut;
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
                  onPressed: () {}),
            ],
          ),
        ),
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 100),
                  ShaderMask(
                    shaderCallback: (bounds) {
                      return textGradient
                          .createShader(Rect.fromLTWH(0, 16, screenWidth, 32));
                    },
                    child: const Text(
                      "Focus on one question",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 32,
                        height: 1.5,
                        fontFamily: 'Nunito',
                        fontWeight: FontWeight.w500,
                        color: Colors
                            .white, // Important to ensure the gradient works
                      ),
                    ),
                  ),
                  const SizedBox(height: 69),
                  const Text(
                    "When you are ready to see the\n answer, open the Bible",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 22,
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.w400,
                      color: Color(
                          0xFFD8DADC), // Important to ensure the gradient works
                    ),
                  ),
                  const SizedBox(height: 69),
                  if (isLoading)
                    Expanded(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: ThreeBodySimulation(),
                      ),
                    )
                  else
                    Expanded(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: GestureDetector(
                          onTap: () {
                            handleGesture(context);
                          },
                          child: Image.asset('assets/img/bible.png'),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
