import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:sembast_web/sembast_web.dart';
import 'package:sembast/sembast.dart';
import 'package:sgi/core/uteis.dart';
import 'package:sgi/database/dao/user_dao.dart';
import 'package:sgi/database/dao/user_web._dao.dart';
import 'package:sgi/models/user.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import 'internalDemand_page.dart';

// class Knowledge extends StatelessWidget {
//   static const String routeName = "/gdiKnowledge";

//   @override
//   _KnowledgeState createState() => _KnowledgeState();
// }

class Knowledge extends StatelessWidget /*State<Knowledge>*/ {
  final UserDao _dao = UserDao();
  List _disByDpt = [];
  Map _actualDepartment = new Map();

  Knowledge(Map actualDepartment) {
    this._actualDepartment = actualDepartment;
  }

  Future<List> getInternalDemandsByUser() async {
    var user;
    Response response;
    Dio dio = new Dio();
    EnderecoGdi endereco = new EnderecoGdi();
    if (!kIsWeb) {
      user = await _dao.findAll();

      response = await dio.get(
          "${endereco.getEndereco}department/:dptCod?dptCod=${_actualDepartment["T04_CODIGO"]}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        //_departmentsByUser = response.data.values.toList()[0].values.toList();
        _disByDpt = response.data;

        //return _departmentsByUser;
      }
    } else {
      var store = intMapStoreFactory.store();
      var factory = databaseFactoryWeb;
      var db = await factory.openDatabase('sgi');
      var finder = Finder(filter: Filter.equals('id', 0));
      user = await store.findFirst(db, finder: finder);

      response = await dio.get(
          "${endereco.getEndereco}department/:dptCod?dptCod=${_actualDepartment["T04_CODIGO"]}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        //_departmentsByUser = response.data.values.toList()[0].values.toList();
        _disByDpt = response.data;
      }
    }
    return _disByDpt;
  }

  // void initState() {
  //   getDepartmentsByUser();
  // }

  @override
  Widget build(BuildContext context) {
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
                  future: getInternalDemandsByUser(),
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
                            itemCount: _disByDpt.length,
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
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => InternalDemandWidget(
                  _disByDpt[index]["T09_NUMERO"],
                  _disByDpt[index]["T09_DESTINO"],
                  _actualDepartment["T04_CODIGO"])),
        );
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 1.0),
        child: ListTile(
          title: Text(_disByDpt[index]["T09_NUMERO"] +
              " - " +
              _disByDpt[index]["T08_RELATOR"]),
          focusColor: Colors.grey,
          mouseCursor: MouseCursor.defer,
        ),
      ),
    );
  }

  Future<Null> _refresh() async {
    await Future.delayed(Duration(seconds: 1));
    getInternalDemandsByUser();
    _disByDpt.sort((a, b) {
      if (DateTime.parse(a["T09_DATENV"])
          .isBefore(DateTime.parse(b["T09_DATENV"]))) {
        return 1;
      } else {
        return 0;
      }
    });
    return null;
  }
}
