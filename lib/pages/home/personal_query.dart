import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:good_omens/widgets/background2.dart';
import 'package:http/http.dart' as http;
import 'package:good_omens/widgets/three_body.dart';
import 'dart:convert';
import 'package:good_omens/end-points/api.dart';
import 'package:good_omens/pages/profile/profile.dart';
import 'package:good_omens/widgets/gradient_circle.dart';

class QueryPage extends StatefulWidget {
  final String bible;

  QueryPage({
    super.key,
    required this.bible,
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

  TextEditingController inputController = TextEditingController();

  @override
  void initState() {
    super.initState();
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
      extendBodyBehindAppBar: true,
      backgroundColor: Color(0xFF1E1E1E),
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
          if (isLoading)
            Center(
              child: ThreeBodySimulation(),
            ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  if (output.isNotEmpty && !isLoading) ...[
                    FadeTransition(
                      opacity: _animation ?? AlwaysStoppedAnimation(0),
                      child: Text(
                        output,
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                    ),
                  ] else
                    GradientCircle(),

                  SizedBox(height: 20), // Give some space after the SVG
                  Container(
                    width: screenWidth * 0.9,
                    child: TextField(
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                      controller: inputController,
                      decoration: const InputDecoration(
                          labelText: "What's in your mind?"),
                      onChanged: (val) {
                        input = val;
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
