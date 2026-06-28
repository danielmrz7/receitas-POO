import 'package:flutter/material.dart';

import 'package:flutter_hooks/flutter_hooks.dart';

import '../data/data_service.dart';

import 'package:get/get.dart';




class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.deepPurple,
            primary: Colors.deepPurple,
          ),
    
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.deepPurple,
            foregroundColor: Colors.white, // Text/Icons color
          ),
        ),
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            title: const Text("Dicas"),
          ),
          body: ValueListenableBuilder(
              valueListenable: dataService.tableStateNotifier,
              builder: (_, value, __) {
                return PaginatedTableContainer(
                  jsonObjects: value["objects"],
                  columnNames: value["columns"],
                  propertyNames: value["properties"],
                  statusLabel: "Pág. ${value["page"]} de ${value["pages"]}",
                  onNext: dataService
                      .carregarPaginaSeguinte, // Propagating the action
                  onPrevious: dataService.carregarPaginaAnterior,
                );
              }),
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
      this.propertyNames = const ["title", "brand", "description"]});
  @override
  Widget build(BuildContext context) {
    return DataTable(
        columns: columnNames
            .map((name) => DataColumn(
                label: Expanded(
                    child: Text(name,
                        style: TextStyle(fontStyle: FontStyle.italic)))))
            .toList(),
        rows: jsonObjects
            .map((obj) => DataRow(
                cells: propertyNames
                    .map((propName) => DataCell(
                        Text(obj[propName] != null ? "${obj[propName]}" : "")))
                    .toList()))
            .toList());
  }
}


class PaginatedTableContainer extends StatelessWidget {
  final List jsonObjects;
  final List<String> columnNames;
  final List<String> propertyNames;
  final VoidCallback onNext;
  final VoidCallback onPrevious;
  final String statusLabel; // e.g., "Page 1 of 10"
  const PaginatedTableContainer({
    super.key,
    required this.jsonObjects,
    required this.columnNames,
    required this.propertyNames,
    required this.onNext,
    required this.onPrevious,
    required this.statusLabel,
  });


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: DataTableWidget(
              jsonObjects: jsonObjects,
              columnNames: columnNames,
              propertyNames: propertyNames,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          color: Colors.grey[200],
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                  onPressed: onPrevious, child: const Text("Previous")),
              Text(statusLabel,
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              ElevatedButton(onPressed: onNext, child: const Text("Next")),
            ],
          ),
        ),
      ],
    );
  }
}



class HomeScreen extends StatelessWidget {

  const HomeScreen({super.key});



  void _navigateToSearch(BuildContext context) {

    Get.toNamed("/search");

  }



  @override

  Widget build(BuildContext context) {

    return Scaffold(

      body: Center(

        child: Padding(

          padding: const EdgeInsets.all(16.0),

          child: Column(

            mainAxisSize: MainAxisSize.min,

            mainAxisAlignment: MainAxisAlignment.center,

            crossAxisAlignment: CrossAxisAlignment.center,

            children: [

              const Text(

                'Bem-vindo!',

                style: TextStyle(

                  fontSize: 28,

                  fontWeight: FontWeight.bold,

                ),

                textAlign: TextAlign.center,

              ),

              const SizedBox(height: 24),

              ElevatedButton(

                onPressed: () => _navigateToSearch(context),

                style: ElevatedButton.styleFrom(

                  padding: const EdgeInsets.symmetric(

                    horizontal: 32,

                    vertical: 12,

                  ),

                ),

                child: const Text(

                  'Pesquisar',

                  style: TextStyle(fontSize: 18),

                ),

              ),

            ],

          ),

        ),

      ),

    );

  }

}



