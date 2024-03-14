import 'package:flutter/material.dart';
import 'gender_prediction_view.dart';
import 'age_prediction_view.dart';
import 'universities_list_view.dart';
import 'wordpress_news_view.dart';
import 'weather_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Práctica con API',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  static final List<Widget> _widgetOptions = <Widget>[
    Image.asset(
      'assets/toolbox_image.jpg',
      width: 500,
      height: 500,
    ),
    const GenderPredictionView(),
    const AgePredictionView(),
    const UniversitiesListView(),
    const WordpressNewsView(
      wordpressUrl: 'https://www.007.com/',
    ),
    const WeatherView(),
    const AboutView(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Práctica con API'),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.build),
            label: 'Herramientas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.face),
            label: 'Género',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Edad',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'Universidades',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.article),
            label: '007',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.wb_sunny),
            label: 'Clima',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: 'Acerca de',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.black,
        onTap: _onItemTapped,
      ),
    );
  }
}

class AboutView extends StatelessWidget {
  const AboutView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Acerca de'),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundImage: AssetImage('assets/icon/icon.jpeg'),
              radius: 50,
            ),
            SizedBox(height: 20),
            Text(
              'Información de contacto:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Nombre: Edwin Paredes',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              'Email: edwinphg@gmail.com.com',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              'Teléfono: +829-308-8166',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
