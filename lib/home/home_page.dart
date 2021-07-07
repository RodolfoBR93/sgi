import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sgi/approvals/paymentApprovals/payment_approval_page.dart';
import 'package:sgi/core/app_colors.dart';
import 'package:sgi/core/uteis.dart';
import 'package:sgi/database/dao/user_dao.dart';
import 'package:sgi/gdi/gdi_home_page.dart';
import 'package:sgi/models/user.dart';

class HomePage extends StatefulWidget {
  final String _user;
  final String _usuProt;
  final String _usuGnc;
  final String _acessoGerente;
  final String _acessoSuper;
  final String _acessoDiretor;

  final String _cargoFin;
  final String _gerenteFin;
  final String _diretorFin;
  final String _diretorAdm;
  final String _gerenteTI;
  final String _comprador;
  HomePage(this._user, this._usuProt, this._usuGnc,this._acessoGerente,this._acessoSuper,this._acessoDiretor,
  this._cargoFin,this._gerenteFin,this._diretorFin,this._diretorAdm,this._gerenteTI,this._comprador);
  @override
  HomePageState createState() => new HomePageState(_user, _usuProt, _usuGnc,_acessoGerente,_acessoSuper,_acessoDiretor,
  _cargoFin,_gerenteFin,_diretorFin,_diretorAdm,_gerenteTI,_comprador);
}

class HomePageState extends State<HomePage> {
  final String _user;
  final String _usuProt;
  final String _usuGnc;
  final String _acessoGerente;
  final String _acessoSuper;
  final String _acessoDiretor;
  final String _cargoFin;
  final String _gerenteFin;
  final String _diretorFin;
  final String _diretorAdm;
  final String _gerenteTI;
  final String _comprador;
  Endereco endereco = new Endereco();
  String retAprovacao;
  String retGnc;
  final UserDao _dao = UserDao();
  HomePageState(this._user, this._usuProt, this._usuGnc, this._acessoGerente,this._acessoSuper,this._acessoDiretor,
  this._cargoFin,this._gerenteFin,this._diretorFin,this._diretorAdm,this._gerenteTI,this._comprador);

  @override
  void initState() {
    final User newUser = User(0, _user, _usuProt, _usuGnc,_acessoGerente,_acessoSuper,_acessoDiretor,_cargoFin,_gerenteFin,_diretorFin,_diretorAdm,_gerenteTI,_comprador);
    _dao.save(newUser);
    super.initState();
  }

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
      applicationName: "SGI",
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

    if (retAprovacao == 'T') {
      itens.add(getNavItem(
          Icons.assignment, "Aprovação de Títulos", PaymentApproval.routeName));
    }

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
    return new WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
          appBar: new AppBar(
            centerTitle: true,
            title: new Text(
              "Sistema de Gestão Integrada",
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: AppColors.blue,
            flexibleSpace: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: <Color>[
                    Color(0xFF4FACFE),
                    Color(0xFF00F2FE),
                  ],
                ),
              ),
            ),
          ),
          backgroundColor: Colors.white,
          body: new Container(
              child: new Center(
            child: new Text("Tela Principal"),
          )),
          drawer: getNavDrawer(context),
        ));
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

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Você tem certeza?'),
            content: new Text('Você quer fechar aplicativo?'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: new Text('Não'),
              ),
              TextButton(
                onPressed: () => SystemNavigator.pop(),
                child: new Text('Sim'),
              ),
            ],
          ),
        )) ??
        false;
  }
}
