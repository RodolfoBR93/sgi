import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast_web/sembast_web.dart';
import 'package:sembast/sembast.dart';
import 'package:sgi/core/uteis.dart';
import 'package:sgi/database/dao/department_dao.dart';
import 'package:sgi/database/dao/user_dao.dart';
import 'package:sgi/database/dao/web_database.dart';
import 'package:sgi/gdi/knowledge_page.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:sgi/models/gdi/department.dart';

class DepartmentsByUser extends StatelessWidget /*State<Knowledge>*/ {
  final UserDao _userDao = UserDao();
  final DepartmentDao _deptDao = DepartmentDao();
  List _departmentsByUser = [];
  int _key;

  Future<List> getDepartmentsByUser() async {
    var user;
    var department;
    Response response;
    Dio dio = new Dio();
    EnderecoGdi endereco = new EnderecoGdi();
    if (!kIsWeb) {
      user = await _userDao.findAll();
      department = await _deptDao.findAll();

      if (department.length <= 0) {
        response = await dio.get(
            "${endereco.getEndereco}user/:userCod?userCod=${user[0].getuserGdi.toString()}");

        if (response.statusCode == 200 || response.statusCode == 201) {
          _saveData(response.data.values.toList()[0].values.toList());
          _departmentsByUser = response.data.values.toList()[0].values.toList();
        }
      }
    } else {
      var store = intMapStoreFactory.store();
      var factory = databaseFactoryWeb;
      var db = await factory.openDatabase('sgi');
      var finder = Finder(filter: Filter.equals('id', 0));
      user = await store.findFirst(db, finder: finder);

      _departmentsByUser = [];

      _departmentsByUser = await _loadData();

      if (_departmentsByUser.length <= 0) {
        response = await dio.get(
            "${endereco.getEndereco}user/:userCod?userCod=${user["userGdi"]}");

        if (response.statusCode == 200 || response.statusCode == 201) {
          //int _ret = await _saveData(response.data);
          //debugPrint(_ret.toString());
          _saveData(response.data.values.toList()[0].values.toList());
          _departmentsByUser = response.data.values.toList()[0].values.toList();
        }
      }
    }
    return _departmentsByUser;
  }

  Future<List> _loadData() async {
    var store = intMapStoreFactory.store();
    var factory = databaseFactoryWeb;
    var db = await factory.openDatabase('sgi');
    var dpts;
    Map<String, Map<String, dynamic>> deps = new Map();
    List deptos = [];
    if (_key != null) {
      dpts = await store.record(_key).get(db);
      dpts = dpts.values.toList();
      for (var dpt in dpts) {
        Department depto = new Department(
            dpt["id"],
            dpt["T04_CODIGO"],
            dpt["T04_DESCRICAO"],
            dpt["T04_AVALIA"],
            dpt["T04_ATIVO"],
            dpt["T04_ID_FILIAL"],
            dpt["DEPTO"]);
        deps[dpt["T04_CODIGO"]] = depto.toMap();
      }

      deptos = deps.values.toList();
    }

    return deptos;
  }

  Future<int> _saveData(List dpts) async {
    var store = intMapStoreFactory.store();
    var factory = databaseFactoryWeb;
    var db = await factory.openDatabase('sgi');
    Map<String, Map<String, dynamic>> deps = new Map();
    var record;

    for (var dpt in dpts) {
      Department depto = new Department(
          dpts.indexOf(dpt) + 1,
          dpt["T04_CODIGO"],
          dpt["T04_DESCRICAO"],
          dpt["T04_AVALIA"],
          dpt["T04_ATIVO"],
          dpt["T04_ID_FILIAL"],
          dpt["DEPTO"]);
      deps[dpt["T04_CODIGO"]] = depto.toMap();
    }
    if (_key != null) {
      record = await store.record(_key);
    }

    if (record == null) {
      _key = await store.add(db, deps);
    }
    await db.close();

    return 0;
  }

  @override
  Widget build(BuildContext context) {
    //getDepartmentsByUser();
    return new Scaffold(
      appBar: new AppBar(
        centerTitle: true,
        title: new Text(
          "Ciência de Demandas Internas",
          style: TextStyle(color: Colors.white),
        ),
      ),
      backgroundColor: Colors.white,
      body: new Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: RefreshIndicator(
                child: FutureBuilder<List>(
                  future: getDepartmentsByUser(),
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.none:
                        return Center(
                          child: Text("Nenhum dado carregado!"),
                        );
                      case ConnectionState.waiting:
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      default:
                        if (snapshot.hasError) {
                          return Center(
                            child: Text("Erro ao carregar os dados."),
                          );
                        } else {
                          return ListView.builder(
                            padding: EdgeInsets.only(top: 10.0),
                            itemCount: _departmentsByUser.length,
                            itemBuilder: buildItem,
                          );
                        }
                    }
                  },
                ),
                onRefresh: _refresh,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildItem(context, index) {
    return InkWell(
      onTap: () {
        if (_departmentsByUser[index]["T04_ATIVO"] != "T") {
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Knowledge(_departmentsByUser[index])),
          );
        }
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 1.0),
        child: ListTile(
          title: Text(_departmentsByUser[index]["T04_CODIGO"] +
              " - " +
              _departmentsByUser[index]["T04_DESCRICAO"]),
          enabled: _departmentsByUser[index]["T04_ATIVO"] == "T" ? true : false,
          focusColor: Colors.grey,
          mouseCursor: MouseCursor.defer,
        ),
      ),
    );
  }

  Future<Null> _refresh() async {
    await Future.delayed(Duration(seconds: 1));
    getDepartmentsByUser();
    _departmentsByUser.sort((a, b) {
      if (int.parse(a["T04_CODIGO"]) > int.parse(b["T04_CODIGO"])) {
        return 1;
      } else if (int.parse(a["T04_CODIGO"]) < int.parse(b["T04_CODIGO"])) {
        return -1;
      } else {
        return 0;
      }
    });
    return null;
  }
}
