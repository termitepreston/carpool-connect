import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  static const primary = Color(0xFFFF385C);
  static const primaryActive = Color(0xFFE00B41);
  static const primaryDisabled = Color(0xFFFFD1DA);
  static const ink = Color(0xFF222222);
  static const body = Color(0xFF3F3F3F);
  static const muted = Color(0xFF6A6A6A);
  static const hairline = Color(0xFFDDDDDD);
  static const canvas = Color(0xFFFFFFFF);
  static const surfaceSoft = Color(0xFFF7F7F7);
  static const surfaceStrong = Color(0xFFF2F2F2);
  static const error = Color(0xFFC13515);
}

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      scaffoldBackgroundColor: AppColors.canvas,
      primaryColor: AppColors.primary,
      colorScheme: const ColorScheme.light(
        primary: AppColors.primary,
        secondary: AppColors.ink,
        surface: AppColors.canvas,
        error: AppColors.error,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.canvas,
        foregroundColor: AppColors.ink,
        elevation: 0,
        centerTitle: true,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.canvas,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          minimumSize: const Size.fromHeight(48),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.ink,
          side: const BorderSide(color: AppColors.ink, width: 1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 23, vertical: 13),
          minimumSize: const Size.fromHeight(48),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.canvas,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.hairline, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.hairline, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.ink, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      ),
      textTheme: GoogleFonts.interTextTheme(const TextTheme(
        displayLarge: TextStyle(color: AppColors.ink, fontSize: 28, fontWeight: FontWeight.w700),
        displayMedium: TextStyle(color: AppColors.ink, fontSize: 22, fontWeight: FontWeight.w500),
        titleLarge: TextStyle(color: AppColors.ink, fontSize: 20, fontWeight: FontWeight.w600),
        titleMedium: TextStyle(color: AppColors.ink, fontSize: 16, fontWeight: FontWeight.w600),
        bodyLarge: TextStyle(color: AppColors.ink, fontSize: 16, fontWeight: FontWeight.w400),
        bodyMedium: TextStyle(color: AppColors.body, fontSize: 14, fontWeight: FontWeight.w400),
      )).apply(
        fontFamilyFallback: [GoogleFonts.notoSerifEthiopic().fontFamily!],
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: const Color(0xFF121212),
      primaryColor: AppColors.primary,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primary,
        secondary: Colors.white,
        surface: Color(0xFF1E1E1E),
        error: AppColors.error,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF121212),
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      elevatedButtonTheme: lightTheme.elevatedButtonTheme,
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: Colors.white,
          side: const BorderSide(color: Colors.white, width: 1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 23, vertical: 13),
          minimumSize: const Size.fromHeight(48),
        ),
      ),
      textTheme: GoogleFonts.interTextTheme(const TextTheme(
        displayLarge: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.w700),
        displayMedium: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w500),
        titleLarge: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600),
        titleMedium: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
        bodyLarge: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w400),
        bodyMedium: TextStyle(color: Color(0xFFE0E0E0), fontSize: 14, fontWeight: FontWeight.w400),
      )).apply(
        fontFamilyFallback: [GoogleFonts.notoSerifEthiopic().fontFamily!],
      ),
    );
  }
}
