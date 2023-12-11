import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class Liste extends StatefulWidget {
  const Liste({Key? key}) : super(key: key);

  @override
  _ListeState createState() => _ListeState();
}

class _ListeState extends State<Liste> {
  late List<dynamic> lesFilms;
  bool dataOK = false;
  late String nomFilm;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    var arguments = ModalRoute.of(context)!.settings.arguments;

    if (arguments is String){
      nomFilm = arguments;
    }
    else{
      nomFilm = '';
    }
    recupFilm();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Liste de films'),
      ),
      body: dataOK ? affichage() : attente(),
    );
  }

    Future<void> recupFilm() async {
    //'www.omdbapi.com/?i=tt1190080&apikey=5bfa4aa7'
    Uri uri =Uri.http('www.omdbapi.com','',{'s': '$nomFilm','apikey' : 'c0c1b99a'});
    http.Response response = await http.get(uri);
    if (response.statusCode == 200) {
      Map data = convert.jsonDecode(response.body);
      if (data.containsKey('Search')){
        setState(() {
          lesFilms = List.from(data['Search']);
          dataOK = !dataOK;
        });
      }
    }
  }

  Widget attente() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('En attente des résultats de votre recherche',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold)),
          CircularProgressIndicator(color: Colors.blue,strokeCap: StrokeCap.round),
        ],
      ),
    );
  }

  Widget affichage() {
    final _formKey = GlobalKey<FormState>();
    
    return Form(
      key: _formKey,
      child: ListView.separated(
          separatorBuilder: (context, index) => Divider(color: Colors.white,),
          itemCount: lesFilms.length,
          itemBuilder: (context, index) {
            final item = lesFilms[index];
            return Dismissible(
              key: Key(item['imdbID']),
              background: Container(
                child: Icon(
                  Icons.delete,
                  size: 40,
                  color: const Color.fromARGB(255, 7, 125, 222),
                ),
              ),
              child: Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    side: BorderSide(color: Colors.white),
                    minimumSize: Size(double.infinity, 60),
                  ),
                  child: Text('${item['Title']}'),
                  onPressed: () {
                    String idFilm = item['imdbID'];

                    Navigator.pushNamed(
                      context, 
                      '/route3',
                      arguments: idFilm
                      );
                  },
                ),
              ),
            );
          }),
    );
  }
}