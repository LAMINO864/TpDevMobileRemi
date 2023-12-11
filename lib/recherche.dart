import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

/// *****************************
/// Class  MyHomePage
///*****************************
class Recherche extends StatefulWidget {

  final String title = 'Filmographia';

  @override
  MyHomePageState createState() => MyHomePageState();
}

/// *****************************
/// Class Privée MyHomePageState
///*****************************
class MyHomePageState extends State<Recherche> {
  late Map<String, dynamic> film;
  bool dataOK = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.blue,
      ),
      body: recherche(context),
      backgroundColor: Colors.white,
    );
  }

  Widget recherche(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    TextEditingController _nomFilm = TextEditingController();

    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text("Recherche de film : ",
            style : TextStyle(
              color: Colors.black,
              fontSize: 20.0,
              fontWeight: FontWeight.bold
              )),
          TextFormField(
            controller: _nomFilm,
            validator: (value){
              if (value == null || value.isEmpty){
                return 'Nom du film';
              }
              return null;
            },
            decoration: const InputDecoration(labelText: 'Nom du film'),

          ),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()){
                String film = _nomFilm.text;
                
                Navigator.pushNamed(
                context,
                '/route2',
                arguments: film,
              );
              }
            },
            child: const Text('Recherche'),
            )
        ],
      ),
    );
  }
}

