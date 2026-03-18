import 'package:flutter/material.dart';

void main() {
  

    MaterialApp app = MaterialApp(
      theme: ThemeData(scaffoldBackgroundColor:Colors.black,
      primarySwatch: Colors.deepPurple),

      home: Scaffold(
        appBar: AppBar(
        title: Text("Barra Roxa"),
        centerTitle: true,),
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
                  fontSize: 15,
                  ),
                ),
            ],
      )));
  runApp(app);
}


class IconButtonApp extends StatelessWidget {
  const IconButtonApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(colorSchemeSeed: const Color(0xff6750a4)),
      title: 'Icon Button Types',
      home: const Scaffold(body: ButtonTypesExample()),
    );
  }
}