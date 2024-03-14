import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class WordpressNewsView extends StatefulWidget {
  final String wordpressUrl;

  const WordpressNewsView({super.key, required this.wordpressUrl});

  @override
  _WordpressNewsViewState createState() => _WordpressNewsViewState();
}

class _WordpressNewsViewState extends State<WordpressNewsView> {
  late String siteName = '';
  late List<dynamic> newsList = [];

  @override
  void initState() {
    super.initState();
    fetchSiteInfo();
    fetchLatestNews();
  }

  void fetchSiteInfo() async {
    final response =
        await http.get(Uri.parse('${widget.wordpressUrl}/wp-json'));
    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      setState(() {
        siteName = data['name'];
      });
    }
  }

  void fetchLatestNews() async {
    final response = await http.get(
        Uri.parse('${widget.wordpressUrl}/wp-json/wp/v2/posts?per_page=3'));
    if (response.statusCode == 200) {
      setState(() {
        newsList = json.decode(response.body);
      });
    }
  }

  String stripHtmlTags(String htmlText) {
    RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);
    return htmlText.replaceAll(exp, '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('La página de 007'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Text(
              'Los últimos artículos de ${siteName.isNotEmpty ? siteName : 'Cargando...'}',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: newsList.length,
              itemBuilder: (BuildContext context, int index) {
                String title =
                    stripHtmlTags(newsList[index]['title']['rendered']);
                String excerpt =
                    stripHtmlTags(newsList[index]['excerpt']['rendered']);
                return ListTile(
                  title: Text(title),
                  subtitle: Text(excerpt),
                  onTap: () {
                    String newsUrl = newsList[index]['link'];
                    launch(newsUrl);
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
