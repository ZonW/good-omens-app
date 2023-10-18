import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:good_omens/pages/home/personal_query.dart';
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
  String output = '';
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
      duration: const Duration(seconds: 5), // Adjust the duration as needed
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

    final response = await http.post(
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

    if (response.statusCode == 200) {
      setState(() {
        output = jsonDecode(response.body)["Explain"];
        _controller?.forward();
        isLoading = false;
      });
    } else {
      // Handle error
      print(response.body);
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double opacity = 1.0 - (_offsetY / 100).clamp(0, 1.0);
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
          ImageFiltered(
            imageFilter: ImageFilter.blur(sigmaX: 50.0, sigmaY: 50.0),
            child: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                Positioned(
                  top: 0,
                  left: 0,
                  child: SvgPicture.asset('assets/img/Eclipse1.svg',
                      semanticsLabel: 'eclipse'),
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  child: SvgPicture.asset('assets/img/Eclipse2.svg',
                      semanticsLabel: 'eclipse'),
                ),
              ],
            ),
          ),
          if (isLoading) Center(child: ThreeBodySimulation()),

          // Main Content
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Top arrow button
                Align(
                  alignment: Alignment.center,
                  child: Transform.translate(
                    offset: Offset(0, _offsetY),
                    child: Opacity(
                      opacity: opacity,
                      child: GestureDetector(
                        onVerticalDragUpdate: (details) {
                          setState(() {
                            _offsetY += details.delta.dy;
                          });
                        },
                        onVerticalDragEnd: (details) {
                          if (_offsetY > 0) {
                            Navigator.of(context).pop();
                          }
                          setState(() {
                            _offsetY = 0.0;
                          });
                        },
                        child: SvgPicture.asset(
                          'assets/img/down.svg',
                          semanticsLabel: 'refresh',
                          height: screenWidth * 0.25,
                          width: screenWidth * 0.25,
                        ),
                      ),
                    ),
                  ),
                ),
                // Expanded main content
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        if (output.isNotEmpty && !isLoading) ...[
                          const SizedBox(height: 20),
                          FadeTransition(
                            opacity: _animation ?? AlwaysStoppedAnimation(0),
                            child: Text(
                              output,
                              style: Theme.of(context).textTheme.displayMedium,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
                // Buttom arrow button
                if (output.isNotEmpty && !isLoading)
                  FadeTransition(
                    opacity: _animation ?? AlwaysStoppedAnimation(0),
                    child: Align(
                      alignment: Alignment.center,
                      child: Transform.translate(
                        offset: Offset(0, _offsetY),
                        child: Opacity(
                          opacity: opacity,
                          child: GestureDetector(
                            onVerticalDragUpdate: (details) {
                              setState(() {
                                _offsetY += details.delta.dy;
                              });
                            },
                            onVerticalDragEnd: (details) {
                              if (_offsetY < 0) {
                                Navigator.of(context).push(
                                  PageRouteBuilder(
                                    pageBuilder: (context, animation,
                                            secondaryAnimation) =>
                                        QueryPage(
                                      bible: widget.bible,
                                    ),
                                    transitionsBuilder: (context, animation,
                                        secondaryAnimation, child) {
                                      const begin = Offset(0.0, 1.0);
                                      const end = Offset.zero;
                                      const curve = Curves.easeInOut;

                                      var tween = Tween(begin: begin, end: end)
                                          .chain(CurveTween(curve: curve));
                                      var offsetAnimation =
                                          animation.drive(tween);

                                      return SlideTransition(
                                        position: offsetAnimation,
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
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
