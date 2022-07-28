import 'package:flutter/material.dart';
import '../components/menu_nav.dart';

// Parcours Page
class ParcoursPage extends StatelessWidget {
  const ParcoursPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.blueAccent,
      ),
      drawer: const MenuNavigation(),
      body: SingleChildScrollView (
        padding: const EdgeInsets.only(bottom: 50.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children:  <Widget>[
            Container(
              margin: const EdgeInsets.only(top: 25.0),
              child: const Center(
                child: Text(
                    '2021',
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
                    'IPSSI - Master Web Big Data',
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
                    '2019',
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
                    'EEMI - Bachelor Chef de Projet Digital',
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
                    '2016',
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
                    'HETIC - Grande École',
                    style: TextStyle(
                      fontSize: 20.0,
                    )
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}