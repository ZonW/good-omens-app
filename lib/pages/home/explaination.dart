import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:good_omens/pages/home/guidance.dart';
import 'package:good_omens/pages/home/personal_query.dart';
import 'package:good_omens/widgets/background1.dart';
import 'package:good_omens/widgets/background2.dart';
import 'package:good_omens/widgets/see_more.dart';
import 'package:http/http.dart' as http;
import 'package:good_omens/widgets/three_body.dart';
import 'dart:convert';
import 'package:good_omens/end-points/api.dart';
import 'package:good_omens/pages/profile/profile.dart';

class ExplainationPage extends StatefulWidget {
  final String bible;
  final String verseId;

  ExplainationPage({
    super.key,
    required this.bible,
    required this.verseId,
  });
  @override
  _ExplainationState createState() => _ExplainationState();
}

class _ExplainationState extends State<ExplainationPage>
    with SingleTickerProviderStateMixin {
  String input = '';
  String explanation = '';
  String guidance = '';
  bool isLoading = false;
  double _offsetY = 0.0;
  AnimationController? _controller;
  Animation<double>? _animation;

  TextEditingController inputController = TextEditingController();

  @override
  void initState() {
    super.initState();
    generateOutput();
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
    _controller!.dispose();
    super.dispose();
  }

  Future<void> generateOutput() async {
    setState(() {
      isLoading = true;
    });

    final response = await _getResponse();

    if (response.statusCode == 200) {
      String res = jsonDecode(response.body)["Explain"];
      List<String> paragraphs = res.split('\n\n');

      if (paragraphs.length == 2) {
        String firstParagraph = paragraphs[0];
        String secondParagraph = paragraphs[1];

        setState(() {
          explanation = firstParagraph;
          guidance = secondParagraph;
          _controller?.forward();
          isLoading = false;
        });
      } else {
        // If we did not get exactly 2 paragraphs, try again.
        await generateOutput();
      }
    } else {
      // Handle error
      print(response.body);
      setState(() {
        isLoading = false;
      });
    }
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
        'id': widget.verseId,
        'verse': widget.bible,
        'input': input,
      }),
    );
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
          if (isLoading) Center(child: ThreeBodySimulation()),

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
                          if (explanation.isNotEmpty && !isLoading) ...[
                            const SizedBox(height: 20),
                            FadeTransition(
                              opacity: _animation ?? AlwaysStoppedAnimation(0),
                              child: Text(
                                explanation,
                                style:
                                    Theme.of(context).textTheme.displayMedium,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),

                    // Buttom arrow button
                    if (explanation.isNotEmpty && !isLoading)
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
                                          GuidancePage(
                                        bible: widget.bible,
                                        guidance: guidance,
                                      ),
                                      transitionsBuilder: (context, animation,
                                          secondaryAnimation, child) {
                                        const begin = 0.0;
                                        const end = 1.0;
                                        const curve = Curves.easeInOut;

                                        var tween = Tween(
                                                begin: begin, end: end)
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
