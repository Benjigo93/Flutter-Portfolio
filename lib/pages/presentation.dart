import 'package:flutter/material.dart';
import '../components/menu_nav.dart';

// Presentation Page
class PresentationPage extends StatelessWidget {
  const PresentationPage({Key? key, required this.title}) : super(key: key);
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
              margin: const EdgeInsets.only(top: 20.0, bottom: 20.0),
              child: CircleAvatar(
                radius: 70,
                backgroundColor: Colors.red,
                child: Padding(
                  padding: const EdgeInsets.all(8), // Border radius
                  child: ClipOval(child: Image.asset(
                    'assets/images/ironman.jpg',
                    width: 300,
                    height: 150,
                    fit: BoxFit.cover,
                  )
                  ),
                ),
              ),
            ),
            const Center(
              child: Text(
                  'Benjamin KICHENAMOURTY',
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
                    '26 ans | Aulnay Sous Bois',
                    style: TextStyle(
                      fontSize: 20.0,
                    )
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 15.0),
              child: const Center(
                child: Text(
                    'Developer fullstack',
                    style: TextStyle(
                      fontSize: 20.0,
                    )
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}