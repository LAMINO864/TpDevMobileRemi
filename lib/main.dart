import 'package:flutter/material.dart';
import 'package:tp_film/recherche.dart';
import 'recherche.dart';
import 'affichageFilm.dart';
import 'listeFilm.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Recherche(),
      routes: <String, WidgetBuilder> {
        '/route1': (BuildContext context) => Recherche(),
        '/route2': (BuildContext context) => Liste(),
        '/route3': (BuildContext context) => Affichage(),
      },
    );
  }
}




