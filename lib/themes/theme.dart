// theme.dart
import 'package:flutter/material.dart';

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: const Color(0xFF88B04B),
  scaffoldBackgroundColor: const Color(0xFFF8F9FA),
  cardColor: const Color(0xFFEDE6DB),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Color(0xFF2E2E2E)),
    bodyMedium: TextStyle(color: Color(0xFFA0A4A8)),
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Color.fromARGB(255, 227, 155, 9),
  ),
  colorScheme: ColorScheme.fromSwatch().copyWith(
    secondary: const Color(0xFFFFC857),
    error: const Color(0xFFE63946),
  ),
);

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: const Color(0xFF88B04B),
  scaffoldBackgroundColor: const Color(0xFF1C1C1E),
  cardColor: const Color(0xFF2C2C2E),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Color(0xFFEAEAEA)),
    bodyMedium: TextStyle(color: Color(0xFFA1A1A6)),
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Color(0xFFE0B94B),
  ),
  colorScheme: ColorScheme.dark().copyWith(
    secondary: const Color(0xFFE0B94B),
    error: const Color(0xFFFF6B6B),
  ),
);

final ThemeData colorfulTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: Color(0xFF5F0A87), // Deep purple
  scaffoldBackgroundColor: Color(0xFFFFFBF5), // Warm background
  cardColor: Color(0xFFFFD6E8), // Light pink cards
  appBarTheme: AppBarTheme(
    backgroundColor: Color(0xFFFB6F92), // Flamingo
    foregroundColor: Colors.white,
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: Color.fromARGB(255, 65, 163, 16), // Mint green
    foregroundColor: const Color.fromARGB(255, 233, 234, 230),
  ),
  colorScheme: ColorScheme.fromSwatch().copyWith(
    primary: Color(0xFF5F0A87), // Purple
    secondary: Color(0xFFF9C80E), // Bright yellow
    error: Color(0xFFFF3C38), // Coral red
  ),
  textTheme: TextTheme(
      bodyLarge: TextStyle(
        color: Color(0xFF2F2F2F),
        fontWeight: FontWeight.bold,
      ),
      bodyMedium: TextStyle(
        color: Color(0xFF505050),
      ),
      titleLarge: TextStyle(
        color: Color(0xFF3A0CA3),
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
      labelSmall:
          TextStyle(color: const Color.fromARGB(255, 41, 23, 76), fontSize: 15),
      labelMedium: TextStyle(
          color: const Color.fromARGB(255, 41, 23, 76), fontSize: 20)),
  inputDecorationTheme: InputDecorationTheme(
    labelStyle: TextStyle(color: Color(0xFF5F0A87)),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xFF5F0A87), width: 2),
      borderRadius: BorderRadius.circular(12),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xFFF9C80E), width: 2.5),
      borderRadius: BorderRadius.circular(12),
    ),
  ),
  switchTheme:
      SwitchThemeData(trackColor: WidgetStateColor.resolveWith((states) {
    if (states.contains(WidgetState.selected)) {
      return const Color.fromARGB(255, 31, 5, 98);
    }
    return const Color.fromARGB(255, 207, 188, 130);
  })),
);
