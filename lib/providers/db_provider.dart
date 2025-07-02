import 'package:flutter/material.dart';
import 'package:notes_app_sqlite/data/local/db.dart';

class DBProvider extends ChangeNotifier {
  List<Map<String, dynamic>> _allNotes = [];
  DB db;
  DBProvider({required this.db});

  ///events
  void addNote(String title, String desc) async {
    bool check = await db.addNote(noteTitle: title, noteDesc: desc);

    if (check) {
      _allNotes = await db.getAllNotes();
      notifyListeners();
    }
  }

  List<Map<String, dynamic>> getNotes() => _allNotes;

  void getInitialNotes() async {
    _allNotes = await db.getAllNotes();
    notifyListeners();
  }

  void updateNote(String title, String desc, int sno) async {
    bool check = await db.updateNote(title: title, desc: desc, sno: sno);

    if (check) {
      _allNotes = await db.getAllNotes();
      notifyListeners();
    }
  }

  void deleteNote(int sno) async {
    bool check = await db.deleteNote(sno: sno);

    if (check) {
      _allNotes = await db.getAllNotes();
      notifyListeners();
    }
  }
}
