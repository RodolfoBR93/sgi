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
    if (!kIsWeb) {
      List<User> user = await _dao.findAll();
    } else {
      var factory = databaseFactoryWeb;
      var db = await factory.openDatabase('sgi');
      var finder = Finder(filter: Filter.equals('id', 0));
      // var user = await store.findFirst(db, finder: finder);
    }

    Response response;
    Dio dio = new Dio();
    EnderecoGdi endereco = new EnderecoGdi();

    response = await dio.get(
        "${endereco.getEndereco}getByUser/${user[0].getuserGdi.toString()}");

    _departmentsByUser = response.data["Department"];
    _disByDpt = response.data["InternalDemands"];
  }

  void initState() {
    setState(() {
      getIntDemandsByUser();
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        centerTitle: true,
        title: new Text(
          "Ciência de Demandas Internas",
          style: TextStyle(color: Colors.white),
        ),
      ),
      backgroundColor: Colors.white,
      body: _isLoading
          ? CircularProgressIndicator()
          : new Center(
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
