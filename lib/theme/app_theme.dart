import 'package:flutter/material.dart';

/// App theme configuration for Advanced Tic Tac Toe
///
/// This class contains all the theme-related configurations including:
/// - Color scheme (neon blue and orange)
/// - Typography settings
/// - Component themes (buttons, sliders, chips)
/// - Dark theme configuration
class AppTheme {
  /// Primary neon blue color used throughout the app
  static const Color primaryBlue = Color(0xFF00FFF7);

  /// Secondary neon orange color used for accents
  static const Color secondaryOrange = Color(0xFFFF9900);

  /// Dark background color
  static const Color darkBackground = Color(0xFF181A20);

  /// Surface color for cards and elevated elements
  static const Color surfaceColor = Color(0xFF23252B);

  /// Returns the dark theme configuration for the app
  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: darkBackground,
      primaryColor: primaryBlue,
      colorScheme: const ColorScheme.dark(
        primary: primaryBlue,
        secondary: secondaryOrange,
        surface: surfaceColor,
      ),
      fontFamily: 'Roboto',
      sliderTheme: const SliderThemeData(
        activeTrackColor: secondaryOrange,
        inactiveTrackColor: surfaceColor,
        thumbColor: secondaryOrange,
        overlayColor: Color(0x33FF9900),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: surfaceColor,
          foregroundColor: primaryBlue,
          shadowColor: primaryBlue,
          elevation: 8,
          textStyle: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      chipTheme: const ChipThemeData(
        backgroundColor: surfaceColor,
        selectedColor: secondaryOrange,
        labelStyle: TextStyle(color: primaryBlue),
        secondaryLabelStyle: TextStyle(color: secondaryOrange),
      ),
      iconTheme: const IconThemeData(color: primaryBlue),
    );
  }
}
