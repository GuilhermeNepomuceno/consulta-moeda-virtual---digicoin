import 'package:digicoin/pages/homePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main(List<String> args) async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final String titulo = 'Relatório diário';

  @override
  Widget build(BuildContext contexto) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    return MaterialApp(
      title: this.titulo,
      theme: ThemeData(
          primaryColor: Colors.deepOrange,
          primaryColorLight: Colors.deepOrange[200],
          accentColor: Colors.green[500],
          backgroundColor: Colors.orange[50],
          textTheme: TextTheme(
              bodyText2: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              subtitle1: TextStyle(fontWeight: FontWeight.bold, fontSize: 18))),
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
