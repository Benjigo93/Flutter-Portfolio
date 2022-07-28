import 'package:flutter/material.dart';
import 'package:tp1_bk/models/pokemon.dart';
import '../extensions/string.dart';

// Pokemon Card
class PokemonCard extends Container{
  PokemonCard({Key? key, required this.pokemon, required this.theme}) : super(key: key);
  final Pokemon pokemon;
  final String theme;

  @override
  Container build(BuildContext context) {
    return Container(
      margin: theme == 'search' ? const EdgeInsets.only(top: 30.0) : null,
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color.fromRGBO(115, 194, 251, 1),
          width: 5,
        ),
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(115, 194, 251, 0.5),
            offset: Offset(
              5.0,
              5.0,
            ),
            blurRadius: 10.0,
            spreadRadius: 5.0,
          ), //BoxShadow
          BoxShadow(
            color: Colors.white,
            offset: Offset(0.0, 0.0),
            blurRadius: 0.0,
            spreadRadius: 0.0,
          ),
        ],
      ),
      child: Column(
        children: [
          Image.network(
            pokemon.image,
            width: 200,
            height: 200,
            fit: BoxFit.contain,
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 30.0),
            child: Text(
              pokemon.name.toTitleCase(),
              style: const TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.w700,
                color: Color.fromRGBO(21, 67, 96, 1.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}