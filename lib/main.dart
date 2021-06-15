import 'package:flutter/material.dart';
import 'package:sgi/core/app_colors.dart';
import 'package:sgi/login/login_page.dart';

void main() async {
  runApp(new MaterialApp(
    debugShowCheckedModeBanner: false,
//    title: "Bem Vindo",
    home: new Login(),
    theme: ThemeData(
      hintColor: AppColors.lightGrey,
    ),
    // routes: <String, WidgetBuilder>{
    //   // define as rotas
    //   AprovacaoDigital.routeName: (BuildContext context) =>
    //       new AprovacaoDigital(),
    //   Login.routeName: (BuildContext context) => new Login(),
    //   NaoConformidade.routeName: (BuildContext context) =>
    //       new NaoConformidade(),
    //   Cadastro.routeName: (BuildContext context) => new Cadastro(),
    // },
  ));
}
