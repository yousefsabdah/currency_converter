import 'package:flutter/material.dart';

/// Central place for application-wide theming.
///
/// Having this in `core` makes it easy to reuse and test, and keeps
/// `main.dart` very small.
class AppTheme {
  AppTheme._();

  static const _seedColor = Colors.indigo;

  static ThemeData get light => ThemeData(
        useMaterial3: true,
        colorSchemeSeed: _seedColor,
        brightness: Brightness.light,
      );

  static ThemeData get dark => ThemeData(
        useMaterial3: true,
        colorSchemeSeed: _seedColor,
        brightness: Brightness.dark,
      );
}


