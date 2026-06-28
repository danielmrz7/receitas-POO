import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

enum TableStatus { idle, loading, ready, error }
enum ItemType { beer, coffee, nation, none }

class DataService {
  final ValueNotifier<Map<String, dynamic>> tableStateNotifier =
      ValueNotifier({
    'status': TableStatus.idle,
    'dataObjects': [],
    'itemType': ItemType.none,
  });

  void carregar(index) {
    final funcoes = [carregarCafes, carregarCervejas, carregarNacoes];
    funcoes[index]();
  }
void carregarCervejas() {
  if (tableStateNotifier.value['status'] == TableStatus.loading) return;
  if (tableStateNotifier.value['itemType'] != ItemType.beer) {
    tableStateNotifier.value = {
      'status': TableStatus.loading,
      'dataObjects': [],
      'itemType': ItemType.beer,
    };
  }

  var beersUri = Uri(
      scheme: 'https',
      host: 'api.openbrewerydb.org',
      path: 'v1/breweries',
      queryParameters: {'per_page': '10'});

  http.read(beersUri).then((jsonString) {
    var beersJson = jsonDecode(jsonString);
    if (tableStateNotifier.value['status'] != TableStatus.loading)
      beersJson = [...tableStateNotifier.value['dataObjects'], ...beersJson];

    tableStateNotifier.value = {
      'itemType': ItemType.beer,
      'status': TableStatus.ready,
      'dataObjects': beersJson,
      'propertyNames': ["name", "brewery_type", "city"],
      'columnNames': ["Nome", "Tipo", "Cidade"],
    };
  });
}
  void carregarNacoes() {
  if (tableStateNotifier.value['status'] == TableStatus.loading) return;
  if (tableStateNotifier.value['itemType'] != ItemType.nation) {
    tableStateNotifier.value = {
      'status': TableStatus.loading,
      'dataObjects': [],
      'itemType': ItemType.nation,
    };
  }

  var nationsUri = Uri(
      scheme: 'https',
      host: 'restcountries.com',
      path: 'v3.1/all',
      queryParameters: {'fields': 'name,capital,languages,region'});

  http.read(nationsUri).then((jsonString) {
    var nationsJson = (jsonDecode(jsonString) as List).take(10).map((e) => {
      'nationality': e['name']['common'],
      'capital': (e['capital'] != null && e['capital'].isNotEmpty)
          ? e['capital'][0]
          : 'N/A',
      'language': e['languages'] != null
          ? (e['languages'] as Map).values.first
          : 'N/A',
      'national_sport': e['region'] ?? 'N/A',
    }).toList();

    if (tableStateNotifier.value['status'] != TableStatus.loading)
      nationsJson = [...tableStateNotifier.value['dataObjects'], ...nationsJson];

    tableStateNotifier.value = {
      'itemType': ItemType.nation,
      'status': TableStatus.ready,
      'dataObjects': nationsJson,
      'propertyNames': ["nationality", "capital", "language", "national_sport"],
      'columnNames': ["Nome", "Capital", "Idioma", "Região"],
    };
  });
}

void carregarCafes() {
  if (tableStateNotifier.value['status'] == TableStatus.loading) return;
  if (tableStateNotifier.value['itemType'] != ItemType.coffee) {
    tableStateNotifier.value = {
      'status': TableStatus.loading,
      'dataObjects': [],
      'itemType': ItemType.coffee,
    };
  }

  // Dados mockados pois não há API gratuita equivalente
  var coffeesJson = List.generate(10, (i) => {
    "blend_name": "Blend ${i + 1}",
    "origin": ["Brasil", "Etiópia", "Colômbia", "Guatemala"][i % 4],
    "variety": ["Arábica", "Robusta", "Liberica"][i % 3],
  });

  if (tableStateNotifier.value['status'] != TableStatus.loading)
    coffeesJson = [...tableStateNotifier.value['dataObjects'], ...coffeesJson];

  tableStateNotifier.value = {
    'itemType': ItemType.coffee,
    'status': TableStatus.ready,
    'dataObjects': coffeesJson,
    'propertyNames': ["blend_name", "origin", "variety"],
    'columnNames': ["Nome", "Origem", "Tipo"],
  };
}

}

// ✅ DECLARADO GLOBALMENTE — fora de qualquer classe
final dataService = DataService();

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final functionsMap = {
    ItemType.beer: dataService.carregarCervejas,
    ItemType.coffee: dataService.carregarCafes,
    ItemType.nation: dataService.carregarNacoes,
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: const Text("Dicas")),
        body: ValueListenableBuilder<Map<String, dynamic>>(
          valueListenable: dataService.tableStateNotifier,
          builder: (_, value, __) {
            switch (value['status']) {
              case TableStatus.idle:
                return Center(child: Text("Toque algum botão, abaixo..."));
              case TableStatus.loading:
                return Center(child: CircularProgressIndicator());
              case TableStatus.ready:
                return ListWidget(
                  jsonObjects: value['dataObjects'],
                  propertyNames: value['propertyNames'],
                  scrollEndedCallback: functionsMap[value['itemType']],
                );
              case TableStatus.error:
                return Text("Lascou");
            }
            return Text("...");
          },
        ),
        bottomNavigationBar:
            NewNavBar(itemSelectedCallback: dataService.carregar),
      ),
    );
  }
}

class NewNavBar extends HookWidget {
  final void Function(int) _itemSelectedCallback;

  // ✅ CORRIGIDO: tipo correto no construtor
  NewNavBar({void Function(int)? itemSelectedCallback})
    : _itemSelectedCallback = itemSelectedCallback ?? ((_) {});

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

class ListWidget extends HookWidget {
  final dynamic _scrollEndedCallback;
  final List jsonObjects;
  final List<String> propertyNames;

  ListWidget({
    this.jsonObjects = const [],
    this.propertyNames = const [],
    void Function()? scrollEndedCallback,
  }) : _scrollEndedCallback = scrollEndedCallback ?? false;

  @override
  Widget build(BuildContext context) {
    var controller = useScrollController();

    useEffect(() {
      controller.addListener(() {
        if (controller.position.pixels ==
            controller.position.maxScrollExtent) {
          if (_scrollEndedCallback is Function) _scrollEndedCallback();
        }
      });
    }, [controller]);

    return ListView.separated(
      controller: controller,
      padding: EdgeInsets.all(10),
      separatorBuilder: (_, __) => Divider(
        height: 5,
        thickness: 2,
        indent: 10,
        endIndent: 10,
        color: Theme.of(context).primaryColor,
      ),
      itemCount: jsonObjects.length + 1,
      itemBuilder: (_, index) {
        if (index == jsonObjects.length)
          return Center(child: LinearProgressIndicator());

        var title = jsonObjects[index][propertyNames[0]];
        var content = propertyNames
            .sublist(1)
            .map((prop) => jsonObjects[index][prop])
            .join(" - ");

        return Card(
          shadowColor: Theme.of(context).primaryColor,
          child: Column(
            children: [
              SizedBox(height: 10),
              Text(
                "$title\n",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(content),
              SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }
}