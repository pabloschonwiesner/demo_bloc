import 'package:flutter/material.dart';
import 'package:demo_provider/ui/core/app_colors.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData.light().copyWith(
    primaryColor: AppColors.primary,

    appBarTheme: const AppBarTheme(
      color: AppColors.primary,
      elevation: 0
    ),

    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.primary
    ),
  );  
}