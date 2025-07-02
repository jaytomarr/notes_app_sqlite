import 'package:flutter/material.dart';
import 'package:notes_app_sqlite/data/local/db.dart';
// import 'package:notes_app_sqlite/data/local/db.dart';
import 'package:notes_app_sqlite/pages/home.dart';
import 'package:notes_app_sqlite/providers/db_provider.dart';
import 'package:notes_app_sqlite/providers/theme_provider.dart';
import 'package:provider/provider.dart';

void main() => runApp(
  MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => DBProvider(db: DB.getInstance),
      ),
      ChangeNotifierProvider(create: (context) => ThemeProvider()),
    ],
    child: MyApp(),
  ),
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // DB db = DB.getInstance;
    return MaterialApp(
      title: 'My Notes',
      debugShowCheckedModeBanner: false,
      themeMode: context.watch<ThemeProvider>().getTheme()
          ? ThemeMode.dark
          : ThemeMode.light,
      darkTheme: ThemeData.dark(),
      theme: ThemeData(brightness: Brightness.light, useMaterial3: true),
      home: Home(),
    );
  }
}
