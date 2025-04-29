import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import '/constants.dart';
import '/enums.dart';
import '/weather_details_screen_landscape_layout.dart';
import '/weather_details_screen_portrait_layout.dart';
import 'error_box_widget.dart';
import '/provider/theme_provider.dart';
import '/provider/weather_provider.dart';

class CityWeatherStatusScreen extends StatefulWidget {
  const CityWeatherStatusScreen({super.key});

  @override
  State<CityWeatherStatusScreen> createState() =>
      _CityWeatherStatusScreenState();
}

class _CityWeatherStatusScreenState extends State<CityWeatherStatusScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        context.read<WeatherProvider>().weatherDataStatus(context);
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          Constants.appBarTitle,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            letterSpacing: 0.4,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              final provider = context.read<ThemeProvider>();
              bool isDarkMode = provider.isDarkMode;
              provider.toggleTheme(!isDarkMode);
            },
            icon: Selector<ThemeProvider, bool>(
              selector: (context, themeStatus) => themeStatus.isDarkMode,
              builder: (context, isDark, child) {
                return isDark
                    ? const Icon(Icons.light_mode)
                    : const Icon(Icons.dark_mode);
              },
            ),
          ),
        ],
      ),
      body: Consumer<WeatherProvider>(
        builder: (context, weather, child) {
          switch (weather.requestStatus) {
            case RequestStatus.loading:
              return const Center(
                child: CircularProgressIndicator(color: Colors.white),
              );
            case RequestStatus.error:
              return ErrorBoxWidget(weather: weather);
            case RequestStatus.success:
              return OrientationBuilder(builder: (context, orientation) {
                return orientation == Orientation.portrait
                    ? WeatherDetailsPortrait(weather: weather.weather)
                    : WeatherDetailsLandscape(weather: weather.weather);
              });
            default:
              return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}