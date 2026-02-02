import 'package:flutter/material.dart';

// Abstract class to prevent instantiation
abstract class AppColors {
  // BetClic Brand Colors (Approximated)
  static const Color primary = Color(0xFFFFD600); // The famous Yellow
  static const Color primaryVariant = Color(0xFFE5C000);

  static const Color background = Color(0xFF121212); // Deep Dark
  static const Color surface = Color(0xFF1E1E1E); // Card background

  static const Color textPrimary = Colors.white;
  static const Color textSecondary = Colors.white70;
  static const Color textDisabled = Colors.white30;

  static const Color error = Color(0xFFCF6679);
  static const Color success = Color(0xFF4CAF50);

  // Game Specific
  static const Color playerX = primary; // Player gets the brand color
  static const Color playerO = Color(0xFFFAFAFA); // AI is neutral/white
}
