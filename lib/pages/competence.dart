import 'package:flutter/material.dart';
import '../components/menu_nav.dart';

// Competence Page
class CompetencePage extends StatelessWidget {
  const CompetencePage({Key? key, required this.title}) : super(key: key);
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
        padding: const EdgeInsets.only(top: 20.0, bottom: 50.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children:  <Widget>[
            Container(
              margin: const EdgeInsets.only(top: 25.0),
              child: const Center(
                child: Text(
                    'Langages :',
                    style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.w500,
                      color: Color.fromRGBO(21, 96, 189, 1.0),
                    )
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 15.0),
              child: const Center(
                child: Text(
                    'PHP - JS - NodeJs',
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
                    'Python - Bash - Ruby',
                    style: TextStyle(
                      fontSize: 20.0,
                    )
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 50.0),
              child: const Center(
                child: Text(
                    'Frameworks :',
                    style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.w500,
                      color: Color.fromRGBO(21, 96, 189, 1.0),
                    )
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 15.0),
              child: const Center(
                child: Text(
                    'VueJs - NuxtJs - React',
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
                    'Symfony - Django - Ruby on Rails',
                    style: TextStyle(
                      fontSize: 20.0,
                    )
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 50.0),
              child: const Center(
                child: Text(
                    'Connaisances :',
                    style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.w500,
                      color: Color.fromRGBO(21, 96, 189, 1.0),
                    )
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 15.0),
              child: const Center(
                child: Text(
                    'Création et Interfaçage d\'API',
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
                    'Mise en place de back-end et front-end',
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