import 'dart:io';

// import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DB {
  /// singleton
  DB._();

  static final DB getInstance = DB._();
  static final String TABLE_NOTE = 'notes';
  static final String COLUMN_NOTE_SNO = 's_no';
  static final String COLUMN_NOTE_TITLE = 'title';
  static final String COLUMN_NOTE_DESC = 'desc';

  Database? myDB;

  ///db open
  Future<Database> getDB() async {
    myDB = myDB ?? await openDB();
    return myDB!;

    // if (myDB != null) {
    //   return myDB!;
    // } else {
    //   myDB = await openDB();
    //   return myDB!;
    // }
  }

  Future<Database> openDB() async {
    Directory appDir = await getApplicationDocumentsDirectory();
    String dbPath = join(appDir.path, 'notesDB.db');

    return await openDatabase(
      dbPath,
      onCreate: (db, version) {
        /// create tables here
        db.execute(
          'create table $TABLE_NOTE ($COLUMN_NOTE_SNO integer primary key autoincrement, $COLUMN_NOTE_TITLE text, $COLUMN_NOTE_DESC text)',
        );
      },
      version: 1,
    );
  }

  ///add note query
  Future<bool> addNote({
    required String noteTitle,
    required String noteDesc,
  }) async {
    var db = await getDB();

    int rowsAffected = await db.insert(TABLE_NOTE, {
      COLUMN_NOTE_TITLE: noteTitle,
      COLUMN_NOTE_DESC: noteDesc,
    });

    return rowsAffected > 0;
  }

  ///fetch all notes query
  Future<List<Map<String, dynamic>>> getAllNotes() async {
    var db = await getDB();
    List<Map<String, dynamic>> notesData = await db.query(TABLE_NOTE);
    return notesData;
  }

  ///update note query
  Future<bool> updateNote({
    required String title,
    required String desc,
    required int sno,
  }) async {
    var db = await getDB();

    int rowsAffected = await db.update(
      TABLE_NOTE,
      {COLUMN_NOTE_TITLE: title, COLUMN_NOTE_DESC: desc},
      where: '$COLUMN_NOTE_SNO = ?',
      whereArgs: [sno],
    );

    return rowsAffected > 0;
  }

  ///delete note query
  Future<bool> deleteNote({required int sno}) async {
    var db = await getDB();

    int rowsAffected = await db.delete(
      TABLE_NOTE,
      where: '$COLUMN_NOTE_SNO = ?',
      whereArgs: [sno],
    );

    return rowsAffected > 0;
  }
}
