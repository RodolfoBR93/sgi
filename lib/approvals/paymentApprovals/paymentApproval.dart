import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:sgi/approvals/paymentApprovals/Widgets/paymentApprovalWidget.dart';
import 'package:sgi/core/uteis.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'getPayments.dart';

class PaymentApproval extends StatefulWidget {
  static const String routeName = "/paymentapproval";
  @override
  PaymentApprovalState createState() => new PaymentApprovalState();
}

class PaymentApprovalState extends State<PaymentApproval>
    with SingleTickerProviderStateMixin {
  TabController controller;
  Endereco endereco = new Endereco();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String _codigoUsuario = "";
  Future<List> cargos;
  String gerente = "";
  String nomeGer = '';
  String nomeSup = '';
  String nomeDir = '';
  String superi = "";
  String diretor = "";
  String cargoFin = "";
  List empresas;
  String empresaAtual;
  String nomeEmpresaAtual;
  int qtdtabs = 3;
  int itemAtual = 0;
  var tabsWidgets = [];
  List _listaEmpresas = [];

  List<DropdownMenuItem<String>> _menuSuspenso;
  String _itemSelecionado;

  List<DropdownMenuItem<String>> constroiMenuSuspenso(List itens) {
    List<DropdownMenuItem<String>> items = [];
    setState(() {
      for (String item in itens) {
        items.add(DropdownMenuItem(
            value: item,
            child: Text(
              item,
              style: TextStyle(color: Colors.black),
            )));
      }
    });
    return items;
  }

  void mudaItem(String itemSelecionado) {
    setState(() {
      _itemSelecionado = itemSelecionado;
      for (int i = 0; i < empresas.length; i++) {
        if (empresas[i][1] == itemSelecionado) {
          empresaAtual = empresas[i][0];
        }
      }
    });
  }

  Widget dropdownWidget() {
    return DropdownButton(
      value: _itemSelecionado,
      items: _menuSuspenso,
      onChanged: mudaItem,
    );
  }

  @override
  void initState() {
    getAcessos();
    super.initState();
    //controller = new TabController(length: qtdtabs, vsync: this);
  }

  getAcessos() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _codigoUsuario = prefs.getString('usuario');
    getDireitos();
    empresas = await getEmpresas(_codigoUsuario);
    setState(() {
      _codigoUsuario = _codigoUsuario;
      empresas = empresas;
      for (int i = 0; i < empresas.length; i++) {
        _listaEmpresas.add(empresas[i][1]);
      }
      _menuSuspenso = constroiMenuSuspenso(_listaEmpresas);
      _itemSelecionado = _menuSuspenso[0].value;

      int tam = empresas == null ? 0 : empresas.length;
      for (int i = 0; i < tam; i++) {
        if (empresas[i][1] == _itemSelecionado) {
          empresaAtual = empresas[i][0];
          nomeEmpresaAtual = empresaAtual;
        }
      }
    });
  }

  void getDireitos() async {
    List direitos = await getRights(_codigoUsuario);
    setState(() {
      gerente = direitos[0];
      superi = direitos[1];
      diretor = direitos[2];
      cargoFin = direitos[3];
      nomeGer = 'Gerente';
      nomeSup = 'Super.';
      nomeDir = 'Diretor';
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return criaTela(context);
  }

  List<Widget> botoes() {
    if (gerente != "nok" && superi != "nok" && diretor != "nok") {
      setState(() {
        qtdtabs = 3;
        if (controller == null) {
          controller = new TabController(length: qtdtabs, vsync: this);
        }
      });

      return <Widget>[
        new PaymentApprovalWidget(
            _codigoUsuario, empresaAtual, _itemSelecionado, 'G', 'gerente'),
        new PaymentApprovalWidget(
            _codigoUsuario, empresaAtual, _itemSelecionado, 'S', 'super'),
        new PaymentApprovalWidget(
            _codigoUsuario, empresaAtual, _itemSelecionado, 'D', 'diretor')
      ];
    } else if (gerente != "nok" && superi != "nok" && diretor == "nok") {
      setState(() {
        qtdtabs = 2;
        if (controller == null) {
          controller = new TabController(length: qtdtabs, vsync: this);
        }
      });
      return <Widget>[
        new PaymentApprovalWidget(
            _codigoUsuario, empresaAtual, _itemSelecionado, 'G', 'gerente'),
        new PaymentApprovalWidget(
            _codigoUsuario, empresaAtual, _itemSelecionado, 'S', 'super')
      ];
    } else if (gerente != "nok" && superi == "nok" && diretor != "nok") {
      setState(() {
        qtdtabs = 2;
        if (controller == null) {
          controller = new TabController(length: qtdtabs, vsync: this);
        }
      });
      return <Widget>[
        new PaymentApprovalWidget(
            _codigoUsuario, empresaAtual, _itemSelecionado, 'G', 'gerente'),
        new PaymentApprovalWidget(
            _codigoUsuario, empresaAtual, _itemSelecionado, 'D', 'diretor')
      ];
    } else if (gerente == "nok" && superi != "nok" && diretor != "nok") {
      setState(() {
        qtdtabs = 2;
        if (controller == null) {
          controller = new TabController(length: qtdtabs, vsync: this);
        }
      });
      return <Widget>[
        new PaymentApprovalWidget(
            _codigoUsuario, empresaAtual, _itemSelecionado, 'S', 'super'),
        new PaymentApprovalWidget(
            _codigoUsuario, empresaAtual, _itemSelecionado, 'D', 'diretor')
      ];
    } else if (gerente != "nok" && superi == "nok" && diretor == "nok") {
      setState(() {
        qtdtabs = 1;
        if (controller == null) {
          controller = new TabController(length: qtdtabs, vsync: this);
        }
      });
      return <Widget>[
        new PaymentApprovalWidget(
            _codigoUsuario, empresaAtual, _itemSelecionado, 'G', 'gerente')
      ];
    } else if (gerente == "nok" && superi != "nok" && diretor == "nok") {
      setState(() {
        qtdtabs = 1;
        if (controller == null) {
          controller = new TabController(length: qtdtabs, vsync: this);
        }
      });
      return <Widget>[
        new PaymentApprovalWidget(
            _codigoUsuario, empresaAtual, _itemSelecionado, 'S', 'super')
      ];
    } else if (gerente == "nok" && superi == "nok" && diretor != "nok") {
      setState(() {
        qtdtabs = 1;
        if (controller == null) {
          controller = new TabController(length: qtdtabs, vsync: this);
        }
      });
      return <Widget>[
        new PaymentApprovalWidget(
            _codigoUsuario, empresaAtual, _itemSelecionado, 'D', 'diretor')
      ];
    }

    return null;
  }

  List<Tab> tabs() {
    if (gerente != "nok" && superi != "nok" && diretor != "nok") {
      return <Tab>[
        new Tab(
          child: Text(
            nomeGer,
            style: TextStyle(
              fontSize: 18,
              fontFamily: 'Raleway',
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        new Tab(
            child: Text(
          nomeSup,
          style: TextStyle(
            fontSize: 18,
            fontFamily: 'Raleway',
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        )),
        new Tab(
            child: Text(
          nomeDir,
          style: TextStyle(
            fontSize: 18,
            fontFamily: 'Raleway',
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        )),
      ];
    } else if (gerente != "nok" && superi != "nok" && diretor == "nok") {
      return <Tab>[
        new Tab(
            child: Text(
          nomeGer,
          style: TextStyle(
            fontSize: 18,
            fontFamily: 'Raleway',
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        )),
        new Tab(
            child: Text(
          nomeSup,
          style: TextStyle(
            fontSize: 18,
            fontFamily: 'Raleway',
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        )),
      ];
    } else if (gerente != "nok" && superi == "nok" && diretor != "nok") {
      return <Tab>[
        new Tab(
            child: Text(
          nomeGer,
          style: TextStyle(
            fontSize: 18,
            fontFamily: 'Raleway',
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        )),
        new Tab(
            child: Text(
          nomeDir,
          style: TextStyle(
            fontSize: 18,
            fontFamily: 'Raleway',
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        )),
      ];
    } else if (gerente == "nok" && superi != "nok" && diretor != "nok") {
      return <Tab>[
        new Tab(
            child: Text(
          nomeSup,
          style: TextStyle(
            fontSize: 18,
            fontFamily: 'Raleway',
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        )),
        new Tab(
            child: Text(
          nomeDir,
          style: TextStyle(
            fontSize: 18,
            fontFamily: 'Raleway',
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        )),
      ];
    } else if (gerente != "nok" && superi == "nok" && diretor == "nok") {
      return <Tab>[
        new Tab(
            child: Text(
          nomeGer,
          style: TextStyle(
            fontSize: 18,
            fontFamily: 'Raleway',
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        )),
      ];
    } else if (gerente == "nok" && superi != "nok" && diretor == "nok") {
      return <Tab>[
        new Tab(
            child: Text(
          nomeSup,
          style: TextStyle(
            fontSize: 18,
            fontFamily: 'Raleway',
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        )),
      ];
    } else if (gerente == "nok" && superi == "nok" && diretor != "nok") {
      return <Tab>[
        new Tab(
            child: Text(
          nomeDir,
          style: TextStyle(
            fontSize: 18,
            fontFamily: 'Raleway',
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        )),
      ];
    }
    return null;
  }

  Future<List> getEmpresas(String usuario) async {
    List retorno = [];
    try {
      Response response;
      Dio dio = new Dio();
      response = await dio
          .post("${endereco.getEndereco}getempgr", data: {"usuario": usuario});
      if (response.statusCode == 200 || response.statusCode == 201) {
        int quantEmp = response.data["qtdEmp"];
        for (int i = 0; i < quantEmp; i++) {
          retorno.add([
            response.data["empresas"][i]["codigo"],
            response.data["empresas"][i]["nome"]
          ]);
        }
      }
    } catch (e) {
      WidgetsUteis.exibeSnackBar(
          context, _scaffoldKey, "Não foi possível conectar");
      print(e);
    }
    return retorno;
  }

  Widget criaTela(BuildContext context) {
    return _codigoUsuario == '' || (empresaAtual == null || empresaAtual == '')
        ? new Scaffold(
            appBar: new AppBar(
              backgroundColor: Colors.blue,
              title: new Text(
                "Aprovação Digital",
                style: TextStyle(color: Colors.white),
              ),
              actions: <Widget>[
                dropdownWidget(),
              ],
            ),
            body: new Container(
                child: Center(child: CircularProgressIndicator())),
          )
        : nomeEmpresaAtual != empresaAtual
            ? new Scaffold(
                appBar: new AppBar(
                  backgroundColor: Colors.blue,
                  actions: <Widget>[
                    dropdownWidget(),
                  ],
                ),
                body: new Container(
                    child: new Center(
                  child: new Text(mudaEmpresa()),
                )),
              )
            : new Scaffold(
                appBar: new AppBar(
                  backgroundColor: Colors.blue,
                  actions: <Widget>[
                    dropdownWidget(),
                  ],
                ),
                body: new TabBarView(
                  children: botoes(),
                  controller: controller,
                ),
                bottomNavigationBar: new Material(
                  color: Colors.blue,
                  child: new TabBar(
                    tabs: tabs(),
                    controller: controller,
                  ),
                ),
              );
  }

  String mudaEmpresa() {
    atutab();

    return '';
  }

  atutab() async {
    await new Future.delayed(const Duration(seconds: 2));

    setState(() {
      nomeEmpresaAtual = empresaAtual;
    });
  }
}
