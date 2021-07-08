import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:sembast_web/sembast_web.dart';
import 'package:sembast/sembast.dart';
import 'user_dao.dart';

import 'dart:async';

import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart'as sembast;
import 'package:sembast/sembast_io.dart';
class WebDatabase {
  // Singleton instance
  static final WebDatabase _singleton = WebDatabase._();

  // Singleton accessor
  static WebDatabase get instance => _singleton;

  // Completer is used for transforming synchronous code into asynchronous code.
  Completer<sembast.Database> _dbOpenCompleter;

  // A private constructor. Allows us to create instances of AppDatabase
  // only from within the AppDatabase class itself.
  WebDatabase._();

  // Sembast database object
  sembast.Database _database;

  // Database object accessor
  Future<sembast.Database> get database async {
    // If completer is null, AppDatabaseClass is newly instantiated, so database is not yet opened
    if (_dbOpenCompleter == null) {
      _dbOpenCompleter = Completer();
      // Calling _openDatabase will also complete the completer with database instance
      _openDatabase();
    }
    // If the database is already opened, awaiting the future will happen instantly.
    // Otherwise, awaiting the returned future will take some time - until complete() is called
    // on the Completer in _openDatabase() below.
    return _dbOpenCompleter.future;
  }

  Future _openDatabase() async {
    // Get a platform-specific directory where persistent app data can be stored
    final appDocumentDir = await getApplicationDocumentsDirectory();
    // Path with the form: /platform-specific-directory/demo.db
    final dbPath = join(appDocumentDir.path, 'sgi.db');

    final database = await databaseFactoryIo.openDatabase(dbPath);
    // Any code awaiting the Completer's future will now start executing
    _dbOpenCompleter.complete(database);
  }
}