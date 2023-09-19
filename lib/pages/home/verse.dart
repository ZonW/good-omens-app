import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'package:good_omens/widgets/three_body.dart';
import 'dart:convert';
import 'package:good_omens/end-points/api.dart';
import 'package:good_omens/pages/profile/profile.dart';
import 'package:good_omens/pages/home/explaination.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share/share.dart';
import 'dart:typed_data';

class VersePage extends StatefulWidget {
  @override
  _VersePageState createState() => _VersePageState();
}

class _VersePageState extends State<VersePage>
    with SingleTickerProviderStateMixin {
  double _offsetY = 0.0;
  String bible = '';
  String verse = '';
  String book = '';
  String chapter = '';
  String content = '';
  String input = '';
  String output = '';
  bool isLoading = false;
  AnimationController? _controller;
  Animation<double>? _animation;
  final ScreenshotController screenshotController = ScreenshotController();

  @override
  void initState() {
    super.initState();
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

  Future<void> fetchVerse() async {
    setState(() {
      isLoading = true;
    });
    final response = await http.get(Uri.parse(ApiConstants.verseEndpoint));
    if (response.statusCode == 200) {
      setState(() {
        chapter = jsonDecode(response.body)["Chapter"].toString();
        verse = jsonDecode(response.body)["Verse"].toString();
        book = jsonDecode(response.body)["Book"];
        content = jsonDecode(response.body)["Content"];
        bible = "$book $chapter:$verse $content";
        _controller?.forward();
        isLoading = false;
      });
    } else {
      // Handle error
      verse = response.body;
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double opacity =
        (1.0 - (_offsetY.abs() / screenHeight * 4)).clamp(0.0, 1.0);
    return Scaffold(
      backgroundColor: Color(0xFF171717),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(62),
        child: AppBar(
          backgroundColor: Color.fromARGB(0, 0, 0, 0),
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
          title: Text(
            'Good Omens',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium,
          ),
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
          ImageFiltered(
            imageFilter: ImageFilter.blur(sigmaX: 50.0, sigmaY: 50.0),
            child: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                Positioned(
                  top: 0,
                  left: 0,
                  child: SvgPicture.asset('assets/img/eclipse1.svg',
                      semanticsLabel: 'eclipse'),
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  child: SvgPicture.asset('assets/img/eclipse2.svg',
                      semanticsLabel: 'eclipse'),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
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
                          Text(
                            content,
                            style: Theme.of(context).textTheme.displayMedium,
                          ),
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
                Positioned(
                  bottom: screenHeight * 0.10, //10% from bottom
                  left: screenWidth * 0.325,
                  child: GestureDetector(
                    onVerticalDragUpdate: (details) {
                      setState(() {
                        _offsetY += details.delta.dy;
                      });
                    },
                    onVerticalDragEnd: (details) {
                      if (_offsetY < 0) {
                        // if the swipe is in upward direction
                        Navigator.of(context).push(
                          PageRouteBuilder(
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    ExplainationPage(
                              bible: bible,
                            ),
                            transitionsBuilder: (context, animation,
                                secondaryAnimation, child) {
                              const begin = Offset(0.0, 1.0);
                              const end = Offset.zero;
                              const curve = Curves.easeInOut;

                              var tween = Tween(begin: begin, end: end)
                                  .chain(CurveTween(curve: curve));
                              var offsetAnimation = animation.drive(tween);

                              return SlideTransition(
                                position: offsetAnimation,
                                child: child,
                              );
                            },
                            transitionDuration: Duration(milliseconds: 500),
                          ),
                        );
                      }
                      setState(() {
                        _offsetY = 0.0; // Reset the offset after the navigation
                      });
                    },
                    child: Transform.translate(
                      offset: Offset(0, _offsetY),
                      child: Opacity(
                        opacity: opacity,
                        child: SvgPicture.asset(
                          'assets/img/up.svg',
                          semanticsLabel: 'refresh',
                          height: screenWidth * 0.25,
                          width: screenWidth * 0.25,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
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
