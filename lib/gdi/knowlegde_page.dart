import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:sgi/core/uteis.dart';
import 'package:sgi/database/dao/user_dao.dart';
import 'package:sgi/database/dao/user_web._dao.dart';
import 'package:sgi/models/user.dart';

class Knowledge extends StatefulWidget {
  static const String routeName = "/gdiKnowledge";

  @override
  _KnowledgeState createState() => _KnowledgeState();
}

class _KnowledgeState extends State<Knowledge> {
  final UserDao _dao = UserDao();
  UserWebDao _userWebDao = UserWebDao();
  List _departmentsByUser;

  void getIntDemandsByUser() async {
    List<User> user = await _dao.findAll();
    Response response;
    Dio dio = new Dio();
    EnderecoGdi endereco = new EnderecoGdi();

    response = await dio.get(
        "${endereco.getEndereco}getByUser/${user[0].getuserGdi.toString()}");
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
      body: new Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: RefreshIndicator(
                child: ListView.builder(
                  padding: EdgeInsets.only(top: 10.0),
                  itemCount: _departmentsByUser.length,
                  itemBuilder: buildDept,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

Widget buildDept(context, index) {
  return Expanded(
    child: InkWell(
      onTap: () {},
      child: Padding(
          padding: EdgeInsets.symmetric(vertical: 12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              CircleAvatar(),
            ],
          )),
    ),
  );
}
