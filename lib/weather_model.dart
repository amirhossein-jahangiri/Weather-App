class WeatherModel {
  WeatherModel({
    required this.cityName,
    required this.list,
  });

  final String? cityName;
  final List<ListElement> list;

  factory WeatherModel.fromJson(Map<String, dynamic> json){
    return WeatherModel(
      cityName: json["city"]["name"],
      list: json["list"] == null ? [] : List<ListElement>.from(json["list"]!.map((x) => ListElement.fromJson(x))),
    );
  }
}



class ListElement {
  ListElement({
    required this.timeStamps,
    required this.temp,
    required this.humidity,
    required this.weather,
    required this.icon,
    required this.speed,
  });

  final int? timeStamps;
  final Temp? temp;
  final int? humidity;
  final String? weather;
  final String? icon;
  final double? speed;

  factory ListElement.fromJson(Map<String, dynamic> json){
    return ListElement(
      timeStamps: json["dt"],
      temp: json["temp"] == null ? null : Temp.fromJson(json["temp"]),
      humidity: json["humidity"],
      weather: json["weather"][0]["main"],
      icon: json["weather"][0]["icon"],
      speed: json["speed"],
    );
  }
}


class Temp {
  Temp({
    required this.day,
    required this.min,
    required this.max,
  });

  final double? day;
  final double? min;
  final double? max;

  factory Temp.fromJson(Map<String, dynamic> json){
    return Temp(
      day: (json['day'] - 273.15), // Kelvin to Celsius,
      min: (json['min'] - 273.15), // Kelvin to Celsius,
      max: (json['max'] - 273.15), // Kelvin to Celsius,
    );
  }
}