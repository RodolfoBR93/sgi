import 'package:sqflite/sqflite.dart';
import 'package:sgi/models/user.dart';
import '../app_database.dart';

class UserDao {
  static const String tableSql = 'CREATE TABLE $_tableName('
      '$_id INTEGER PRIMARY KEY, '
      '$_user TEXT, '
      '$_userProtheus TEXT,'
      '$_acessoGerente TEXT,'
      '$_acessoSuper TEXT,'
      '$_userGdi TEXT,'
      '$_acessoDiretor TEXT,'
      '$_cargoFin TEXT,'
      '$_gerenteFin TEXT,'
      '$_diretorFin TEXT,'
      '$_diretorAdm TEXT,'
      '$_gerenteTI TEXT,'
      '$_comprador TEXT )';

  static const String _tableName = 'user';
  static const String _id = 'id';
  static const String _user = 'user';
  static const String _userProtheus = 'userProtheus';
  static const String _userGdi = 'userGdi';
  static const String _acessoGerente = 'acessoGerente';
  static const String _acessoSuper = 'acessoSuper';
  static const String _acessoDiretor = 'acessoDiretor';
  static const String _cargoFin = 'cargoFin';
  static const String _gerenteFin = 'gerenteFin';
  static const String _diretorFin = 'diretorFin';
  static const String _diretorAdm = 'diretorAdm';
  static const String _gerenteTI = 'gerenteTI';
  static const String _comprador = 'comprador';

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
    userMap[_acessoGerente] = user.acessoGerente;
    userMap[_acessoSuper] = user.acessoSuper;
    userMap[_acessoDiretor] = user.acessoDiretor;
    userMap[_cargoFin] = user.cargoFin;
    userMap[_gerenteFin] = user.gerenteFin;
    userMap[_diretorFin] = user.diretorFin;
    userMap[_diretorAdm] = user.diretorAdm;
    userMap[_gerenteTI] = user.gerenteTI;
    userMap[_comprador] = user.comprador;
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
        row[_acessoGerente],
        row[_acessoSuper],
        row[_acessoDiretor],
        row[_cargoFin],
        row[_gerenteFin],
        row[_diretorFin],
        row[_diretorAdm],
        row[_gerenteTI],
        row[_comprador],
      );
      users.add(user);
    }
    return users;
  }
}
