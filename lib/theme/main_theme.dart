import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTheme {
  static ThemeData get theme {
    return ThemeData(
      textTheme: TextTheme(
        titleMedium: GoogleFonts.nunito(
          fontSize: 20,
          fontWeight: FontWeight.w900,
        ),
        displayMedium: GoogleFonts.nunito(
          fontSize: 20,
          fontWeight: FontWeight.w400,
          fontStyle: FontStyle.normal,
          color: Color.fromARGB(255, 255, 255, 255),
        ),
        bodySmall: GoogleFonts.nunito(
          fontSize: 20,
          fontWeight: FontWeight.w800,
          color: Color.fromARGB(255, 255, 255, 255),
        ),
        labelMedium: GoogleFonts.nunito(
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
