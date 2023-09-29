import 'package:flutter/material.dart';

class AppThemes {
  static final lightTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.black,
    ),
    useMaterial3: true,
    appBarTheme: const AppBarTheme(
      scrolledUnderElevation: 0,
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        backgroundColor: Colors.black,
        textStyle: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 18,
        ),
      ),
    ),
  );
}
