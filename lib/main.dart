import 'package:flutter/material.dart';

import 'view/widgets.dart';

import 'package:get/get.dart';



void main() {

  runApp(GetMaterialApp(

    initialRoute: '/',

    getPages: [

      GetPage(name: '/', page: () => HomeScreen()),

      GetPage(name: '/search', page: () => MyApp()),

    ],

  ));

}