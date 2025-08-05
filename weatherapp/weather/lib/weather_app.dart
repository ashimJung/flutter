import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherService {
  final String apiKey = '254fae3e1fb4d21c0d11ab8932e06d81';
  final String baseUrl = 'https://api.openweathermap.org/data/2.5/weather';

  Future<Map<String, dynamic>> getWeather(String city) async {
    final url = Uri.parse('$baseUrl?q=$city&appid=$apiKey&units=metric');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('City not found');
    }
  }
}
