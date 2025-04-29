import 'package:http/http.dart';

class RestApiServices {
  static const String _apiKey = 'c3cd2c22ff2ad3f12fe43be8b1467437';
  static const String _baseUrl = 'https://api.openweathermap.org/data/2.5/forecast/daily?';

  // use GPS (location service) to get data with latitude and longitude
  static Future<Response> getWeatherForCurrentCity(double latitude, double longitude) async {
    final Uri uri = Uri.parse('${_baseUrl}lat=$latitude&lon=$longitude&appid=$_apiKey');
    final Response response = await get(uri);
    return response;
  }
}