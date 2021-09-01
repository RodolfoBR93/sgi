import 'package:sgi/models/gdi/department.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sgi/models/user.dart';
import '../app_database.dart';

class DepartmentDao {
  static const String tableSql = 'CREATE TABLE $_tableName('
      '$_id INTEGER PRIMARY KEY, '
      '$_department TEXT, '
      '$_description TEXT,'
      '$_idFilial TEXT,'
      '$_depto TEXT,'
      '$_active TEXT,';

  static const String _tableName = 'department';
  static const String _id = 'id';
  static const String _department = 'department';
  static const String _description = 'description';
  static const String _active = 'active';
  static const String _idFilial = 'idFilial';
  static const String _depto = '_Depto';

  Future<int> save(Department department) async {
    final Database db = await getDatabase();
    Map<String, dynamic> departmentMap = _toMap(department);
    return db.insert('$_tableName', departmentMap);
  }

  Future<List<Department>> findAll() async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> result = await db.query('$_tableName');
    List<Department> department = _toList(result);
    result.first;
    return department;
  }

  Future delete() async {
    final Database db = await getDatabase();
    await db.rawDelete('DELETE FROM $_tableName');
  }

  Map<String, dynamic> _toMap(Department department) {
    final Map<String, dynamic> departmentMap = Map();
    departmentMap[_department] = department.department;
    departmentMap[_description] = department.description;
    departmentMap[_active] = department.active;
    departmentMap[_idFilial] = department.idFilial;
    departmentMap[_depto] = department.depto;
    return departmentMap;
  }

  List<Department> _toList(List<Map<String, dynamic>> result) {
    final List<Department> departments = [];
    for (Map<String, dynamic> row in result) {
      final Department department = Department(
        row[_id],
        row[_department],
        row[_description],
        row[_active],
        row[_idFilial],
        row[_depto],
      );
      departments.add(department);
    }
    return departments;
  }
}
