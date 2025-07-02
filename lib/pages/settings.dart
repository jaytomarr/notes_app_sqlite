import 'package:flutter/material.dart';
import 'package:notes_app_sqlite/providers/theme_provider.dart';
import 'package:provider/provider.dart';

class Settings extends StatelessWidget {
  bool isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Settings'), centerTitle: true),
      body: Container(
        child: SwitchListTile.adaptive(
          title: Text('Dark Mode'),
          // subtitle: Text('Change theme mode here'),
          activeColor: Colors.lightBlueAccent.shade100,
          value: context.watch<ThemeProvider>().getTheme(),
          onChanged: (value) {
            context.read<ThemeProvider>().changeTheme(value: value);
          },
        ),
      ),
    );
  }
}
