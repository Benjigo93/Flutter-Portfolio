import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../components/menu_nav.dart';
import '../models/qa.dart';
import '../extensions/string.dart';

const String baseUrl  = 'http://localhost:8000/question';

// Faq Page
class FaqPage extends StatefulWidget {
  const FaqPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  FaqFormState createState() {
    return FaqFormState();
  }
}

class FaqFormState extends State<FaqPage> with SingleTickerProviderStateMixin {
  late Future <List<Qa>> futureQas;
  final _formKey = GlobalKey<FormState>();
  late int qaFormId = 0;
  late String qaFormTheme = '';
  late String qaFormQuestion = '';
  late String qaFormReponse = '';
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2, initialIndex: 0,);
    futureQas = fetchQuestions();
    qaFormId = 0;
    qaFormTheme = '';
    qaFormQuestion = '';
    qaFormReponse = '';
  }

  @override
  Widget build(BuildContext context) {

    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            title: Text(widget.title),
            backgroundColor: Colors.blueAccent,
            bottom: TabBar(
              controller: _tabController,
              tabs: const [
                Tab(icon: Icon(Icons.question_answer)),
                Tab(icon: Icon(Icons.post_add)),
              ],
            ),
          ),
          drawer: const MenuNavigation(),
          body: TabBarView(
              controller: _tabController,
              children: [
                SingleChildScrollView(
                  padding: const EdgeInsets.only(bottom: 50.0, top: 10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children:  <Widget>[
                      FutureBuilder<List<Qa>>(
                        future: futureQas,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            List<Qa>? qa = snapshot.data;
                            return
                              ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: qa?.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    return Container(
                                      padding: const EdgeInsets.symmetric(vertical: 30.0),
                                      margin: const EdgeInsets.symmetric(vertical: 10.0),
                                      color: Colors.blueGrey.withOpacity(0.3),
                                      child: Center(
                                        child: Column(
                                          children: [
                                            Align(
                                              alignment: const Alignment(0.8, 1.0),
                                              child: Text(
                                                qa![index].theme.toTitleCase(),
                                                style: const TextStyle(
                                                  fontSize: 15.0,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              padding: const EdgeInsets.symmetric(vertical: 10.0) ,
                                              child: Text(
                                                qa[index].question.toTitleCase(),
                                                style: const TextStyle(
                                                  fontSize: 20.0,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              padding: const EdgeInsets.symmetric(vertical: 10.0),
                                              margin: const EdgeInsets.only(bottom: 30.0),
                                              child: Text(
                                                qa[index].reponse.toTitleCase(),
                                                style: const TextStyle(
                                                  fontSize: 17.0,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                            ElevatedButton(
                                              onPressed: () {
                                                deleteQuestion(qa[index].id).then((res) => {
                                                  if (res) {
                                                    ScaffoldMessenger.of(context).showSnackBar(
                                                        const SnackBar(
                                                          content: Text(
                                                              'Question supprimé !',
                                                              style: TextStyle(
                                                                fontWeight: FontWeight.w500,
                                                                fontSize: 18.0,
                                                              )
                                                          ),
                                                          backgroundColor: Colors.lightGreen,
                                                          duration: Duration(seconds: 1),
                                                          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
                                                        )
                                                    ),
                                                    setState(() {
                                                      futureQas = fetchQuestions();
                                                    })
                                                  } else {
                                                    ScaffoldMessenger.of(context).showSnackBar(
                                                        const SnackBar(
                                                          content: Text(
                                                              'Une erreur est survenue !',
                                                              style: TextStyle(
                                                                fontWeight: FontWeight.w500,
                                                                fontSize: 18.0,
                                                              )
                                                          ),
                                                          backgroundColor: Colors.red,
                                                          duration: Duration(seconds: 2),
                                                          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
                                                        )
                                                    )
                                                  }
                                                });
                                              },
                                              style: ButtonStyle(
                                                padding: MaterialStateProperty.all(const EdgeInsets.all(20)),
                                              ),
                                              child: const Text('Supprimer'),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  }
                              );
                          } else if (snapshot.hasError) {
                            return Text("${snapshot.error}");
                          }
                          // By default, show a loading spinner.
                          return const CircularProgressIndicator();
                        },
                      )
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
                              child: TextFormField(
                                decoration: const InputDecoration(
                                  icon: Icon(Icons.numbers),
                                  hintText: 'Id',
                                  labelText: 'Id',
                                  contentPadding: EdgeInsets.symmetric(vertical:30, horizontal: 10),
                                  border: OutlineInputBorder(),
                                ),
                                // The validator receives the text that the user has entered.
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                                validator: (value) {
                                  if (value != null && double.tryParse(value) != null) {
                                    qaFormId = int.parse(value);
                                    return ;
                                  }
                                  return null;
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 30.0, bottom: 15.0, left: 20.0, right: 20.0),
                              child:  TextFormField(
                                decoration: const InputDecoration(
                                  icon: Icon(Icons.category),
                                  hintText: 'Thème',
                                  labelText: 'Thème *',
                                  contentPadding: EdgeInsets.symmetric(vertical:30, horizontal: 10),
                                  border: OutlineInputBorder(),
                                ),
                                // The validator receives the text that the user has entered.
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Veuillez entrer un thème !';
                                  } else {
                                    qaFormTheme = value;
                                    return null;
                                  }
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 15.0, bottom: 15.0, left: 20.0, right: 20.0),
                              child:  TextFormField(
                                decoration: const InputDecoration(
                                  icon: Icon(Icons.question_mark),
                                  hintText: 'Question',
                                  labelText: 'Question *',
                                  contentPadding: EdgeInsets.symmetric(vertical:30, horizontal: 10),
                                  border: OutlineInputBorder(),
                                ),
                                // The validator receives the text that the user has entered.
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Veuillez entrer la question !';
                                  } else {
                                    qaFormQuestion = value;
                                    return null;
                                  }
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 15.0, bottom: 15.0, left: 20.0, right: 20.0),
                              child:  TextFormField(
                                decoration: const InputDecoration(
                                  icon: Icon(Icons.question_answer),
                                  hintText: 'Réponse',
                                  labelText: 'Réponse *',
                                  contentPadding: EdgeInsets.symmetric(vertical:30, horizontal: 10),
                                  border: OutlineInputBorder(),
                                ),
                                // The validator receives the text that the user has entered.
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Veuillez entrer la réponse !';
                                  } else {
                                    qaFormReponse = value;
                                    return null;
                                  }
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(50.0),
                              child: Center(
                                child: ElevatedButton(
                                  onPressed: () {
                                    // Validate returns true if the form is valid, or false otherwise.
                                    if (_formKey.currentState!.validate()) {
                                      FocusScope.of(context).requestFocus(FocusNode());
                                      var data = Qa(id: qaFormId, theme: qaFormTheme, question: qaFormQuestion, reponse: qaFormReponse);
                                      addQuestion(qaFormId, data).then((res) => {
                                        if (res) {
                                          ScaffoldMessenger.of(context).showSnackBar(
                                              const SnackBar(
                                                content: Text(
                                                    'Question ajouté !',
                                                    style: TextStyle(
                                                      fontWeight: FontWeight.w500,
                                                      fontSize: 18.0,
                                                    )
                                                ),
                                                backgroundColor: Colors.lightGreen,
                                                duration: Duration(seconds: 1),
                                                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
                                              )
                                          ),
                                          setState(() {
                                            futureQas = fetchQuestions();
                                          }),
                                          Timer(const Duration(seconds: 1), (){
                                            _tabController.animateTo(0);
                                          })
                                        } else {
                                          ScaffoldMessenger.of(context).showSnackBar(
                                              const SnackBar(
                                                content: Text(
                                                    'Une erreur est survenue !',
                                                    style: TextStyle(
                                                      fontWeight: FontWeight.w500,
                                                      fontSize: 18.0,
                                                    )
                                                ),
                                                backgroundColor: Colors.red,
                                                duration: Duration(seconds: 2),
                                                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
                                              )
                                          )
                                        }
                                      });
                                    }
                                  },
                                  style: ButtonStyle(
                                    padding: MaterialStateProperty.all(const EdgeInsets.all(30)),
                                  ),
                                  child: const Text('Ajouter'),
                                ),
                              ),
                            ),
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

Future<List<Qa>> fetchQuestions() async {
  final response = await http.get(Uri.parse(baseUrl));

  if (response.statusCode == 200) {
    List jsonResponse = jsonDecode(response.body);
    return jsonResponse.map((qa) => Qa.fromJson(qa)).toList();
  } else {
    throw Exception('Failed to load questions/answers');
  }
}

Future<bool> deleteQuestion(int id) async {
  final response = await http.delete(
    Uri.parse('$baseUrl/$id'),
  );
  return Future<bool>.value(response.statusCode == 200);
}

Future<bool> addQuestion(int id, Qa qa) async {
  if (id > 0) {
    final response = await http.put(
        Uri.parse('$baseUrl/$id'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(qa.toJson())
    );
    return Future<bool>.value(response.statusCode == 200);
  } else {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(qa.toJson()),
    );
    return Future<bool>.value(response.statusCode == 200);
  }
}

