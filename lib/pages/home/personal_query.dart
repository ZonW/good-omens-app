import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:good_omens/pages/home/chat.dart';
import 'package:good_omens/pages/home/query_output.dart';
import 'package:good_omens/widgets/user_query_prompt.dart';
import 'package:good_omens/widgets/gradient_button.dart';
import 'package:http/http.dart' as http;
import 'package:good_omens/widgets/three_body.dart';
import 'dart:convert';
import 'package:good_omens/end-points/api.dart';
import 'package:good_omens/pages/profile/profile.dart';
import 'package:good_omens/widgets/gradient_circle.dart';

class QueryPage extends StatefulWidget {
  final String bible;
  int theme;

  QueryPage({
    super.key,
    required this.bible,
    required this.theme,
  });
  @override
  _QueryState createState() => _QueryState();
}

class _QueryState extends State<QueryPage> with SingleTickerProviderStateMixin {
  String input = '';
  String output = '';
  bool isLoading = false;
  double _offsetY = 0.0;
  AnimationController? _controller;
  Animation<double>? _animation;
  final FocusNode mainFocusNode = FocusNode();

  TextEditingController inputController = TextEditingController();

  String randomPrompt = '';

  void getRandomPrompt() {
    final random = Random();
    int randomIndex = random.nextInt(prompts.length);
    setState(() {
      randomPrompt = prompts[randomIndex];
    });
  }

  @override
  void initState() {
    super.initState();
    getRandomPrompt();
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
    int themeOut = await Navigator.of(context).push(
      PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => ChatPage(
                quote: widget.bible,
                input: input,
                theme: widget.theme,
              ),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(1.0, 0.0);
            const end = Offset.zero;
            const curve = Curves.easeOut;

            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            var offsetAnimation = animation.drive(tween);

            return SlideTransition(
              position: offsetAnimation,
              child: child,
            );
          },
          transitionDuration: const Duration(milliseconds: 500)),
    );
    setState(() {
      widget.theme = themeOut;
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
      onWillPop: () async {
        Navigator.of(context).pop(widget.theme);
        return false;
      },
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
                  onPressed: () {}),
            ],
          ),
        ),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(mainFocusNode);
          },
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 100),
                      Transform.scale(
                        scaleX: 1.4,
                        scaleY: 1.3,
                        child: ShaderMask(
                          shaderCallback: (bounds) {
                            return textGradient.createShader(
                                Rect.fromLTWH(0, 14, screenWidth, 70));
                          },
                          child: const Text(
                            "What's been on \nyour mind lately?",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 30,
                              height: 1.5,
                              fontFamily: 'Nunito',
                              fontWeight: FontWeight.w500,
                              color: Colors
                                  .white, // Important to ensure the gradient works
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      ShaderMask(
                        shaderCallback: (bounds) {
                          return textGradient.createShader(
                              Rect.fromLTWH(0, 0, screenWidth, 18));
                        },
                        child: const Text(
                          "Seek guidance in alignment with the quote",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Nunito',
                            fontWeight: FontWeight.w400,
                            color: Colors
                                .white, // Important to ensure the gradient works
                          ),
                        ),
                      ),
                      GradientCircle(),
                      Container(
                        width: screenWidth,
                        height: 117,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Color(0xFFE99FA8), // Top Left color
                              Color(0xFFD7CEE7), // Center color
                              Color(0xFF91A0CD), // Bottom Right color
                            ],
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(1.0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              shape: BoxShape.rectangle,
                              color: const Color(0xFF1E1E1E),
                            ),
                            child: TextField(
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
                              decoration: InputDecoration(
                                hintText: randomPrompt,
                                border: InputBorder.none,
                                hintStyle: TextStyle(
                                    color: Colors.white54,
                                    fontFamily: 'Nunito',
                                    fontStyle: FontStyle.italic,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w200),
                              ),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                              controller: inputController,
                              onChanged: (val) {
                                input = val;
                              },
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      if (!isLoading)
                        Container(
                          width: screenWidth,
                          height: 56,
                          child: GradientButton(
                            text: 'Submit',
                            onPressed: generateOutput,
                          ),
                        ),
                    ],
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
      ),
    );
  }
}
