// main.dart
import 'package:flutter/material.dart';
import 'todo_list.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ToDoList(),


      theme: ThemeData.light(), // Default theme (light)
    darkTheme: ThemeData.dark(), // Dark theme





    );
  }
}
