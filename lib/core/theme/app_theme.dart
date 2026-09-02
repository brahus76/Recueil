import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get light {
    final base = ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.indigo,
        primary: AppColors.indigo,
        secondary: AppColors.gold,
        surface: AppColors.cream,
        brightness: Brightness.light,
      ),
      scaffoldBackgroundColor: AppColors.cream,
    );

    return base.copyWith(
      textTheme: base.textTheme
          .apply(
        bodyColor: AppColors.ink,
        displayColor: AppColors.ink,
      )
          .copyWith(
        headlineMedium: GoogleFonts.fraunces(
          fontSize: 26,
          fontWeight: FontWeight.w600,
          color: AppColors.ink,
        ),
        headlineSmall: GoogleFonts.fraunces(
          fontSize: 19,
          fontWeight: FontWeight.w600,
          color: AppColors.ink,
        ),
        bodyLarge: GoogleFonts.workSans(fontSize: 16, color: AppColors.ink),
        bodyMedium: GoogleFonts.workSans(fontSize: 14, color: AppColors.ink),
        labelSmall: GoogleFonts.spaceMono(fontSize: 11, color: AppColors.inkSoft),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.cream,
        foregroundColor: AppColors.ink,
        elevation: 0,
        titleTextStyle: GoogleFonts.fraunces(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: AppColors.ink,
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.indigo,
        selectedItemColor: AppColors.gold,
        unselectedItemColor: Color(0xFF8B92B4),
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}