import 'package:flutter/material.dart';
import 'weather_app.dart';

void main() {
  runApp(const WeatherApp());
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const WeatherHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class WeatherHomePage extends StatefulWidget {
  const WeatherHomePage({super.key});

  @override
  State<WeatherHomePage> createState() => _WeatherHomePageState();
}

class _WeatherHomePageState extends State<WeatherHomePage> {
  final _cityController = TextEditingController();
  final _weatherService = WeatherService();
  String? _temperature;
  String? _description;
  String? _error;

  Future<void> _getWeather() async {
    setState(() {
      _error = null;
      _temperature = null;
      _description = null;
    });

    try {
      final data = await _weatherService.getWeather(_cityController.text.trim());
      setState(() {
        _temperature = '${data['main']['temp']}°C';
        _description = data['weather'][0]['description'];
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Simple Weather App')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _cityController,
              decoration: const InputDecoration(
                labelText: 'Enter city name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _getWeather,
              child: const Text('Get Weather'),
            ),
            const SizedBox(height: 20),
            if (_temperature != null && _description != null) ...[
              Text('Temperature: $_temperature', style: const TextStyle(fontSize: 20)),
              Text('Description: $_description', style: const TextStyle(fontSize: 18)),
            ] else if (_error != null) ...[
              Text(_error!, style: const TextStyle(color: Colors.red)),
            ]
          ],
        ),
      ),
    );
  }
}
