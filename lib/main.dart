import 'package:flutter/material.dart';
import 'package:sgi/core/app_colors.dart';
import 'package:sgi/gdi/gdi_home.dart';
import 'package:sgi/login/login_page.dart';

import 'approvals/paymentApprovals/paymentApproval.dart';
import 'register/register_page.dart';

void main() async {
  runApp(new MaterialApp(
    debugShowCheckedModeBanner: false,
//    title: "Bem Vindo",
    home: new Login(),
    theme: ThemeData(
      hintColor: AppColors.lightGrey,
    ),
    routes: <String, WidgetBuilder>{
      // define as rotas
      PaymentApproval.routeName: (context) => PaymentApproval(),
      Login.routeName: (BuildContext context) => new Login(),
      Gdi.routeName: (BuildContext context) => new Gdi(),
      Register.routeName: (BuildContext context) => new Register(),
    },
  ));
}
