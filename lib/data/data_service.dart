import "package:flutter/material.dart";

import 'package:http/http.dart' as http;

import 'dart:convert';



class DataService {

  final ValueNotifier tableStateNotifier = ValueNotifier({

    "objects": [],

    "properties": ["title", "brand", "description"],

    "columns": ["Nome", "Marca", "Descrição"],

    "total": 0,

    "pageSize": 5,

    "page": 0,

    "pages": 0,

    "cursor": 0

  });



  void carregar(index) {

    final funcoes = [carregarCafes, carregarCervejas, carregarNacoes];



    funcoes[index]();

  }



  void carregarPaginaSeguinte() async {

    final pageSize = tableStateNotifier.value["pageSize"];

    final newSkip = tableStateNotifier.value["cursor"] + pageSize;

    final total = tableStateNotifier.value["total"];



    if (newSkip >= total) return;



    var uri = Uri(

        scheme: 'https',

        host: 'dummyjson.com',

        path: 'products',

        queryParameters: {

          'limit': '$pageSize',

          'skip': '$newSkip',

          'select': 'title,description,brand'

        });



    var jsonString = await http.read(uri);

    var json = jsonDecode(jsonString);



    tableStateNotifier.value = {

      "objects": json["products"],

      "properties": ["title", "brand", "description"],

      "columns": ["Nome", "Marca", "Descrição"],

      "total": json["total"],

      "pageSize": json["limit"],

      "page": (json["skip"] ~/ json["limit"]) + 1,

      "pages": (json["total"] ~/ json["limit"]) + 1,

      "cursor": json["skip"]

    };

  }



  void carregarPaginaAnterior() {

    //TODO

  }



  void carregarCafes() {

    //TODO

    return;

  }



  void carregarNacoes() {

    //TODO

    return;

  }



  Future<void> carregarCervejas() async {

    var beersUri = Uri(

        scheme: 'https',

        host: 'dummyjson.com',

        path: 'products',

        queryParameters: {'limit': '5', 'select': 'title,description,brand'});



    var jsonString = await http.read(beersUri);

    var json = jsonDecode(jsonString);



    tableStateNotifier.value = {

      "objects": json["products"],

      "properties": ["title", "brand", "description"],

      "columns": ["Nome", "Marca", "Descrição"],

      "total": json["total"],

      "pageSize": json["limit"],

      "page": (json["skip"] ~/ json["limit"]) + 1,

      "pages": (json["total"] ~/ json["limit"]) + 1,

      "cursor": json["skip"]

    };





  }

}



final dataService = DataService();

