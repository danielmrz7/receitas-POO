import 'package:flutter/material.dart';

void main() {

    MaterialApp app = MaterialApp(
      theme: ThemeData(scaffoldBackgroundColor:Colors.black,
      primarySwatch: Colors.deepPurple),

      home: Scaffold(
        appBar: AppBar(title: Text("Barra Roxa")),
        body: Center(
          child: Column(
            children: [
              Text(""),
              Text(""),
              Text(""),
              Text(
                  'TEXTO DE CENTRO',
                  style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'TimesNewRoman',
                  fontSize: 20,
                  ),
                )

            ],
          )
        ),
        bottomNavigationBar: Row(
          children: <Widget>[
            Text(
                  'Botão 1',
                  style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'TimesNewRoman',
                  fontSize: 15,
                  ),
                ),
            ],
      )));
  runApp(app);
}