import 'package:flutter/material.dart';

import '/weather_model.dart';

class WeatherDetailsPortrait extends StatefulWidget {
  const WeatherDetailsPortrait({
    super.key,
    required this.weather,
  });

  final WeatherModel? weather;

  @override
  State<WeatherDetailsPortrait> createState() => _WeatherDetailsPortraitState();
}

class _WeatherDetailsPortraitState extends State<WeatherDetailsPortrait> {
  DateTime convertTimeStampsToHumanDateTime(WeatherModel weather) {
    final DateTime localDateTime = DateTime.fromMillisecondsSinceEpoch(
      weather.list[0].timeStamps! * 1000,
    );
    return localDateTime;
  }

  DateTime? dateTime;

  @override
  void initState() {
    dateTime = convertTimeStampsToHumanDateTime(widget.weather!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      children: [
        Text(
          'Date: ${dateTime!.year}/${dateTime!.month}/${dateTime!.day}',
          textAlign: TextAlign.left,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 15,
            color: Colors.white,
            letterSpacing: 0.6,
          ),
        ),

        const SizedBox(height: 10),

        // Display City Name, Temperature and Icon Status, Humidity,
        // Wind Speed and Condition
        Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: RadialGradient(
              colors: [
                Theme.of(context).colorScheme.primary.withOpacity(0.1),
                Theme.of(context).colorScheme.onPrimaryContainer,
              ],
              radius: 1,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // City Name
              Text(
                widget.weather!.cityName!,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: Colors.white,
                  letterSpacing: 0.6,
                ),
              ),

              const SizedBox(height: 15),

              // Temperature and Icon Status
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/${widget.weather!.list[0].icon}@2x.png',
                    height: 80,
                  ),

                  const SizedBox(width: 15),

                  // Temperature Status
                  Text(
                    '${widget.weather!.list[0].temp!.day!.toStringAsFixed(2)} °C',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: Colors.white,
                      letterSpacing: 0.6,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 15),

              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(children: [
                  TextSpan(
                    text: 'Humidity: ${widget.weather!.list[0].humidity} %\n',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                  const WidgetSpan(child: SizedBox(height: 25)),
                  TextSpan(
                    text: 'Wind Speed: ${widget.weather!.list[0].speed} km/h\n',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                  const WidgetSpan(child: SizedBox(height: 25)),
                  TextSpan(
                    text: 'Condition: ${widget.weather!.list[0].weather}\n',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ]),
              ),
            ],
          ),
        ),

        const SizedBox(height: 30),

        // for more details about weather such as forecasts
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: LinearGradient(
              colors: [
                Theme.of(context).colorScheme.onPrimaryContainer.withOpacity(0.4),
                Theme.of(context).colorScheme.primary,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: widget.weather!.list.length,
            itemBuilder: (context, index) {
              final weather = widget.weather!.list[index];
              final DateTime localDateTime =
              DateTime.fromMillisecondsSinceEpoch(
                weather.timeStamps! * 1000,
              );
              return ListTile(
                leading: Image.asset(
                  'assets/images/${weather.icon}@2x.png',
                  height: 80,
                ),
                title: Text(
                  localDateTime.day.toString(),
                  style: const TextStyle(color: Colors.white),
                ),
                subtitle: Text(
                  'Min: ${weather.temp!.min!.toStringAsFixed(0)} °C  Max: ${weather.temp!.max!.toStringAsFixed(0)} °C',
                  style: const TextStyle(color: Colors.white),
                ),
                trailing: Text(
                  weather.weather!,
                  style: const TextStyle(color: Colors.white),
                ),
              );
            },
            separatorBuilder: (context, index) {
              return const Divider(
                color: Colors.white,
                indent: 10,
                endIndent: 10,
              );
            },
          ),
        ),
      ],
    );
  }
}