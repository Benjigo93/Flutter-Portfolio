import 'dart:async';

import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import '../components/menu_nav.dart';

// Contact Page
class ContactPage extends StatefulWidget {
  const ContactPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  ContactFormState createState() {
    return ContactFormState();
  }
}

class ContactFormState extends State<ContactPage> {

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.blueAccent,
      ),
      drawer: const MenuNavigation(),
      body: SingleChildScrollView(
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
                        icon: Icon(Icons.person),
                        hintText: 'Votre nom de famille',
                        labelText: 'Nom *',
                      ),
                      // The validator receives the text that the user has entered.
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Veuillez entrer votre nom !';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 58.0, right: 20.0, top:15.0, bottom: 15.0),
                    child:  TextFormField(
                     decoration: const InputDecoration(
                       hintText: 'Votre prénom',
                       labelText: 'Prénom *',
                     ),
                     // The validator receives the text that the user has entered.
                     validator: (value) {
                       if (value == null || value.isEmpty) {
                         return 'Veuillez entrer votre prénom !';
                       }
                       return null;
                     },
                   ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0, bottom: 15.0, left: 20.0, right: 20.0),
                    child:  TextFormField(
                      decoration: const InputDecoration(
                        icon: Icon(Icons.alternate_email),
                        hintText: 'Votre adresse email',
                        labelText: 'Email *',
                      ),
                      // The validator receives the text that the user has entered.
                      validator: (value) {
                        if (value == null || value.isEmpty || !EmailValidator.validate(value)) {
                          return 'Veuillez entrer votre email !';
                        }
                        return null;
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
                            // If the form is valid, display a snackbar. In the real world,
                            // you'd often call a server or save the information in a database.
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text(
                                     'Envoi du formulaire...',
                                     style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18.0,
                                     )
                                  ),
                                  backgroundColor: Colors.blueGrey,
                                  duration: Duration(seconds: 3),
                                  padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
                              ),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Formulaire envoyé !',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18.0,
                                  )
                                ),
                                backgroundColor: Colors.lightGreen,
                                duration: Duration(seconds: 2),
                                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
                              ),
                            );
                            Timer(const Duration(seconds: 6), (){
                              Navigator.pushNamed(context, '/');
                            });
                          }
                        },
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all(const EdgeInsets.all(30)),
                          ),
                        child: const Text('Envoyer'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}