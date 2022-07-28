import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../components/menu_nav.dart';

final Uri _url = Uri.parse('https://wiz.fr/');

// Entreprise Page
class EntreprisePage extends StatelessWidget {
  const EntreprisePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.blueAccent,
      ),
      drawer: const MenuNavigation(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 50.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children:  <Widget>[
            Container(
              margin: const EdgeInsets.only(top: 50.0, bottom: 20.0),
              color: Colors.black,
              child: Padding(
                padding: const EdgeInsets.all(4), // Border radius
                  child: Image.asset(
                    'assets/images/wizz.png',
                    width: 150,
                    height: 150,
                    fit: BoxFit.cover,
                  )
              ),
            ),
            const Center(
              child: Text(
                  'Wizzmedia',
                  style: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.w500,
                  )
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 15.0),
              child: const Center(
                child: Text(
                    'Agence Web',
                    style: TextStyle(
                      fontSize: 20.0,
                    )
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20.0),
              child: const Center(
                child: ElevatedButton(
                  onPressed: _launchWizzUrl,
                  child: Text('Site Internet'),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

Future<void> _launchWizzUrl() async {
  if (!await launchUrl(_url)) {
    throw 'Could not launch $_url';
  }
}