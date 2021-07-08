import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sgi/approvals/paymentApprovals/payment_approval_page.dart';
import 'package:sgi/core/app_colors.dart';
import 'package:sgi/core/uteis.dart';
import 'package:sgi/database/dao/user_dao.dart';
import 'package:sgi/database/dao/user_web._dao.dart';
import 'package:sgi/gdi/gdi_home_page.dart';
import 'package:sgi/home/widgets/app_bar_home_widget.dart';
import 'package:sgi/models/user.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:sembast_web/sembast_web.dart';
import 'package:sembast/sembast.dart';

class HomePage2 extends StatefulWidget {
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
  HomePage2(
      this._user,
      this._usuProt,
      this._usuGnc,
      this._acessoGerente,
      this._acessoSuper,
      this._acessoDiretor,
      this._cargoFin,
      this._gerenteFin,
      this._diretorFin,
      this._diretorAdm,
      this._gerenteTI,
      this._comprador);
  @override
  HomePage2State createState() => new HomePage2State(
      _user,
      _usuProt,
      _usuGnc,
      _acessoGerente,
      _acessoSuper,
      _acessoDiretor,
      _cargoFin,
      _gerenteFin,
      _diretorFin,
      _diretorAdm,
      _gerenteTI,
      _comprador);
}

class HomePage2State extends State<HomePage2> {
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
  double screenHeight;
  double screenWidth;
  final UserDao _dao = UserDao();
  UserWebDao _userWebDao = UserWebDao();
  String teste;
  HomePage2State(
      this._user,
      this._usuProt,
      this._usuGnc,
      this._acessoGerente,
      this._acessoSuper,
      this._acessoDiretor,
      this._cargoFin,
      this._gerenteFin,
      this._diretorFin,
      this._diretorAdm,
      this._gerenteTI,
      this._comprador);

  @override
  void initState() {
    final User newUser = User(
        0,
        _user,
        _usuProt,
        _usuGnc,
        _acessoGerente,
        _acessoSuper,
        _acessoDiretor,
        _cargoFin,
        _gerenteFin,
        _diretorFin,
        _diretorAdm,
        _gerenteTI,
        _comprador);
    if (!kIsWeb) {
      _dao.save(newUser);
    } else {
      teste = persistWeb(newUser).toString();
    }
    super.initState();
  }

  Future persistWeb(User user) async {
    var store = intMapStoreFactory.store();
    var factory = databaseFactoryWeb;
    var db = await factory.openDatabase('sgi');
    var finder = Finder(filter: Filter.equals('id', 0));
    var record = await store.findFirst(db, finder: finder);
    if(record==null){
      var key = await store.add(db, user.toMap());
      record = await store.findFirst(db, finder: finder);
      print(record);
    }
    
    await db.close();
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
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return new WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
          //appBar: AppBar(),
          appBar: AppBarRegisterWidget(screenHeight, screenWidth),
          backgroundColor: Colors.white,
          body: new Container(
            child: new Center(
              child: new Text("Tela Principal"),
            ),
          ),
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
