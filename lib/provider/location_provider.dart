import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';

import '/app_error_model.dart';
import '/enums.dart';

class LocationProvider with ChangeNotifier {
  Position? _position;

  Position? get position => _position;

  RequestStatus _requestStatus = RequestStatus.idle;

  RequestStatus get requestStatus => _requestStatus;

  AppError? _appError;

  AppError? get appError => _appError;

  Future<void> fetchLocation() async {
    bool serviceEnabled;
    int permissionRequestAttempts = 0;

    _requestStatus = RequestStatus.loading;
    notifyListeners();

    while (permissionRequestAttempts < 3) {
      LocationPermission permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        permissionRequestAttempts++;

        if (permission == LocationPermission.denied) {
          _requestStatus = RequestStatus.error;
          _appError = AppError(
            type: ErrorType.permission,
            message: 'Location permissions are denied.',
          );
          notifyListeners();
          continue;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        _requestStatus = RequestStatus.error;
        _appError = AppError(
          type: ErrorType.permission,
          message: 'Location permissions are permanently denied, we cannot request permissions.',
        );
        await Geolocator.openAppSettings();
        return;
      }
      if (permission == LocationPermission.always ||
          permission == LocationPermission.whileInUse) {
        break;
      }
      notifyListeners();
    }

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      bool opened = await Geolocator.openLocationSettings();
      if (!opened) {
        _requestStatus = RequestStatus.error;
        _appError = AppError(
          type: ErrorType.location,
          message: 'Location services are disabled.',
        );
        return;
      }

      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        _requestStatus = RequestStatus.error;
        _appError = AppError(
          type: ErrorType.location,
          message: 'User did not enable location.',
        );
        return;
      }
      notifyListeners();
    }

    try {
      _position = await Geolocator.getCurrentPosition();
      _requestStatus = RequestStatus.success;
    } catch (e) {
      _requestStatus = RequestStatus.error;
      _appError = AppError(
        type: ErrorType.location,
        message: 'Error fetching location: $e',
      );
    }
    notifyListeners();
  }
}
