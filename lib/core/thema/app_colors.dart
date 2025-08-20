import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFF673AB7);

  static const Color secondary = Color(0xFF2196F3);

  static const Color background = Color(0xFFF5F5F5);
  static const Color surface = Color(0xFFFFFFFF);

  static const Color textPrimary = Color(0xFF212121);
  static const Color textSecondary = Color(0xFF757575);
  static const Color textLight = Color(0xFF9E9E9E);
  static const Color textOnPrimary = Color(0xFFFFFFFF);
  static const Color textOnSecondary = Color(0xB3FFFFFF);

  static const Color error = Color(0xFFD32F2F);
  static const Color warning = Color(0xFFF57C00);

  static const Color inputFill = Color(0xFFFFFFFF);
  static const Color inputBorder = Color(0xFFE0E0E0);
  static const Color inputFocused = primary;
  static const LinearGradient welcomeGradient = LinearGradient(
    colors: [primary, Color(0xFF9575CD)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
