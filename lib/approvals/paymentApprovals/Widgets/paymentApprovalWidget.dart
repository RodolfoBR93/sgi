import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'dart:async';
import 'package:dio/dio.dart';
import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:sgi/core/uteis.dart';

import '../ViewAttachment.dart';
import '../detailedPayment.dart';
import '../getPayments.dart';

class PaymentApprovalWidget extends StatefulWidget {
  final String _user;
  final String _company;
  final String _nameCompany;
  final String _occupation;
  final String _occupationAcronym;
  PaymentApprovalWidget(this._user, this._company, this._nameCompany,
      this._occupation, this._occupationAcronym);
  @override
  PaymentApprovalWidgetState createState() => new PaymentApprovalWidgetState(
      _user, _company, _nameCompany, _occupation, _occupationAcronym);
}

class PaymentApprovalWidgetState extends State<PaymentApprovalWidget> {
  final String _user;
  final String _company;
  final String _nameCompany;
  final String _occupation;
  final String _occupationAcronym;
  PaymentApprovalWidgetState(this._user, this._company, this._nameCompany,
      this._occupation, this._occupationAcronym);
  List _titulos = [];
  List _dadosAdc = [];
  List retorno = [];
  List _retorno = [];
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _motivoRejeicao = new TextEditingController();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Endereco endereco = new Endereco();
  bool pdfAtivo = false;
  String path;
  PDFDocument document;
  bool _isLoading = true;
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();

  @override
  void initState() {
    buscaTitulos();
  }

  void buscaTitulos() async {
    retorno = await getPayments(
        _user, _occupationAcronym, _occupation, "1", _company);
    if (this.mounted) {
      setState(() {
        _titulos = retorno[0];
        _dadosAdc = retorno[1];
        if (_dadosAdc.length == 0) {
          _dadosAdc.add("nok");
        }
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return (_titulos.length == 0 && _dadosAdc.length > 0) || _isLoading
        ? Scaffold(
            body: new Container(
                child: new Center(
              child: _isLoading
                  ? CircularProgressIndicator()
                  : new Text("Não há títulos para aprovação"),
            )),
          )
        : Scaffold(
            key: _formKey,
            body: Column(
              children: <Widget>[
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.only(top: 10.0),
                    itemCount: _titulos.length,
                    itemBuilder: buildItem,
                  ),
                ),
              ],
            ),
          );
  }

  Widget buildItem(BuildContext context, int index) {
    return new Slidable(
      actionPane: new SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      child: new Container(
          color: Colors.white,
          child: Card(
              color: _titulos[index][4] == 'impostos'
                  ? Colors.yellow[100]
                  : Colors.white,
              child: ListTile(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => new DetailedPayment(
                          [_nameCompany, index, _titulos, _dadosAdc])));
                },
                title: Text(
                  _titulos[index][1],
                ),
                subtitle: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Expanded(
                          flex: 3,
                          child: Container(
                            child: Text(
                              "Título: " +
                                  _dadosAdc[index][0] +
                                  " " +
                                  _dadosAdc[index][1] +
                                  " " +
                                  _dadosAdc[index][2] +
                                  " " +
                                  _dadosAdc[index][3],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Container(
                            child: Text(
                              "Valor: " + _dadosAdc[index][4],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                        width: double.infinity,
                        child: Text(
                          "Vencimento: " + _dadosAdc[index][5],
                        )),
                  ],
                ),
              ))),
      actions: <Widget>[
        new IconSlideAction(
          caption: 'Aprovar',
          color: Colors.green,
          icon: Icons.check,
          onTap: () => _Aprovacao(context, index, "Título Aprovado"),
        ),
        new IconSlideAction(
          caption: 'Anexos',
          color: Colors.indigo,
          icon: Icons.attach_file,
          onTap: () => visualizarAnexo(context, index),
        ),
      ],
      secondaryActions: <Widget>[
        new IconSlideAction(
            caption: 'Rejeitar',
            color: Colors.red,
            icon: Icons.delete,
            onTap: () {
              reasonRejection(context, index, "Título Rejeitado", _formKey,
                  _motivoRejeicao);
              Scaffold.of(context).showSnackBar(SnackBar(
                content: new Text('Título Rejeitado'),
                duration: Duration(seconds: 1),
              ));
            }),
      ],
    );
  }

  void visualizarAnexo(BuildContext context, int index) async {
    WidgetsUteis.showLoadingDialog(context, _keyLoader, "Baixando anexos...");
    _retorno = await _BuscaAnexos("${_titulos[index][0]}", _company);
    Navigator.of(context).pop();
    selecionaAnexo(context, index, _formKey, _retorno);
  }

