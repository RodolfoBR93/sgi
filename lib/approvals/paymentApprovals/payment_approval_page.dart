import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:sgi/approvals/paymentApprovals/Widgets/paymentApprovalWidget.dart';
import 'package:sgi/core/app_colors.dart';
import 'package:sgi/core/uteis.dart';
import 'package:sgi/database/dao/user_dao.dart';
import 'package:sgi/models/user.dart';

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
  final UserDao _dao = UserDao();
  String _itemSelecionado;
  double screenWidth;

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

  @override
  void initState() {
    getDireitos();
    super.initState();
  }

  void getDireitos() async {
    List<User> user = await _dao.findAll();
    //List direitos = await getRights(user[0].getuserProtheus.toString());
    empresas = await getEmpresas(user[0].getuserProtheus.toString());
    setState(() {
      gerente = user[0].getacessoGerente.toString() == '' ? 'nok' : user[0].getacessoGerente.toString();
      superi = user[0].getacessoSuper.toString() == '' ? 'nok' : user[0].getacessoSuper.toString();
      diretor = user[0].getacessoDiretor.toString() == '' ? 'nok' : user[0].getacessoDiretor.toString();
      cargoFin = user[0].getCargoFin.toString() == '' ? 'nok' : user[0].getCargoFin.toString();
      nomeGer = 'Gerente';
      nomeSup = 'Super.';
      nomeDir = 'Diretor';
      _codigoUsuario = user[0].getuserProtheus.toString();
      for (int i = 0; i < empresas.length; i++) {
        _listaEmpresas.add(empresas[i][1]);
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
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
            _codigoUsuario, empresas, 'G', 'gerente', 'Gerente'),
        new PaymentApprovalWidget(
            _codigoUsuario, empresas, 'S', 'super', 'Superintendente'),
        new PaymentApprovalWidget(
            _codigoUsuario, empresas, 'D', 'diretor', 'Diretoria'),
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
            _codigoUsuario, empresas, 'G', 'gerente', 'Gerente'),
        new PaymentApprovalWidget(
            _codigoUsuario, empresas, 'S', 'super', 'Superintendente')
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
            _codigoUsuario, empresas, 'G', 'gerente', 'Gerente'),
        new PaymentApprovalWidget(
            _codigoUsuario, empresas, 'D', 'diretor', 'Diretoria')
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
            _codigoUsuario, empresas, 'S', 'super', 'Superintendente'),
        new PaymentApprovalWidget(
            _codigoUsuario, empresas, 'D', 'diretor', 'Diretoria')
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
            _codigoUsuario, empresas, 'G', 'gerente', 'Gerente')
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
            _codigoUsuario, empresas, 'S', 'super', 'Superintendente')
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
            _codigoUsuario, empresas, 'D', 'diretor', 'Diretoria')
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
          context, _scaffoldKey, "Não foi possível conectar", screenWidth);
      print(e);
    }
    return retorno;
  }

  Widget criaTela(BuildContext context) {
    return _codigoUsuario == ''
        ? new Scaffold(
            appBar: new AppBar(
              centerTitle: true,
              backgroundColor: AppColors.blue,
              title: new Text(
                "Aprovação de Títulos",
                style: TextStyle(color: Colors.white), textAlign: TextAlign.center,
              ),
              // actions: <Widget>[
              //   dropdownWidget(),
              // ],
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
            body: new Container(
                child: Center(child: CircularProgressIndicator())),
          )
        : new Scaffold(
            appBar: new AppBar(
              backgroundColor: AppColors.blue,
              centerTitle: true,
              title: new Text(
                "Aprovação de Títulos",
                style: TextStyle(color: Colors.white), textAlign: TextAlign.center,
              ),
              // actions: <Widget>[
              //   dropdownWidget(),
              // ],
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
            body: new TabBarView(
              children: botoes(),
              controller: controller,
            ),
            bottomNavigationBar: new Material(
              color: Color(0xFF1890FF),
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
