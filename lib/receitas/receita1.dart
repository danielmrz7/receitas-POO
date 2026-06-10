import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData(
        useMaterial3: true,

        colorScheme: ColorScheme.dark(
          primary: Colors.black,
        ),

        appBarTheme: AppBarTheme(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          centerTitle: true,
        ),
        scaffoldBackgroundColor: Color(0xFF111111),//Eu quis por essa cor no backgroud para dar destaque ao tiutlo do app
      ),

      home: Scaffold(
        appBar: AppBar(
        title: Text("Eu"),
        ),

        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              Text(
                "Começo",
                  style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                ),
              ),

              SizedBox(height: 20),

              Text(
                "Meio",
                  style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                ),
              ),

              SizedBox(height: 20),

              Text(
                "Fim ",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22
                ),
              ),

              SizedBox(height: 20),

              ElevatedButton(
              style: ElevatedButton.styleFrom(
              backgroundColor: Colors.purple,
              foregroundColor: Colors.white,
              ),

              onPressed: () {},

              child: Text("Auauau"),
                ),
            ],
          ),
        ),
      ),
    ),
  );
}