  Future selecionaAnexo(BuildContext context, int index,
      GlobalKey<FormState> _formKey, List anexos) {
    int recno = index;

    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return new WillPopScope(
              onWillPop: () {},
              child: AlertDialog(
                title: Text('Anexos', style: TextStyle(fontSize: 16.9)),
                content: Container(
                  //color: Colors.grey,
                  width: double.maxFinite,
                  height: 300.0,
                  child: ListView.builder(
                    padding: EdgeInsets.only(top: 10.0),
                    itemCount: anexos.length,
                    itemBuilder: (context, index) {
                      return Card(
                        color: Colors.white70,
                        child: ListTile(
                          //leading: Icon(Icons.attach_file),
                          trailing: Icon(Icons.keyboard_arrow_right),
                          title: Text(anexos[index]),
                          onTap: () => buscaAnexo(
                              "${_titulos[recno][0]}", _company, anexos[index]),
                        ),
                      );
                    },
                  ),
                ),
                actions: <Widget>[
                  FlatButton(
                    child: Text("Fechar"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  )
                ],
              ));
        });
  }

  void _Aprovacao(BuildContext context, int index, String mensagem) async {
    WidgetsUteis.showLoadingDialog(
        context, _keyLoader, "Concluindo aprovação...");
    List _retAnexos = await _BuscaAnexos("${_titulos[index][0]}", _company);

    if (_retAnexos.length > 0) {
      _retorno = await _AprovaTitulo(
          "${_titulos[index][0]}", _user, _occupationAcronym, _company);
      setState(() {
        _titulos.removeAt(index);
        _dadosAdc.removeAt(index);
      });
    }
    Navigator.of(context).pop();
    Scaffold.of(context).showSnackBar(SnackBar(
      content: new Text(mensagem),
      duration: Duration(seconds: 1),
    ));
  }

  void _Rejeicao(
      int index, String mensagem, String motivo, BuildContext context) async {
    _retorno = await _RejeitaTitulo(
        "${_titulos[index][0]}", _user, _occupationAcronym, _company, motivo);
    Navigator.of(context).pop();
    setState(() {
      _titulos.removeAt(index);
      _dadosAdc.removeAt(index);
    });
  }

  Future reasonRejection(BuildContext context, int index, String mensagem,
      GlobalKey<FormState> _formKey, TextEditingController motivo_rejeicao) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Título Rejeitado', style: TextStyle(fontSize: 16.9)),
            content: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: motivo_rejeicao,
                      decoration: InputDecoration(
                          labelText: 'Informe o motivo da rejeição',
                          hintStyle:
                              TextStyle(fontSize: 16.9, color: Colors.blue)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      child: Text("Enviar"),
                      onPressed: () {
                        if (motivo_rejeicao.text != "") {
                          if (_formKey.currentState.validate()) {
                            _formKey.currentState.save();
                            Navigator.of(context).pop();
                            WidgetsUteis.showLoadingDialog(
                                context, _keyLoader, "Concluindo rejeição...");
                            _Rejeicao(index, mensagem, motivo_rejeicao.text,
                                _scaffoldKey.currentContext);
                            motivo_rejeicao.text = "";
                          }
                        }
                      },
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  buscaAnexo(String recno, String empresa, String anexo) async {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) => new ViewAttachment(
            '${endereco.getEndereco}getanexo?empresa=$empresa&anexo=$anexo&arecno=$recno')));
  }

  Future<List> _AprovaTitulo(
      String _recno, String _usuario, String _autcomo, String empresa) async {
    Response response;
    Dio dio = new Dio();
    List dados = []; //_empresa, _recno, usuario, autcomo
    try {
      response = await dio.post("${endereco.getEndereco}aprovacao", data: {
        "empresa": empresa,
        "arecno": _recno,
        "usuario": _usuario,
        "autocomo": _autcomo
      });
      if (response.statusCode == 200 || response.statusCode == 201) {
        print(response.data);
        dados.add("ok");
        return dados;
      } else {
        WidgetsUteis.exibeSnackBar(
            context, _scaffoldKey, "Não foi possível conectar");
      }
    } catch (e) {
      WidgetsUteis.exibeSnackBar(
          context, _scaffoldKey, "Não foi possível conectar");
      print(e);
    }
  }

  Future<List> _RejeitaTitulo(String _recno, String usuario, String _autcomo,
      String empresa, String motivo) async {
    Response response;
    Dio dio = new Dio();
    List dados = new List(); //_empresa, _recno, usuario, autcomo
    try {
      response = await dio.post("${endereco.getEndereco}rejeicao", data: {
        "empresa": empresa,
        "arecno": _recno,
        "usuario": usuario,
        "autocomo": _autcomo,
        "motivo": motivo
      });
      if (response.statusCode == 200 || response.statusCode == 201) {
        dados.add("ok");
        return dados;
      } else {
        WidgetsUteis.exibeSnackBar(
            context, _scaffoldKey, "Não foi possível conectar");
      }
    } catch (e) {
      WidgetsUteis.exibeSnackBar(
          context, _scaffoldKey, "Não foi possível conectar");
      print(e);
    }
  }

  Future<List> _BuscaAnexos(String _arecno, String _empresa) async {
    int nQtdAnexos = 0;
    String anexos = "";
    try {
      Response response;
      Dio dio = new Dio();
      List dados = []; //_empresa, _recno, usuario, autcomo
      response = await dio.post("${endereco.getEndereco}anexos",
          data: {"empresa": _empresa, "arecno": _arecno});
      if (response.statusCode == 200 || response.statusCode == 201) {
        print(response.data);
        nQtdAnexos = response.data["qtdanexos"];
        for (int i = 0; i < nQtdAnexos; i++) {
          anexos = response.data["anexos"][i]["anexos${i + 1}"];
          //anexos = anexos.substring(31, anexos.length);
          dados.add(anexos);
        }
        if (dados.length == 0) {
          final snackBar =
              SnackBar(content: Text('Não existe documento anexado!'));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
        return dados;
      } else {
        WidgetsUteis.exibeSnackBar(
            context, _scaffoldKey, "Não foi possível conectar");
      }
      return dados;
    } catch (e) {
      WidgetsUteis.exibeSnackBar(
          context, _scaffoldKey, "Não foi possível conectar");
      print(e);
    }
  }
}
