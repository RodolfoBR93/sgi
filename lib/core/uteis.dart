import 'package:flutter/material.dart';

class Endereco {
  //String endereco = 'http://10.0.2.2:8084/html-protheus/rest/WEB_ASABRANCA/';
  //String endereco = 'http://192.168.1.106:8084/html-protheus/rest/WEB_ASABRANCA/';
  //String endereco = 'http://10.0.0.101:8084/html-protheus/rest/WEB_ASABRANCA/';
  String endereco =
      'http://192.168.0.254:8084/html-protheus/rest/WEB_ASABRANCA/';
  String enderecoIni = '192.168.0.254:8084';
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
      GlobalKey<ScaffoldState> _scaffoldKey, String mensagem,
      {int duracao}) async {
    duracao = duracao == null ? 2 : duracao;
    return _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: new Text(mensagem),
      duration: Duration(seconds: duracao),
    ));
  }
}
