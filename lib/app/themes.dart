import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData? myThemes = ThemeData(
    primarySwatch: Colors.indigo,
    textTheme: TextTheme(
        bodyMedium: GoogleFonts.asap(
          fontSize: 16,
          color: const Color.fromARGB(255, 39, 17, 17),
        ),
        labelMedium: GoogleFonts.titilliumWeb(
            fontSize: 20,
            color: const Color.fromARGB(255, 19, 38, 141),
            fontWeight: FontWeight.bold),
        displayMedium: GoogleFonts.asapCondensed(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: const Color.fromARGB(255, 68, 59, 95),
        ),
        headlineSmall: GoogleFonts.asap(
            fontSize: 17, color: Colors.indigo, fontWeight: FontWeight.bold)));
