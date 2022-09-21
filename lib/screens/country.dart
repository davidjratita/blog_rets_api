
import 'package:flutter/material.dart';

class Country extends StatelessWidget {
  static const routeName = '/country';

  @override
  Widget build(BuildContext context) {
    final Map country = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: Text(country['category']),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            Text(
              country['category']
            ),
          ],
        ),
      ),
    );
  }
}

class CountryDetailCard extends StatelessWidget {
  final String title;
  final MaterialColor color;
  CountryDetailCard({this.title, this.color});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color,
      elevation: 10,
      child: Center(
        child: Text(
          title,
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
    );
  }
}

class CountryCard extends StatelessWidget {
  final String title;
  const CountryCard({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: Center(
          child: Text(
            title,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          )),
    );
  }
}