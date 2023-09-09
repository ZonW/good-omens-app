import 'package:flutter/material.dart';

class CustomTheme {
  static ThemeData get theme {
    return ThemeData(
      primarySwatch: Colors.purple,
      primaryColor: Colors.purple[900],
      scaffoldBackgroundColor: Color.fromARGB(255, 55, 9, 182),
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: Color.fromARGB(255, 208, 208, 208),
        ),
      ),
      inputDecorationTheme: const InputDecorationTheme(
        labelStyle: TextStyle(
          fontSize: 20,
          color: Color.fromARGB(255, 255, 255, 255),
        ),
      ),
    );
  }
}
