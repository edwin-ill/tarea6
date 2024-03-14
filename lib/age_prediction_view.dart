import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AgePredictionView extends StatefulWidget {
  const AgePredictionView({super.key});

  @override
  _AgePredictionViewState createState() => _AgePredictionViewState();
}

class _AgePredictionViewState extends State<AgePredictionView> {
  final TextEditingController nameController = TextEditingController();
  String ageGroup = '';
  int age = 0;
  String imageUrl = '';

  void predictAge(String name) async {
    final response =
        await http.get(Uri.parse('https://api.agify.io/?name=$name'));
    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      setState(() {
        age = data['age'];
        if (age < 30) {
          ageGroup = 'Joven';
          imageUrl = 'assets/young.png';
        } else if (age < 60) {
          ageGroup = 'Adulto';
          imageUrl = 'assets/adult.png';
        } else {
          ageGroup = 'Viejo';
          imageUrl = 'assets/elderly.png';
        }
      });
    } else {
      setState(() {
        ageGroup = 'Error';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Predicción de edad'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Introduzca un nombre',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                String name = nameController.text;
                predictAge(name);
              },
              child: const Text('Predecir edad'),
            ),
            const SizedBox(height: 20),
            Text(
              'Edad predicta: $age',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Grupo de edad: $ageGroup',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            ageGroup.isNotEmpty
                ? Image.asset(
                    imageUrl,
                    height: 100,
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
