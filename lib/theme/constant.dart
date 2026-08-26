import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// ============================================================
/// COLORS
/// All app-wide colors live here.
/// Change a value once, and it updates everywhere it's used.
/// ============================================================
class AppColors {
  AppColors._(); // prevent instantiation

  static const Color background = Color(0xFF3B0A0A); // dark maroon
  static const Color primaryRed = Color(0xFFE63946); // logo / accent red
  static const Color white = Colors.white;
  static const Color black = Colors.black;
  static const Color onboardingBg = Colors.white;
  static const Color accentBlue = Color(0xFF2F9BF0); // "Next" button blue
  static const Color textDark = Color(0xFF1A1A1A);
  static const Color textGrey = Color(0xFF6B6B6B);
  static const Color dotInactive = Color(0xFFD9D9D9);
  static const Color submitRed = Color(0xFFA31D2C); // login "Submit" button
  static const Color inputBorder = Color(0xFFE0E0E0);
  static const Color placeholderGrey = Color(0xFF9E9E9E);
  static const Color arrowInactive = Color(0xFFBDBDBD); // disabled back arrow
  static const Color skipGrey = Color(0xFF8A8A8A);
  static const Color iconCircleBg = Color(0xFFFCEBEC); // light pink icon background
}

/// ============================================================
/// TEXT STYLES
/// All app-wide text styles live here.
/// Pulls the Poppins font family from google_fonts.
/// ============================================================
class AppTextStyles {
  AppTextStyles._(); // prevent instantiation

  // Onboarding title — "Find your perfect Dream home right now !"
  // Figma spec: Poppins, SemiBold, 24px, 150% line height, 0% letter spacing
  static TextStyle get onboardingTitle => GoogleFonts.poppins(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: AppColors.black,
        height: 1.5,
        letterSpacing: 0,
      );

  // Onboarding subtitle — "Our properties are masterpiece..."
  static TextStyle get onboardingSubtitle => GoogleFonts.poppins(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: AppColors.textGrey,
        height: 1.4,
      );

  // Button label — "Get Started" / "Next"
  static TextStyle get buttonLabel => GoogleFonts.poppins(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: AppColors.white,
      );

  // Login screen — "Get Started now"
  static TextStyle get loginTitle => GoogleFonts.poppins(
        fontSize: 22,
        fontWeight: FontWeight.w700,
        color: AppColors.black,
      );

  // Login screen — "Please log in to explore about Hansy Real Estate"
  static TextStyle get loginSubtitle => GoogleFonts.poppins(
        fontSize: 13,
        fontWeight: FontWeight.w400,
        color: AppColors.textGrey,
      );

  // Field labels — "Email" / "Password"
  static TextStyle get fieldLabel => GoogleFonts.poppins(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: AppColors.black,
      );
}