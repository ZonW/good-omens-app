import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTheme {
  static ThemeData get theme {
    final Shader linearGradient = const LinearGradient(
      colors: <Color>[
        Color.fromARGB(255, 193, 11, 157),
        Color.fromARGB(255, 203, 169, 237),
      ],
    ).createShader(
      Rect.fromLTWH(0.0, 0.0, 200.0, 70.0),
    );
    return ThemeData(
      primarySwatch: Colors.purple,
      primaryColor: Colors.purple[900],
      scaffoldBackgroundColor: const Color.fromARGB(255, 55, 9, 182),
      textTheme: TextTheme(
        titleMedium: GoogleFonts.nunito(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          foreground: Paint()..shader = linearGradient,
        ),
        bodyMedium: GoogleFonts.nunito(
          fontSize: 20,
          fontWeight: FontWeight.w500,
          color: const Color(0xFF171717),
        ),
        headlineMedium: GoogleFonts.nunito(
          fontSize: 32,
          fontWeight: FontWeight.w800,
          color: Colors.black,
        ),
        // Add other text styles here
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
