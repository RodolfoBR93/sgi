import 'package:flutter/material.dart';
import 'package:sgi/core/app_colors.dart';
import 'package:sgi/core/app_text_styles.dart';

class Endereco {
  String endereco =
      'http://192.168.1.241:8088/html-protheus/rest/WEB_ASABRANCA/';
  String enderecoIni = '192.168.1.241:8088';
  String rota = '/html-protheus/rest/WEB_ASABRANCA/';
  String get getEndereco => endereco;
  String get getEnderecoIni => enderecoIni;
  String get getRota => rota;
}

class WidgetsUteis {
  static Future<void> showLoadingDialog(
      BuildContext context, GlobalKey key, String mensagem) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Theme(
            child: new WillPopScope(
                onWillPop: () async => false,
                child: SimpleDialog(
                  key: key,
                  children: <Widget>[
                    Center(
                      child: Column(children: [
                        CircularProgressIndicator(),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          mensagem,
                          style: TextStyle(color: Colors.blueAccent),
                        )
                      ]),
                    )
                  ],
                )),
            data:
                ThemeData(dialogBackgroundColor: Colors.white.withOpacity(1.0)),
          );
        });
  }

  static Future<void> exibeSnackBar(BuildContext context,
      GlobalKey<ScaffoldState> _scaffoldKey, String mensagem, double _width,
      {int duracao}) async {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    duracao = duracao == null ? 2 : duracao;
    var g = _scaffoldKey.currentContext;
    final snackBar = SnackBar(
      content: Text(
        mensagem,
        style: AppTextStyles.titleWhite,
        textAlign: TextAlign.center,
      ),
      duration: Duration(seconds: duracao),
      behavior: SnackBarBehavior.floating,
      width: _width * 90 / 100,
      padding: EdgeInsets.all(15.0),
      backgroundColor: AppColors.blackSnackBar,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);

    // return _scaffoldKey.currentState.showSnackBar(SnackBar(
    //   content: new Text(mensagem),
    //   duration: Duration(seconds: duracao),
    // ));
  }
}
