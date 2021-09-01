import 'package:path/path.dart';
import 'package:sgi/database/dao/department_dao.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

import 'dao/user_dao.dart';

Future<Database> getDatabase() async {
  final String path = join(await getDatabasesPath(), 'sgi.db');
  return openDatabase(
    path,
    onCreate: (db, version) {
      db.execute(UserDao.tableSql);
      db.execute(DepartmentDao.tableSql);
    },
    version: 1,
    //onDowngrade: onDatabaseDowngradeDelete,
  );
}
