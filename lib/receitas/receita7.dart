import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DataService {
  final ValueNotifier<List> tableStateNotifier = ValueNotifier([]);

  void carregar(index) {
    if (index == 1) carregarCervejas();
  }

Future<void> carregarCervejas() async {
    var beersUri = Uri(
        scheme: 'https',
        host: 'api.openbrewerydb.org',
        path: 'v1/breweries',
        queryParameters: {'per_page': '5'});

    var jsonString = await http.read(beersUri);

    var beersJson = jsonDecode(jsonString);

    tableStateNotifier.value = beersJson;
  }

}

final dataService = DataService();

void main() {
  MyApp app = MyApp();
  runApp(app);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(primarySwatch: Colors.deepPurple),
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            title: const Text("Dicas"),
          ),
          body: ValueListenableBuilder(
            valueListenable: dataService.tableStateNotifier,
            builder: (_, value, __) {
              return DataTableWidget(
                jsonObjects: value, 
                propertyNames: const ["name", "brewery_type", "country"],
                columnNames: const ["Nome", "Tipo", "País"]
              );
            }
          ),
          bottomNavigationBar:
              NewNavBar(itemSelectedCallback: dataService.carregar),
        ));
  }
}

class NewNavBar extends HookWidget {
  final _itemSelectedCallback;
  
  NewNavBar({itemSelectedCallback})
      : _itemSelectedCallback = itemSelectedCallback ?? (int) {}

  @override
  Widget build(BuildContext context) {
    var state = useState(1);

    return BottomNavigationBar(
        onTap: (index) {
          state.value = index;
          _itemSelectedCallback(index);
        },
        currentIndex: state.value,
        items: const [
          BottomNavigationBarItem(
            label: "Cafés",
            icon: Icon(Icons.coffee_outlined),
          ),
          BottomNavigationBarItem(
              label: "Cervejas", icon: Icon(Icons.local_drink_outlined)),
          BottomNavigationBarItem(
              label: "Nações", icon: Icon(Icons.flag_outlined))
        ]);
  }
}

class DataTableWidget extends StatelessWidget {
  final List jsonObjects;
  final List<String> columnNames;
  final List<String> propertyNames;

  DataTableWidget(
      {this.jsonObjects = const [],
      this.columnNames = const ["Nome", "Estilo", "IBU"],
      this.propertyNames = const ["name", "style", "ibu"]});

  @override
  Widget build(BuildContext context) {
    return DataTable(
        columns: columnNames.map((name) => DataColumn(
            label: Expanded(
            child: Text(name,
            style: const TextStyle(
            fontStyle: FontStyle.italic))))).toList(),
            rows: jsonObjects
            .map((obj) => DataRow(
                cells: propertyNames.map((propName) => DataCell(Text(obj[propName]))).toList()))
            .toList());
  }
}