

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

final sqlClientProvider = Provider((ref) => SQFClient());

class SQFClient {
  static final SQFClient instance = SQFClient._init();

  static Database? _database;
  SQFClient._init();

  factory SQFClient() => instance;

  //git database instanse
  Future<Database> get database async {
    //if data base not empty return it
    if (_database != null) return _database!;
    //otherwise,initialize database
    _database = await _initDatabase();
    return _database!;
  }

//method that create database schema
  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'note_database.db');
      return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        db.execute('''CREATE TABLE tasks (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            text TEXT,
            description TEXT,
            isComplate DATE
          )
          ''');
      },
    );
  }

}
