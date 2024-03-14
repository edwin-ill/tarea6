import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class WeatherView extends StatefulWidget {
  const WeatherView({super.key});

  @override
  _WeatherViewState createState() => _WeatherViewState();
}

class _WeatherViewState extends State<WeatherView> {
  late String cityName;
  late String weatherDescription;
  late double temperature;
  late String iconUrl;

  @override
  void initState() {
    super.initState();
    fetchWeather();
  }

  void fetchWeather() async {
    final response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=Santo%20Domingo,DO&appid=5b084c321b505516ca9f123f46d5e8bf&units=metric'));

    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      setState(() {
        cityName = data['name'];
        weatherDescription = data['weather'][0]['description'];
        temperature = data['main']['temp'];
        String iconCode = data['weather'][0]['icon'];
        iconUrl = 'http://openweathermap.org/img/wn/$iconCode.png';
      });
    } else {
      setState(() {
        cityName = 'Error';
        weatherDescription =
            'No se ha podido conseguir la información acerca del clima';
        temperature = 0.0;
        iconUrl = '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('El clima en Santo Domingo, Repúblic Dominicana'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              cityName ?? 'Cargando...',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              weatherDescription ?? 'Cargando...',
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 10),
            temperature != null
                ? Text(
                    '${temperature.toStringAsFixed(1)} °C',
                    style: const TextStyle(fontSize: 20),
                  )
                : const CircularProgressIndicator(),
            const SizedBox(height: 10),
            iconUrl != null
                ? Image.network(
                    iconUrl,
                    width: 50,
                    height: 50,
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
