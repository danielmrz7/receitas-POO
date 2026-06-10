import 'package:flutter/material.dart';


var dataObjects = [
    {
      "name": "La Fin Du Monde",
      "style": "Bock",
      "ibu": "65"
    },
    {
      "name": "Sapporo Premiume",
      "style": "Sour Ale",
      "ibu": "54"
    },
    {
      "name": "Duvel", 
      "style": "Pilsner", 
      "ibu": "82"
    },
    {
    "name": "Heineken",
    "style": "Lager",
    "ibu": "23"
    },
    {
      "name": "Guinness",
      "style": "Stout",
      "ibu": "45"
    },
    {
      "name": "Corona",
      "style": "Pale Lager",
      "ibu": "19"
    },
];


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
          title: const Text("Meu App de Bebado"),
          ),
        body: DataBodyWidget(
        objects: dataObjects,
        columnNames: ["Nome", "Estilo", "IBU"],
        propertyNames: ["name", "style", "ibu"],
        ),
        bottomNavigationBar: NewNavBar(),
      ));
  }
}

class NewNavBar extends StatelessWidget {
  NewNavBar();
  void botaoFoiTocado(int index) {
    print("Tocaram no botão $index");
  }
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(onTap: botaoFoiTocado, items: const [
      BottomNavigationBarItem(
        label: "Cafés",
        icon: Icon(Icons.coffee_outlined),
      ),
      BottomNavigationBarItem(
          label: "Cervejas", icon: Icon(Icons.local_drink_outlined)),
      BottomNavigationBarItem(label: "Nações", icon: Icon(Icons.flag_outlined))
    ]);
  }
}

class DataBodyWidget extends StatelessWidget {
  final List objects;
  final List<String> columnNames;
  final List<String> propertyNames;

  DataBodyWidget({
    required this.objects,
    required this.columnNames,
    required this.propertyNames,
  });
  @override
  Widget build(BuildContext context) {
    return DataTable(
      columns: columnNames.map( 
                (name) => DataColumn(
                  label: Expanded(
                    child: Text(name, style: TextStyle(fontStyle: FontStyle.italic))
                  )
                )
              ).toList()       
      ,
      rows: objects.map( 
        (obj) => DataRow(
            cells: propertyNames.map(
              (propName) => DataCell(Text(obj[propName]))
            ).toList()
          )
        ).toList());
  }
}

class MytileWidget extends StatelessWidget {
  List objects;

  MytileWidget({this.objects = const []});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: objects.map<Widget>((obj) {
        return ListTile(
          leading: Icon(Icons.local_drink),
          title: Text(obj["name"]),
          subtitle: Text(
            "Estilo: ${obj["style"]} - IBU: ${obj["ibu"]}"
          ),
        );
      }).toList(),
    );
  }
}