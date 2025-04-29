import 'package:flutter/material.dart';

import '/constants.dart';
import './provider/weather_provider.dart';
import 'enums.dart';

class ErrorBoxWidget extends StatelessWidget {
  const ErrorBoxWidget({super.key, required this.weather});

  final WeatherProvider? weather;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 130,
        width: 200,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.error,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // show error icon
            Icon(
              weather!.appError!.type == ErrorType.network
                  ? Icons.wifi_off
                  : Icons.error_outline,
              color: Theme.of(context).colorScheme.onError,
              size: 40,
            ),
            // show error message
            Text(
              weather!.appError!.message ?? 'Unknown Error',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onError,
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                await weather!.retry(context);
              },
              child: Text(
                Constants.errorBtnTitle,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onError,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}