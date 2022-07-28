import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:tp1_bk/models/pokemon.dart';
import '../components/menu_nav.dart';
import '../components/pokemon_card.dart';

const String baseUrl  = 'https://pokeapi.co/api/v2/pokemon/';

// Pokedex Page
class PokedexPage extends StatefulWidget {
  const PokedexPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  PokedexState createState() {
    return PokedexState();
  }
}

class PokedexState extends State<PokedexPage> {
  late Future <List<Pokemon>> pokemons;
  late int page = 0;
  late String pokedexFormName = '';
  late Pokemon? resultPokemon;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    pokemons = fetchPokemons(page);
    page = 0;
    pokedexFormName = '';
    resultPokemon = null;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            title: Text(widget.title),
            backgroundColor: Colors.blueAccent,
            bottom: const TabBar(
              tabs: [
                Tab(icon: Icon(Icons.catching_pokemon)),
                Tab(icon: Icon(Icons.search)),
              ],
            ),
          ),
          drawer: const MenuNavigation(),
          body: TabBarView(
              children: [
                SingleChildScrollView(
                  padding: const EdgeInsets.only(bottom: 50.0, top: 40.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children:  <Widget>[
                      FutureBuilder<List<Pokemon>>(
                        future: pokemons,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            List<Pokemon>? pokemonList = snapshot.data;
                            return GridView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: MediaQuery.of(context).size.width /
                                    (MediaQuery.of(context).size.height / 1.2),
                                crossAxisSpacing: 20,
                                mainAxisSpacing: 50,
                              ),
                              itemCount: pokemonList?.length,
                              itemBuilder: (context, index) {
                                return Center(
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(horizontal: 10.0),
                                    child: PokemonCard(pokemon: pokemonList![index], theme: 'listing'),
                                  ),
                                );
                              },
                            );
                          } else if (snapshot.hasError) {
                            return Text("${snapshot.error}");
                          }
                          // By default, show a loading spinner.
                          return const CircularProgressIndicator();
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.all(50.0),
                        child: Center(
                          child: ElevatedButton(
                            onPressed: () async{
                              List<Pokemon> oldPokemons = await pokemons;
                              var newPage = page + 1;
                              setState(() {
                                page = newPage;
                                pokemons = fetchPokemons(newPage, oldList: oldPokemons);
                              });
                            },
                            style: ButtonStyle(
                              padding: MaterialStateProperty.all(const EdgeInsets.all(30)),
                            ),
                            child: const Text('Voir Plus'),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SingleChildScrollView(
                  padding: const EdgeInsets.only(bottom: 50.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children:  <Widget>[
                      Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children:  <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(top: 30.0, bottom: 15.0, left: 20.0, right: 20.0),
                              child:  TextFormField(
                                decoration: const InputDecoration(
                                  hintText: 'Nom du Pokemon',
                                  labelText: 'Nom *',
                                  contentPadding: EdgeInsets.symmetric(vertical:30, horizontal: 10),
                                  border: OutlineInputBorder(),
                                ),
                                // The validator receives the text that the user has entered.
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Veuillez entrer un nom !';
                                  } else {
                                    pokedexFormName = value;
                                    return null;
                                  }
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Center(
                                child: ElevatedButton(
                                  onPressed: () async{
                                    // Validate returns true if the form is valid, or false otherwise.
                                    if (_formKey.currentState!.validate()) {
                                      FocusScope.of(context).requestFocus(FocusNode());
                                      var pokemonData = await searchPokemonByName(pokedexFormName);
                                      setState(() {
                                        resultPokemon = pokemonData;
                                      });
                                    }
                                  },
                                  style: ButtonStyle(
                                    padding: MaterialStateProperty.all(const EdgeInsets.all(30)),
                                  ),
                                  child: const Text('Rechercher'),
                                ),
                              ),
                            ),
                            (resultPokemon != null && pokedexFormName.isNotEmpty)?
                            Center(
                              child: PokemonCard(pokemon: resultPokemon!, theme: 'search'),
                            ):
                            (pokedexFormName.isNotEmpty)?
                            Center(
                              child: Container(
                                margin: const EdgeInsets.only(top: 50.0),
                                child: Text(
                                  'Aucun résultat trouvé pour $pokedexFormName...',
                                  style: const TextStyle(
                                    fontSize: 25.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            )
                                :Container(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ]
          )
      ),
    );
  }
}

Future<List<Pokemon>> fetchPokemons(int page, {List<Pokemon> oldList = const []}) async {

  final response = await http.get(Uri.parse('$baseUrl?offset=${page*20}&limit=20'));

  if (response.statusCode == 200) {
    final jsonResponse = jsonDecode(response.body);
    List pokemons = jsonResponse['results'];
    if (oldList.isEmpty) {
      return pokemons.map((pokemon) => Pokemon.fromJson(pokemon)).toList();
    } else {
      return [...oldList, ...pokemons.map((pokemon) => Pokemon.fromJson(pokemon)).toList()];
    }
  } else {
    throw Exception('Failed to load pokemon');
  }
}

Future<Pokemon?> searchPokemonByName(String name) async {

  final response = await http.get(Uri.parse('$baseUrl${name.toLowerCase()}'));

  if (response.statusCode == 200) {
    final jsonResponse = jsonDecode(response.body);
    return Pokemon.fromJson(jsonResponse);
  } else {
    return null;
  }
}

