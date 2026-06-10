import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class DataService {
  final ValueNotifier<List> tableStateNotifier = ValueNotifier([]);
  final ValueNotifier<Map> tablePropertiesNotifier = ValueNotifier({
    "columnNames": ["Nome", "Estilo", "IBU"],
    "propertyNames": ["name", "style", "ibu"],
  });

  void carregar(index) {
    List<Function> funcoes = [carregarCafes, carregarCervejas, carregarNacoes];
    funcoes[index]();
  }

  void carregarCafes() {
    tablePropertiesNotifier.value = {
      "columnNames": ["Nome", "Tipo", "Origem"],
      "propertyNames": ["name", "style", "ibu"],
    };
    tableStateNotifier.value = [
      {"name": "Espresso", "style": "Curto", "ibu": "Itália"},
      {"name": "Cappuccino", "style": "Com leite", "ibu": "Itália"},
      {"name": "Cold Brew", "style": "Gelado", "ibu": "EUA"},
    ];
  }

  void carregarCervejas() {
    tablePropertiesNotifier.value = {
      "columnNames": ["Nome", "Estilo", "IBU"],
      "propertyNames": ["name", "style", "ibu"],
    };
    tableStateNotifier.value = [
      {"name": "La Fin Du Monde", "style": "Bock", "ibu": "65"},
      {"name": "Sapporo Premium", "style": "Sour Ale", "ibu": "54"},
      {"name": "Duvel", "style": "Pilsner", "ibu": "82"},
    ];
  }

  void carregarNacoes() {
    tablePropertiesNotifier.value = {
      "columnNames": ["Nome", "Continente", "Capital"],
      "propertyNames": ["name", "style", "ibu"],
    };
    tableStateNotifier.value = [
      {"name": "Brasil", "style": "América do Sul", "ibu": "Brasília"},
      {"name": "Japão", "style": "Ásia", "ibu": "Tóquio"},
      {"name": "Alemanha", "style": "Europa", "ibu": "Berlim"},
    ];
  }
}

final dataService = DataService();

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Meu App de Bebadoooo"),
        ),
        body: ValueListenableBuilder(
          valueListenable: dataService.tablePropertiesNotifier,
          builder: (_, properties, __) {
            return ValueListenableBuilder(
              valueListenable: dataService.tableStateNotifier,
              builder: (_, value, __) {
                return DataTableWidget(
                  jsonObjects: value,
                  columnNames: List<String>.from(properties["columnNames"]),
                  propertyNames: List<String>.from(properties["propertyNames"]),
                );
              },
            );
          },
        ),
        bottomNavigationBar: NewNavBar(itemSelectedCallback: dataService.carregar),
      ),
    );
  }
}

class NewNavBar extends HookWidget {
  var itemSelectedCallback;

  NewNavBar({this.itemSelectedCallback}) {
    itemSelectedCallback ??= (_) {};
  }

  @override
  Widget build(BuildContext context) {
    var state = useState(1);
    return BottomNavigationBar(
      onTap: (index) {
        state.value = index;
        itemSelectedCallback(index);
      },
      currentIndex: state.value,
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
        ),
      ],
    );
  }
}

class DataTableWidget extends StatelessWidget {
  final List jsonObjects;
  final List<String> columnNames;
  final List<String> propertyNames;

  DataTableWidget({
    this.jsonObjects = const [],
    this.columnNames = const ["Nome", "Estilo", "IBU"],
    this.propertyNames = const ["name", "style", "ibu"],
  });

  @override
  Widget build(BuildContext context) {
    return DataTable(
      columns: columnNames
          .map((name) => DataColumn(
                label: Expanded(
                  child: Text(name,
                      style: TextStyle(fontStyle: FontStyle.italic)),
                ),
              ))
          .toList(),
      rows: jsonObjects
          .map((obj) => DataRow(
                cells: propertyNames
                    .map((propName) => DataCell(Text(obj[propName])))
                    .toList(),
              ))
          .toList(),
    );
  }
}