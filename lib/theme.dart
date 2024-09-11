import 'package:flutter/material.dart';

const Color kBlack = Color(0xFF121212);
const Color kPurple = Color(0xFF8687E7);
const Color kDarkGrey = Color(0xFF1D1D1D);
const Color kGrey = Color(0xFF363636);
const Color kWhite = Color(0xFFFFFFFF);
const Color kRed = Colors.red;

class ThemeClass {
  static ThemeData lightmode = ThemeData(
    brightness: Brightness.light,
    colorScheme: const ColorScheme.light(
      primary: kPurple,
    ),
  );
  static ThemeData darkmode = ThemeData(
    brightness: Brightness.dark,
    colorScheme: const ColorScheme.dark(
      primary: kPurple,
    ),
  );
}

ThemeClass _themeClass = ThemeClass();
