import 'package:flutter/material.dart';
import 'app_colors.dart';

final ThemeData lightTheme = ThemeData(
  
  colorScheme: ColorScheme.light(
    primary: AppColors.lightPrimary,
    secondary: AppColors.lightSecondary,
    surface: AppColors.lightBackground,
    tertiary: AppColors.lightTertiary,
    inversePrimary: AppColors.lightInversedPrimary
  ),

  

  textTheme: const TextTheme(),
);
