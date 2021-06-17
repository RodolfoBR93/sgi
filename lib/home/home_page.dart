import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:sgi/core/uteis.dart';
import 'package:sgi/gdi/gdi_home.dart';

class TelaPrincipal extends StatefulWidget {
  final String _usuProt;
  final String _usuGnc;
  TelaPrincipal(this._usuProt, this._usuGnc);
  @override
  TelaPrincipalState createState() => new TelaPrincipalState(_usuProt, _usuGnc);
}

class TelaPrincipalState extends State<TelaPrincipal> {
  final String _usuProt;
  final String _usuGnc;
  Endereco endereco = new Endereco();
  String retAprovacao;
  String retGnc;
  TelaPrincipalState(this._usuProt, this._usuGnc);

  void acesso(int id) async {
    if (id == 1) {
      String retornoProt = await acessoAprovacao(_usuProt);
      setState(() {
        retAprovacao = retornoProt;
      });
    } else if (id == 2) {
      String retornoGnc = await acessoGnc(_usuGnc);
      setState(() {
        retGnc = retornoGnc;
      });
    }
  }

  Drawer getNavDrawer(BuildContext context) {
    var cabecalho = new DrawerHeader(
      child: new Text("Menu"),
    );
    List<StatelessWidget> itens = [];
    var sobre = new AboutListTile(
      child: new Text("Sobre"),
      applicationName: "CSC Digital",
      applicationVersion: "v2.0.0",
      applicationIcon: new Icon(Icons.adb),
      icon: new Icon(Icons.info),
    );

    ListTile getNavItem(var icon, String s, String routeName) {
      return new ListTile(
        leading: new Icon(icon),
        title: new Text(s),
        onTap: () {
          setState(() {
            Navigator.of(context).pop();
            Navigator.of(context).pushNamed(routeName);
          });
        },
      );
    }

    itens.add(cabecalho);
    if (retAprovacao == null) {
      acesso(1);
    }
    if (retGnc == null) {
      acesso(2);
    }

    // if (retAprovacao == 'T') {
    //   itens.add(getNavItem(
    //       Icons.assignment, "Aprovação Digital", AprovacaoDigital.routeName));
    // }

    if (retGnc == 'T') {
      itens.add(getNavItem(Icons.message, "Não Conformidades", Gdi.routeName));
    }

    //itens.add(getNavItem(Icons.autorenew, "Sincronizar", Cadastro.routeName));
    itens.add(sobre);

    ListView listaItens = new ListView(children: itens);

    return new Drawer(
      child: listaItens,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(
          "Sistema de Gestão Integrada",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: new Container(
          child: new Center(
        child: new Text("Tela Principal"),
      )),
      drawer: getNavDrawer(context),
    );
  }

  Future<String> acessoAprovacao(String usuario) async {
    try {
      Response response;
      Dio dio = new Dio();
      response = await dio.post("${endereco.getEndereco}acessoaprovacao",
          data: {"usuario": usuario});
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data["status"];
      } else {
        return 'F';
      }
    } catch (e) {
      print(e);
      return 'F';
    }
  }

  Future<String> acessoGnc(String usuario) async {
    try {
      Response response;
      Dio dio = new Dio();
      response = await dio.post("${endereco.getEndereco}autenticagnc",
          data: {"usuario": usuario});
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data["status"];
      } else {
        return 'F';
      }
    } catch (e) {
      print(e);
      return 'F';
    }
  }
}
