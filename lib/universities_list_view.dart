import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UniversitiesListView extends StatefulWidget {
  const UniversitiesListView({super.key});

  @override
  _UniversitiesListViewState createState() => _UniversitiesListViewState();
}

class _UniversitiesListViewState extends State<UniversitiesListView> {
  final TextEditingController countryController = TextEditingController();
  List<dynamic> universities = [];

  void fetchUniversities(String country) async {
    final response = await http.get(
        Uri.parse('http://universities.hipolabs.com/search?country=$country'));
    if (response.statusCode == 200) {
      setState(() {
        universities = json.decode(response.body);
      });
    } else {
      setState(() {
        universities = [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de universidades'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: countryController,
              decoration: const InputDecoration(
                labelText: 'Introduzca un país (En inglés)',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                String country = countryController.text;
                fetchUniversities(country);
              },
              child: const Text('Buscar'),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: universities.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(universities[index]['name']),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Domain: ${universities[index]['domains'][0]}'),
                        Text('Website: ${universities[index]['web_pages'][0]}'),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
