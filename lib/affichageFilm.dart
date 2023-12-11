import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class Affichage extends StatefulWidget {

  final String title = 'Film';

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<Affichage> {
  late Map<String, dynamic> film;
  bool dataOK = false;
  late String idFilm;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    var arguments = ModalRoute.of(context)!.settings.arguments;

    if (arguments is String){
      idFilm = arguments;
    }
    else{
      idFilm = '';
    }
    recupFilm();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Container (
          child: dataOK ? affichage() : attente(),
          color : Colors.blueGrey[900],
        ),
      ),
    );
  }

  Future<void> recupFilm() async {
    //'www.omdbapi.com/?i=tt1190080&apikey=5bfa4aa7'
    Uri uri =Uri.http('www.omdbapi.com','',{'i': '$idFilm','apikey' : 'c0c1b99a'});
    http.Response response = await http.get(uri);
    if (response.statusCode == 200) {
      film = convert.jsonDecode(response.body) as Map<String, dynamic>;
      setState(() {
        dataOK = !dataOK;
      });
    }
  }

  Widget attente() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('En attente des informations du film',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold)),
          CircularProgressIndicator(color: Colors.deepOrange,strokeCap: StrokeCap.round),
        ],
      ),
    );
  }

  Widget affichage() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            '${film['Title']}',
            style: const TextStyle(
                color: Colors.red,
                fontSize: 30.0,
                fontWeight: FontWeight.bold
                ),
          ),
          const Padding(padding: EdgeInsets.all(15.0)),
          Text(
            '${film['Year']}',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20.0,
            ),
          ),
          const Padding(padding: EdgeInsets.all(15.0)),
          Container(
            width: MediaQuery.of(context).size.width * 0.6,
            decoration: const BoxDecoration(boxShadow: [
              BoxShadow(
                  color: Colors.black,
                  offset: Offset(0.0, 7.0),
                  spreadRadius: 3.0,
                  blurRadius: 15.0)
            ]),
            /**************************/
            child:
                Image.network('${film['Poster']}')
          ),
          /**************************/
          const Padding(padding: EdgeInsets.all(15.0)),
          /**************************/
          Text(
            'Description :',
            style: const TextStyle(
              color: Colors.red,
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Padding(padding: EdgeInsets.all(15.0)),
          Text(
            '${film['Plot']}',
            style: const TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
            softWrap: true,
          ),
          const Padding(padding: EdgeInsets.all(15.0)),
              /**************************/
          Text(
            'Liste des acteurs :',
            style: const TextStyle(
              color: Colors.red,
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Padding(padding: EdgeInsets.all(15.0)),
          Text(
                '${film['Actors']}',
                style: const TextStyle(color: Colors.white,fontSize: 17,fontWeight: FontWeight.bold ),
                textAlign: TextAlign.center,
              ),
          const Padding(padding: EdgeInsets.all(15.0)),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(
                context,
                '/route2',
                arguments: film['title']
              );
            }, 
            child: Text('Retour à la liste')
            ),
          const Padding(padding: EdgeInsets.all(15.0)),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(
                context,
                '/route1'
              );
            }, 
            child: Text('Retour à la recherche')
            ),
            const Padding(padding: EdgeInsets.all(15.0)),
        ],
      ),
    );
  }
}
