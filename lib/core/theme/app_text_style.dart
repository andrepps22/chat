import 'package:flutter/material.dart';

class AppTextStyles {
  static TextStyle title(Color color) => TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: color,
      );

  static TextStyle body(Color color) => TextStyle(
        fontSize: 16,
        color: color,
      );

  static TextStyle caption(Color color) => TextStyle(
        fontSize: 12,
        color: color.withAlpha(7),
      );
}
