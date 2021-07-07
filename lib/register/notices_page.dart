import 'package:flutter/material.dart';
import 'package:sgi/core/app_images.dart';
import 'package:sgi/core/core.dart';
import 'package:sgi/database/dao/user_dao.dart';
import 'package:sgi/models/user.dart';

import 'Widgets/app_bar_register_widget.dart';

class Notices extends StatefulWidget {
  Notices();

  @override
  _NoticesState createState() => _NoticesState();
}

class _NoticesState extends State<Notices> {
  final UserDao _dao = UserDao();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  _NoticesState();

  @override
  void initState() {
    _dao.delete();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBarRegisterWidget(),
      body: Container(
          color: Colors.white,
          height: double.infinity,
          width: MediaQuery.of(context).size.width,
          child: ListView(
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                child: Text(
                  "Informações",
                  style: AppTextStyles.body30Black,
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20, 40, 20, 0),
                child: Container(
                  child: Text(
                    "Após o cadastro será enviado um código de verificação para o E-mail e o número de telefone que consta no seu cadastro de funcionário. Este código será solicitado no seu primeiro login.",
                    style: AppTextStyles.body16Blue,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20, 40, 20, 0),
                child: Container(
                  child: Text(
                    "Caso não saiba qual E-mail e telefone está cadastrado, entre em contato com o Departamento pessoal.",
                    style: AppTextStyles.body16Blue,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20, 40, 20, 0),
                child: Container(
                  child: Text(
                    "Caso você possua algum cargo de gestão, o código será enviado para seu número corporativo.",
                    style: AppTextStyles.body16Blue,
                  ),
                ),
              ),
            ],
          )),
    );
  }

  _onWillPop(String _user) {
    final User newUser =
        User(0, _user, '', '', '', '', '', '', '', '', '', '', '');
    _dao.save(newUser);
    Navigator.of(context)
        .pushNamedAndRemoveUntil('/accescode', (Route<dynamic> route) => false);
  }
}
