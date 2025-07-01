import 'package:flutter/material.dart';
import 'package:notes_app_sqlite/data/local/db.dart';
import 'package:notes_app_sqlite/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    DB db = DB.getInstance;
    return MaterialApp(
      title: 'My Notes',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.lightBlueAccent,
      ),
      home: Home(),
    );
  }
}
