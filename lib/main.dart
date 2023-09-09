import 'package:flutter/material.dart';
import 'package:good_omens/pages/verse.dart';
import 'package:good_omens/theme/main_theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: CustomTheme.theme,
      home: VersePage(),
    );
  }
}
