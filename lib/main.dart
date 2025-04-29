import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app_theme.dart';
import '/city_weather_status_screen.dart';
import '/provider/location_provider.dart';
import '/provider/theme_provider.dart';
import '/provider/weather_provider.dart';

void main() => runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => WeatherProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => ThemeProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => LocationProvider(),
          )
        ],
        child: const MyApp(),
      ),
    );

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Selector<ThemeProvider, ThemeMode>(
      selector: (context, themeStatus) => themeStatus.themeMode,
      builder: (context, themeStatus, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme(),
          darkTheme: AppTheme.darkTheme(),
          themeMode: themeStatus,
          home: const CityWeatherStatusScreen(),
        );
      },
    );
  }
}
