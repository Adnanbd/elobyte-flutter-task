import 'package:elo_byte_task/src/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData lightTheme = ThemeData.light().copyWith(
  useMaterial3: true,
  scaffoldBackgroundColor: whiteColor,
  colorScheme: const ColorScheme.light(
    background: Colors.green,
  ),
  textTheme: TextTheme(
    headlineLarge: GoogleFonts.plusJakartaSans(
      fontSize: 36,
      fontWeight: FontWeight.w700,
      color: darkColor,
    ),
    headlineMedium: GoogleFonts.plusJakartaSans(
      fontSize: 24,
      fontWeight: FontWeight.w700,
    ),
    titleMedium: GoogleFonts.manrope(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: darkColor,
    ),
    labelLarge: GoogleFonts.manrope(
      fontSize: 16,
      fontWeight: FontWeight.w600,
    ),
    bodyMedium: GoogleFonts.manrope(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: darkColor,
    ),
  ),
  buttonTheme: ButtonThemeData(
    minWidth: double.infinity,
    buttonColor: const Color(0xFF20C56C),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(48),
    ),
    height: 56,
  ),
);

ThemeData darkTheme = ThemeData.dark().copyWith(
  scaffoldBackgroundColor: darkBackgroundColor,
  useMaterial3: true,
  textTheme: TextTheme(
    headlineLarge: GoogleFonts.plusJakartaSans(
      fontSize: 36,
      fontWeight: FontWeight.w700,
      color: whiteColor,
    ),
    headlineMedium: GoogleFonts.plusJakartaSans(
      fontSize: 24,
      fontWeight: FontWeight.w700,
    ),
    titleMedium: GoogleFonts.manrope(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: whiteColor,
    ),
    labelLarge: GoogleFonts.manrope(
      fontSize: 16,
      fontWeight: FontWeight.w600,
    ),
    bodyMedium: GoogleFonts.manrope(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: whiteColor,
    ),
  ),
  buttonTheme: ButtonThemeData(
    minWidth: double.infinity,
    buttonColor: const Color(0xFF20C56C),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(48),
    ),
    height: 56,
  ),
);
