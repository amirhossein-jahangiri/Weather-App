import 'package:flutter/material.dart';

class AppTheme {
  static const TextTheme _textThemeLight = TextTheme(
    displayLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.black),
    titleLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: Colors.black87),
    bodyLarge: TextStyle(fontSize: 16, color: Colors.black87),
    bodyMedium: TextStyle(fontSize: 14, color: Colors.white),
  );

  static const TextTheme _textThemeDark = TextTheme(
    displayLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
    titleLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: Colors.white70),
    bodyLarge: TextStyle(fontSize: 16, color: Colors.white),
    bodyMedium: TextStyle(fontSize: 14, color: Colors.tealAccent),
  );

  static const lightColorScheme = ColorScheme.light(
    primary: Color(0xFF6750A4),           // بنفش اصلی
    onPrimary: Colors.white,              // متن روی primary
    primaryContainer: Color(0xFFEADDFF),  // پس‌زمینه ملایم بنفش
    onPrimaryContainer: Color(0xFF21005D),
    error: Color(0xFFB3261E),
    onError: Colors.white,
  );


  static ThemeData lightTheme() {
    return ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: lightColorScheme.primary,
      primaryColor: Colors.purple[600],
      appBarTheme: AppBarTheme(
        backgroundColor: lightColorScheme.primary,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: Colors.teal[300],
        foregroundColor: Colors.white,
      ),
      textTheme: _textThemeLight,
      colorScheme: lightColorScheme,
      iconTheme: IconThemeData(
        color: lightColorScheme.onPrimary,
      ),
    );
  }

  static const darkColorScheme = ColorScheme.dark(
    primary: Color(0xFF00BFA5),           // Teal روشن – برند اصلی
    onPrimary: Colors.black,              // متن روی primary
    primaryContainer: Color(0xFF004D40),  // Teal تیره – بک‌گراند اجزا
    onPrimaryContainer: Colors.white,
    error: Color(0xFFCF6679),
    onError: Colors.black,
    surface: Colors.black,
  );


  static ThemeData darkTheme() {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: darkColorScheme.primaryContainer,
      appBarTheme: AppBarTheme(
        backgroundColor: darkColorScheme.primaryContainer,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: Colors.tealAccent[200],
        foregroundColor: Colors.black,
      ),
      textTheme: _textThemeDark,
      colorScheme: darkColorScheme,
      iconTheme: IconThemeData(
        color: lightColorScheme.primary,
      ),
    );
  }
}
