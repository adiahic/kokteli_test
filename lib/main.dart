import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: Testiranje(),
    );
  }
}

class Testiranje extends StatefulWidget {
  @override
  _TestiranjeState createState() => _TestiranjeState();
}

class _TestiranjeState extends State<Testiranje> {
  var koktel;
  var koktelNaziv;
  var koktelSlika;
  Future mozdaKoktel = Pokupi().uzmi();

  _TestiranjeState() {
    mozdaKoktel.then((val) => setState(() {
          koktel = val;
          koktelNaziv = koktel['drinks'][0]['strDrink'];
          koktelSlika = koktel['drinks'][0]['strDrinkThumb'];

          print(koktelNaziv);
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                ' $koktelNaziv',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 50.0,
                  color: Colors.black54,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  height: 350.0,
                  width: 350.0,
                  child: Image.network('$koktelSlika'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Pokupi {
  var url = 'https://www.thecocktaildb.com/api/json/v1/1/random.php';

  Future uzmi() async {
    http.Response response = await http.get(url);
    String data = response.body;

    if (response.statusCode == 200) {
      String data = response.body;

      return jsonDecode(data);
    } else {
      print(response.statusCode);
    }

    String _koktel = jsonDecode(data);
    print(_koktel);
    return _koktel;
  }
}
