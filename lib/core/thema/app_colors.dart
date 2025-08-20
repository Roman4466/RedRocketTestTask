// lib/core/theme/app_colors.dart
import 'package:flutter/material.dart';

class AppColors {
  // Primary Colors
  static const Color primary = Color(0xFF673AB7); // Deep Purple
  static const Color primaryLight = Color(0xFF9575CD);
  static const Color primaryDark = Color(0xFF512DA8);

  // Secondary Colors
  static const Color secondary = Color(0xFF2196F3); // Blue
  static const Color secondaryLight = Color(0xFF64B5F6);
  static const Color secondaryDark = Color(0xFF1976D2);

  // Background Colors
  static const Color background = Color(0xFFF5F5F5);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceVariant = Color(0xFFF0F0F0);

  // Text Colors
  static const Color textPrimary = Color(0xFF212121);
  static const Color textSecondary = Color(0xFF757575);
  static const Color textLight = Color(0xFF9E9E9E);
  static const Color textOnPrimary = Color(0xFFFFFFFF);
  static const Color textOnSecondary = Color(0xB3FFFFFF); // 70% opacity white

  static const Color error = Color(0xFFD32F2F);
  static const Color success = Color(0xFF388E3C);
  static const Color warning = Color(0xFFF57C00);
  static const Color info = Color(0xFF1976D2);

  static const Color testCredentialsBg = Color(0xFFE3F2FD);
  static const Color testCredentialsBorder = Color(0xFF90CAF9);
  static const Color testCredentialsText = Color(0xFF1565C0);
  static const Color testCredentialsTitle = Color(0xFF0D47A1);

  // Card and Elevation Colors
  static const Color cardBackground = Color(0xFFFFFFFF);
  static const Color cardShadow = Color(0x1F000000);

  // Input Field Colors
  static const Color inputFill = Color(0xFFFFFFFF);
  static const Color inputBorder = Color(0xFFE0E0E0);
  static const Color inputFocused = primary;

  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primary, primaryLight],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient welcomeGradient = LinearGradient(
    colors: [primary, Color(0xFF9575CD)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}