import 'package:flutter/material.dart';
import 'home.dart';

/*
  The main.dart file is used to run the application. All features of the
  application are located in separate dart files.
  ex. home.dart is the file that creates most of the UI for the application
 */

Future<void> main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Final Project ANG',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}
