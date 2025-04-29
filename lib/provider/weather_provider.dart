import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';

import './location_provider.dart';
import '../enums.dart';
import '/app_error_model.dart';
import '/rest_api_services.dart';
import '/weather_model.dart';

class WeatherProvider with ChangeNotifier, WidgetsBindingObserver {
  Position? _position;

  WeatherModel? weather;

  RequestStatus _requestStatus = RequestStatus.idle;
  RequestStatus get requestStatus => _requestStatus;

  AppError? _appError;
  AppError? get appError => _appError;

  late LocationProvider _locationProvider;

  WeatherProvider() {
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }


  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      refreshLocationAndWeather();
    }
  }

  Future<void> initLocationData([BuildContext? context]) async {
    _locationProvider = LocationProvider();
    await _locationProvider.fetchLocation();
    _position = _locationProvider.position;
    notifyListeners();
  }


  Future<void> weatherDataStatus(BuildContext context) async {
    _requestStatus = RequestStatus.loading;
    _appError = null;
    notifyListeners();

    try {
      await initLocationData(context);

      if (_position == null) {
        _requestStatus = RequestStatus.error;
        _appError = _locationProvider.appError ?? AppError(
          type: ErrorType.location,
          message: 'Location data is not available.',
        );
        notifyListeners();
        return;
      }

      Response response = await RestApiServices.getWeatherForCurrentCity(
        _position!.latitude,
        _position!.longitude,
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> json = jsonDecode(response.body);
        weather = WeatherModel.fromJson(json);
        _requestStatus = RequestStatus.success;
      } else {
        _requestStatus = RequestStatus.error;
        _appError = AppError(
          type: ErrorType.server,
          message: 'Server Error\nStatus Code: ${response.statusCode}',
        );
      }
    } catch (e) {
      _requestStatus = RequestStatus.error;
      _appError = AppError(
        type: ErrorType.network,
        message: 'Network Error:\n$e',
      );
    }

    notifyListeners();
  }


  Future<void> refreshLocationAndWeather() async {
    try {
      await initLocationData(null);
      if (_position != null) {
        await fetchWeather();
      }
    } catch (e) {
      _requestStatus = RequestStatus.error;
      _appError = AppError(
        type: ErrorType.network,
        message: 'Error while refreshing data: $e',
      );
      notifyListeners();
    }
  }

  Future<void> fetchWeather() async {
    if (_position == null) return;

    try {
      Response response = await RestApiServices.getWeatherForCurrentCity(
        _position!.latitude,
        _position!.longitude,
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> json = jsonDecode(response.body);
        weather = WeatherModel.fromJson(json);
        _requestStatus = RequestStatus.success;
      } else {
        _requestStatus = RequestStatus.error;
        _appError = AppError(
          type: ErrorType.server,
          message: 'Server Error\nStatus Code: ${response.statusCode}',
        );
      }
    } catch (e) {
      _requestStatus = RequestStatus.error;
      _appError = AppError(
        type: ErrorType.network,
        message: 'Error fetching weather: $e',
      );
    }
    notifyListeners();
  }

  // دکمه Retry رو به این وصل کن
  Future<void> retry(BuildContext context) async {
    await weatherDataStatus(context);
  }
}
