import 'package:sqflite/sqflite.dart';
import 'package:sgi/models/user.dart';
import '../app_database.dart';

class UserDao {
  static const String tableSql = 'CREATE TABLE $_tableName('
      '$_id INTEGER PRIMARY KEY, '
      '$_user TEXT, '
      '$_userProtheus TEXT,'
      '$_userGdi TEXT)';

  static const String _tableName = 'user';
  static const String _id = 'id';
  static const String _user = 'user';
  static const String _userProtheus = 'userProtheus';
  static const String _userGdi = 'userGdi';

  Future<int> save(User user) async {
    final Database db = await getDatabase();
    Map<String, dynamic> userMap = _toMap(user);
    return db.insert('$_tableName', userMap);
  }

  Future<List<User>> findAll() async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> result = await db.query('$_tableName');
    List<User> user = _toList(result);
    result.first;
    return user;
  }

  Future delete() async {
    final Database db = await getDatabase();
    await db.rawDelete('DELETE FROM $_tableName');
  }

  Map<String, dynamic> _toMap(User user) {
    final Map<String, dynamic> userMap = Map();
    userMap[_user] = user.user;
    userMap[_userProtheus] = user.userProtheus;
    userMap[_userGdi] = user.userGdi;
    return userMap;
  }

  List<User> _toList(List<Map<String, dynamic>> result) {
    final List<User> users = [];
    for (Map<String, dynamic> row in result) {
      final User user = User(
        row[_id],
        row[_user],
        row[_userProtheus],
        row[_userGdi],
      );
      users.add(user);
    }
    return users;
  }
}
