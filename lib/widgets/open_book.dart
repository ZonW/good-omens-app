import 'package:flutter/material.dart';

class OpenBookWidget extends StatefulWidget {
  @override
  _OpenBookWidgetState createState() => _OpenBookWidgetState();
}

class _OpenBookWidgetState extends State<OpenBookWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _leftPageAnimation;
  late Animation<double> _rightPageAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _leftPageAnimation = Tween<double>(begin: 0, end: -1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _rightPageAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void toggleBook() {
    if (_controller.isCompleted) {
      _controller.reverse();
    } else {
      _controller.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => toggleBook(),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Left Page
          AnimatedBuilder(
            animation: _leftPageAnimation,
            builder: (context, child) {
              return Transform(
                alignment: Alignment.centerRight,
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.001) // perspective
                  ..rotateY(_leftPageAnimation.value * 3.1415927 / 2),
                child: Image.asset('assets/left_page.png'),
              );
            },
          ),
          // Right Page
          AnimatedBuilder(
            animation: _rightPageAnimation,
            builder: (context, child) {
              return Transform(
                alignment: Alignment.centerLeft,
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.001) // perspective
                  ..rotateY(_rightPageAnimation.value * 3.1415927 / 2),
                child: Image.asset('assets/right_page.png'),
              );
            },
          ),
        ],
      ),
    );
  }
}
