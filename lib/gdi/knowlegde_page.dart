import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:sembast_web/sembast_web.dart';
import 'package:sembast/sembast.dart';
import 'package:sgi/core/uteis.dart';
import 'package:sgi/database/dao/user_dao.dart';
import 'package:sgi/database/dao/user_web._dao.dart';
import 'package:sgi/models/user.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class Knowledge extends StatefulWidget {
  static const String routeName = "/gdiKnowledge";

  @override
  _KnowledgeState createState() => _KnowledgeState();
}

class _KnowledgeState extends State<Knowledge> {
  final UserDao _dao = UserDao();
  UserWebDao _userWebDao = UserWebDao();
  bool _isLoading = true;
  List _departmentsByUser = [];
  List _disByDpt = [];

  void getIntDemandsByUser() async {
    var user;
    Response response;
    Dio dio = new Dio();
    EnderecoGdi endereco = new EnderecoGdi();
    if (!kIsWeb) {
      user = await _dao.findAll();

      response = await dio.get(
          "${endereco.getEndereco}getByUser/${user[0].getuserGdi.toString()}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        for (Map dpt in response.data["Department"]) {
          _departmentsByUser.add(dpt);
        }
        for (var intDemand in response.data["InternalDemands"]) {
          _disByDpt.add(intDemand);
        }
        // _departmentsByUser = response.data["Department"];
        // _disByDpt = response.data["InternalDemands"];
      }
    } else {
      var store = intMapStoreFactory.store();
      var factory = databaseFactoryWeb;
      var db = await factory.openDatabase('sgi');
      var finder = Finder(filter: Filter.equals('id', 0));
      user = await store.findFirst(db, finder: finder);

      response =
          await dio.get("${endereco.getEndereco}getByUser/${user["userGdi"]}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        _departmentsByUser = response.data["Department"];
        _disByDpt = response.data["InternalDemands"];
      }
    }
  }

  void initState() {
    setState(() {
      getIntDemandsByUser();
      if (_departmentsByUser.length > 0 && _disByDpt.length > 0) {
        _isLoading = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? new Scaffold(
            appBar: new AppBar(
              centerTitle: true,
              title: new Text(
                "Ciência de Demandas Internas",
                style: TextStyle(color: Colors.white),
              ),
            ),
            backgroundColor: Colors.white,
            body: Center(
              child: CircularProgressIndicator(),
            ))
        : new Scaffold(
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
                      child: ListView.builder(
                        padding: EdgeInsets.only(top: 10.0),
                        itemCount: _departmentsByUser.length,
                        itemBuilder: buildItem,
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
    return Expanded(
      child: InkWell(
        onTap: () {},
        child: Padding(
            padding: EdgeInsets.symmetric(vertical: 12.0),
            child: ListTile(
              title: Text(_departmentsByUser[index]["T04_DESCRICAO"]),
              focusColor: Colors.grey,
              mouseCursor: MouseCursor.defer,
            )),
      ),
    );
  }

  Future<Null> _refresh() async {
    await Future.delayed(Duration(seconds: 1));
    setState(() {
      _departmentsByUser.sort();
    });
    return null;
  }
}
