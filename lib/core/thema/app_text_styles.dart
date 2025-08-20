import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_colors.dart';

class AppTextStyles {
  static TextStyle get h1 =>
      TextStyle(fontSize: 32.sp, fontWeight: FontWeight.bold, color: AppColors.textPrimary);

  static TextStyle get h2 =>
      TextStyle(fontSize: 28.sp, fontWeight: FontWeight.bold, color: AppColors.textPrimary);

  static TextStyle get h3 =>
      TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold, color: AppColors.textPrimary);

  static TextStyle get h4 =>
      TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold, color: AppColors.textPrimary);

  static TextStyle get h5 =>
      TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600, color: AppColors.textPrimary);

  static TextStyle get h6 =>
      TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600, color: AppColors.textPrimary);

  static TextStyle get bodyLarge =>
      TextStyle(fontSize: 16.sp, fontWeight: FontWeight.normal, color: AppColors.textPrimary);

  static TextStyle get bodyMedium =>
      TextStyle(fontSize: 14.sp, fontWeight: FontWeight.normal, color: AppColors.textPrimary);

  static TextStyle get bodySmall =>
      TextStyle(fontSize: 12.sp, fontWeight: FontWeight.normal, color: AppColors.textSecondary);

  static TextStyle get buttonLarge =>
      TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600, color: AppColors.textOnPrimary);

  static TextStyle get buttonMedium =>
      TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600, color: AppColors.textOnPrimary);

  static TextStyle get splashTitle =>
      TextStyle(fontSize: 32.sp, fontWeight: FontWeight.bold, color: AppColors.textOnPrimary);

  static TextStyle get splashSubtitle =>
      TextStyle(fontSize: 16.sp, fontWeight: FontWeight.normal, color: AppColors.textOnSecondary);

  static TextStyle get welcomeTitle =>
      TextStyle(fontSize: 28.sp, fontWeight: FontWeight.bold, color: AppColors.textPrimary);

  static TextStyle get welcomeSubtitle =>
      TextStyle(fontSize: 16.sp, fontWeight: FontWeight.normal, color: AppColors.textSecondary);

  static TextStyle get userNameStyle =>
      TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold, color: AppColors.textOnPrimary);

  static TextStyle get userEmailStyle =>
      TextStyle(fontSize: 14.sp, fontWeight: FontWeight.normal, color: AppColors.textOnSecondary);

  static TextStyle get cardTitle =>
      TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600, color: AppColors.textPrimary);

  static TextStyle get cardSubtitle =>
      TextStyle(fontSize: 12.sp, fontWeight: FontWeight.normal, color: AppColors.textSecondary);

  static TextStyle get welcomeBackStyle =>
      TextStyle(fontSize: 16.sp, fontWeight: FontWeight.normal, color: AppColors.textOnSecondary);
}
