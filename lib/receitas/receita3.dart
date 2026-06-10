import 'package:flutter/material.dart';

void main() {
  MyApp app = MyApp();
  runApp(app);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      debugShowCheckedModeBanner:false,
      home: Scaffold(
      appBar: AppBar(
  title: const Text("APP DE BEBADOOOO"),
  actions: [
    PopupMenuButton(
      itemBuilder: (context) => [
        const PopupMenuItem(
          value: "roxo",
          child: Text("Roxo"),
        ),

        const PopupMenuItem(
          value: "azul",
          child: Text("Azul"),
        ),

        const PopupMenuItem(
          value: "verde",
          child: Text("Verde"),
        ),
      ],
    )
  ],
),
        body: DataBodyWidget(objects:[
          "La Fin Du Monde - Bock - 65 ibu",
          "Sapporo Premiume - Sour Ale - 54 ibu",
          "Duvel - Pilsner - 82 ibu"
        ]),

        bottomNavigationBar: NewNavBar(
        icons: const [
        Icons.coffee_outlined,
        Icons.local_drink_outlined,
        Icons.flag_outlined
        ],
),
      ));
  }
}

class NewNavBar extends StatelessWidget {
  List<IconData> icons;
  NewNavBar({this.icons = const []});
  void botaoFoiTocado(int index) {
    print("Tocaram no botão $index");
  }
  BottomNavigationBarItem criarItem(IconData icon){
    return BottomNavigationBarItem(
      label: "",
      icon: Icon(icon),
    );
  }
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: botaoFoiTocado,
      items: icons.map(
        (icon) => criarItem(icon)
      ).toList(),
    );
  }
}

class DataBodyWidget extends StatelessWidget {
  List<String> objects;
  DataBodyWidget( {this.objects = const [] });
  Expanded processarUmElemento(String obj){
    return Expanded(                
          child: Center(child: Text(obj)),
        );
  }
  @override
  Widget build(BuildContext context) {
    return Column(children: objects.map( 
      (obj) => Expanded(
        child: Center(child: Text(obj)),
        )
      ).toList());
  }
}