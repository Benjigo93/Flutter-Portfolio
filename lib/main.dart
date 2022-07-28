import 'package:flutter/material.dart';
import 'package:tp1_bk/pages/faq.dart';
import 'package:tp1_bk/pages/presentation.dart';
import 'package:tp1_bk/pages/competence.dart';
import 'package:tp1_bk/pages/parcours.dart';
import 'package:tp1_bk/pages/entreprise.dart';
import 'package:tp1_bk/pages/contact.dart';
import 'package:tp1_bk/pages/pokedex.dart';
import 'package:tp1_bk/pages/meteo.dart';
import 'package:tp1_bk/pages/scanner.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  static const String appTitle  = 'Benjamin Kichenamourty CV';

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appTitle,
      theme: ThemeData(
        fontFamily: 'Roboto',
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const PresentationPage(title: 'Présentation | BK'),
        '/competence': (context) => const CompetencePage(title: 'Compétences | BK'),
        '/parcours': (context) => const ParcoursPage(title: 'Parcours | BK'),
        '/entreprise': (context) => const EntreprisePage(title: 'Entreprise | BK'),
        '/contact': (context) => const ContactPage(title: 'Contact | BK'),
        '/faq': (context) => const FaqPage(title: 'Faq | BK'),
        '/pokedex': (context) => const PokedexPage(title: 'Pokedex'),
        '/meteo': (context) => const MeteoPage(title: 'Météo'),
        '/scanner': (context) => const ScannerPage(title: 'Scanner'),
      },
    );
  }
}