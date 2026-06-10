import 'package:flutter/material.dart';



void main() {

  MyApp app = MyApp();
  runApp(app);
}

class ListarVinhos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Text("La Fin Du Monde - Bock - 65 ibu"),
        ),
        Expanded(
          child: Text("Sapporo Premiume - Sour Ale - 54 ibu"),
        ),
        Expanded(
          child: Text("Duvel - Pilsner - 82 ibu"),
        )
      ],
    );
  }
}

class MinhaNavBar extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(
          label: "Cafés",
          icon: Icon(Icons.coffee_outlined),
        ),
        BottomNavigationBarItem(
          label: "Cervejas",
          icon: Icon(Icons.local_drink_outlined),
        ),
        BottomNavigationBarItem(
          label: "Nações",
          icon: Icon(Icons.flag_outlined),
        )
      ],
    );
  }
}

class MinhaAppBar extends AppBar {
  MinhaAppBar()
      : super(
          title: const Text("Meu App de Bebado"),
        );
}
class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),

      home: Scaffold(
        appBar: MinhaAppBar(),
        body: ListarVinhos(),
        bottomNavigationBar: MinhaNavBar(),
      ),
    );
  }
}