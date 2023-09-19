// import 'dart:ui';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';

// class _YourWidgetState extends State<YourWidget> {
//   double _offsetY = 0.0;

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onVerticalDragUpdate: (details) {
//         setState(() {
//           _offsetY += details.delta.dy;
//         });
//       },
//       onVerticalDragEnd: (details) {
//         if (_offsetY < 0) {
//           // if the swipe is in upward direction
//           Navigator.of(context).push(
//             PageRouteBuilder(
//               pageBuilder: (context, animation, secondaryAnimation) =>
//                   ExplainationPage(
//                 bible: bible,
//               ),
//               transitionsBuilder:
//                   (context, animation, secondaryAnimation, child) {
//                 const begin = Offset(0.0, 1.0);
//                 const end = Offset.zero;
//                 const curve = Curves.ease;

//                 var tween = Tween(begin: begin, end: end)
//                     .chain(CurveTween(curve: curve));
//                 var offsetAnimation = animation.drive(tween);

//                 return SlideTransition(
//                   position: offsetAnimation,
//                   child: child,
//                 );
//               },
//             ),
//           );
//         }
//         setState(() {
//           _offsetY = 0.0; // Reset the offset after the navigation
//         });
//       },
//       child: Transform.translate(
//         offset: Offset(0, _offsetY),
//         child: SvgPicture.asset(
//           'assets/img/up.svg',
//           semanticsLabel: 'refresh',
//           height: screenWidth * 0.25,
//           width: screenWidth * 0.25,
//         ),
//       ),
//     );
//   }
// }
