import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:expandable/expandable.dart';
import 'dart:async';
import 'package:dio/dio.dart';
import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:sgi/core/app_colors.dart';
import 'package:sgi/core/app_images.dart';
import 'package:sgi/core/app_text_styles.dart';
import 'package:sgi/core/uteis.dart';

import '../detailed_payment_page.dart';
import '../getPayments.dart';
import '../view_attachment_page.dart';

class PaymentApprovalWidget extends StatefulWidget {
  final String _user;
  final List _companies;
  final String _occupation;
  final String _occupationT;
  final String _occupationAcronym;
  PaymentApprovalWidget(this._user, this._companies, this._occupationAcronym,
      this._occupation, this._occupationT);
  @override
  PaymentApprovalWidgetState createState() => new PaymentApprovalWidgetState(
      _user, _companies, _occupationAcronym, _occupation, _occupationT);
}

class PaymentApprovalWidgetState extends State<PaymentApprovalWidget> {
  final String _user;
  final List _companies;
  final String _occupation;
  final String _occupationT;
  final String _occupationAcronym;
  PaymentApprovalWidgetState(this._user, this._companies,
      this._occupationAcronym, this._occupation, this._occupationT);
  List _titulos = [];
  List _dadosAdc = [];
  List _impostos = [];
  List retorno = [];
  List _retorno = [];
  final _formKey = GlobalKey<FormState>();
  final _formKeyApr = GlobalKey<FormState>();
  final TextEditingController _motivoRejeicao = new TextEditingController();
  final TextEditingController _diForaDoPrazo = new TextEditingController();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Endereco endereco = new Endereco();
  bool pdfAtivo = false;
  String path;
  PDFDocument document;
  bool _isLoading = true;
  String _companyName;
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  double screenWidth;

  @override
  void initState() {
    buscaTitulos();
  }

  void buscaTitulos() async {
    retorno = await getPayments(
        _user, _occupation, _occupationAcronym, "1", _companies);
    if (this.mounted) {
      setState(() {
        _titulos = retorno[0];
        _dadosAdc = retorno[1];
        _impostos = retorno[2];
        if (_dadosAdc.length == 0) {
          _dadosAdc.add("nok");
        }
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
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
            backgroundColor: AppColors.white,
            key: _scaffoldKey,
            body: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(_occupationT, style: AppTextStyles.title15Black),
                ),
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.only(top: 10.0, left: 8.0, right: 8.0),
                    itemCount: _titulos.length,
                    itemBuilder: buildItem,
                  ),
                ),
              ],
            ),
          );
  }

  void waitApproval(
      BuildContext context, _companyName, index, _titulos, _dadosAdc) async {
    final result = await Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) => new DetailedPayment(
            [_companyName, index, _titulos, _dadosAdc, _occupationT,_impostos])));

    if (result != null) {
      if (result == '1') {
        await _Aprovacao(context, index, "Título Aprovado");
      } else if (result == '0') {
        reasonRejection(
            context, index, "Título Rejeitado", _formKey, _motivoRejeicao);
      }
    }
  }

  Widget buildItem(BuildContext context, int index) {
    return new Slidable(
      actionPane: new SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      child: new Container(
          color: AppColors.white,
          child: Card(
              elevation: 3.0,
              color: _titulos[index][4] == 'impostos'
                  ? Colors.yellow[100]
                  : Colors.white,
              child: ListTile(
                onTap: () {
                  for (int i = 0; i < _companies.length; i++) {
                    if (_companies[i][0] == _titulos[index][5]) {
                      _companyName = _companies[i][1];
                      break;
                    }
                  }
                  waitApproval(
                      context, _companyName, index, _titulos, _dadosAdc);
                },
                title:
                    Text(_titulos[index][1], style: AppTextStyles.title15Black),
                trailing: GestureDetector(
                  onTap: () {
                    WidgetsUteis.exibeSnackBar(context, _scaffoldKey,
                        _dadosAdc[index][34], screenWidth);
                  },
                  child: Container(
                    color: _titulos[index][4] == 'impostos' ? Colors.yellow[100] : Colors.white,
                    height: 50,
                    width: 50,
                    child: getInfo(
                      _dadosAdc[index][33],
                    ),
                  ),
                ),
                leading: CircleAvatar(
                    backgroundImage:
                        AssetImage(AppImages.getImage(_titulos[index][5]))),
                subtitle: Column(
                  children: <Widget>[
                    Container(
                      width: double.infinity,
                      child: Text(
                        "Título: " +
                            _dadosAdc[index][0] +
                            " " +
                            _dadosAdc[index][1] +
                            " " +
                            _dadosAdc[index][2] +
                            " " +
                            _dadosAdc[index][3],
                        style: AppTextStyles.title13Grey,
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      child: Text(
                        "Valor: " + _dadosAdc[index][4],
                        style: AppTextStyles.title13Grey,
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      child: Text.rich(TextSpan(
                          text: "Vencimento: ",
                          style: AppTextStyles.title13Grey,
                          children: [
                            TextSpan(
                              text: _dadosAdc[index][5],
                              style: _dadosAdc[index][35] < 0
                                  ? AppTextStyles.title13Red
                                  : AppTextStyles.title13Green,
                            )
                          ])),
                    ),
                  ],
                ),
              ))),
      actions: <Widget>[
        new IconSlideAction(
          caption: 'Aprovar',
          color: Colors.green,
          icon: Icons.check,
          onTap: () async =>
              await _Aprovacao(context, index, "Título Aprovado"),
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
            }),
      ],
    );
  }

  void visualizarAnexo(BuildContext context, int index) async {
    WidgetsUteis.showLoadingDialog(context, _keyLoader, "Baixando anexos...");
    _retorno =
        await _BuscaAnexos("${_titulos[index][0]}", "${_titulos[index][5]}");
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
                          onTap: () => buscaAnexo("${_titulos[recno][0]}",
                              "${_titulos[recno][5]}", anexos[index]),
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
    List _retAnexos =
        await _BuscaAnexos("${_titulos[index][0]}", "${_titulos[index][5]}");

    if (_retAnexos.length > 0) {
      if (_dadosAdc[index][35] < 0) {
        Navigator.of(context).pop();
        await autorizationDI(context, index, _formKeyApr, _diForaDoPrazo);
      } else {
        Navigator.of(context).pop();
        WidgetsUteis.showLoadingDialog(
            context, _keyLoader, "Concluindo aprovação...");
        _retorno = await _AprovaTitulo("${_titulos[index][0]}", _user,
            _occupationAcronym, "${_titulos[index][5]}");

        setState(() {
          _titulos.removeAt(index);
          _dadosAdc.removeAt(index);
          if (_titulos.isEmpty) {
            _isLoading = true;
            buscaTitulos();
          }
        });
        Navigator.of(context).pop();
        Scaffold.of(context).showSnackBar(SnackBar(
          content: new Text(mensagem),
          duration: Duration(seconds: 1),
        ));
      }
    } else {
      mensagem = 'Título não possui anexo!';
      Navigator.of(context).pop();
      Scaffold.of(context).showSnackBar(SnackBar(
        content: new Text(mensagem),
        duration: Duration(seconds: 1),
      ));
    }
    //_retorno[0] == 1
  }

  void _Rejeicao(
      int index, String mensagem, String motivo, BuildContext context) async {
    WidgetsUteis.showLoadingDialog(
        context, _keyLoader, "Concluindo rejeição...");

    _retorno = await _RejeitaTitulo("${_titulos[index][0]}", _user,
        _occupationAcronym, "${_titulos[index][5]}", motivo);
    Navigator.of(context).pop();
    setState(() {
      _titulos.removeAt(index);
      _dadosAdc.removeAt(index);
      if (_titulos.isEmpty) {
        _isLoading = true;
        buscaTitulos();
      }
    });
    WidgetsUteis.exibeSnackBar(
        context, _scaffoldKey, "Título rejeitado!", screenWidth);
  }

  Future<List> _DiAutorizacao(
      int index, String numeroDI, BuildContext context) async {
    WidgetsUteis.showLoadingDialog(context, _keyLoader, "aguarde...");
    _retorno = await _StatusDIAutorizacao("${_titulos[index][0]}", _user,
        _occupationAcronym, "${_titulos[index][5]}", numeroDI, index);
    Navigator.of(context).pop();
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
                          labelText: 'Motivo da rejeição',
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

  Future autorizationDI(
      BuildContext context,
      int index,
      GlobalKey<FormState> _formKey,
      TextEditingController diForaDoPrazo) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Informe a DI de autorização',
                style: TextStyle(fontSize: 16.9)),
            content: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: diForaDoPrazo,
                      decoration: InputDecoration(
                          labelText: 'Número DI',
                          hintStyle:
                              TextStyle(fontSize: 16.9, color: Colors.blue)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      child: Text("Enviar"),
                      onPressed: () async {
                        if (diForaDoPrazo.text != "") {
                          if (_formKey.currentState.validate()) {
                            _formKey.currentState.save();
                            Navigator.of(context).pop();
                            await _DiAutorizacao(index, diForaDoPrazo.text,
                                _scaffoldKey.currentContext);

                            diForaDoPrazo.text = "";
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
            context, _scaffoldKey, "Não foi possível conectar", screenWidth);
      }
    } catch (e) {
      WidgetsUteis.exibeSnackBar(
          context, _scaffoldKey, "Não foi possível conectar", screenWidth);
      print(e);
    }
  }

  Future _StatusDIAutorizacao(String _recno, String usuario, String _autcomo,
      String empresa, String numeroDI, int index) async {
    Response response;
    Dio dio = new Dio();
    List dados = [];
    try {
      response =
          await dio.post("${endereco.getEndereco}status_di_autorizacao", data: {
        "empresa": empresa,
        "arecno": _recno,
        "usuario": usuario,
        "autocomo": _autcomo,
        "numeroDI": numeroDI
      });
      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.data["status"] == '1') {
          WidgetsUteis.showLoadingDialog(
              context, _keyLoader, "Concluindo aprovação...");
          _retorno = await _AprovaTitulo("${_titulos[index][0]}", _user,
              _occupationAcronym, "${_titulos[index][5]}");
          Navigator.of(context).pop();
          setState(() {
            _titulos.removeAt(index);
            _dadosAdc.removeAt(index);
            if (_titulos.isEmpty) {
              _isLoading = true;
              buscaTitulos();
            }
          });
          WidgetsUteis.exibeSnackBar(
              context, _scaffoldKey, "Título aprovado!", screenWidth);
        } else {
          WidgetsUteis.exibeSnackBar(
              context, _scaffoldKey, "DI incorreta!", screenWidth);
        }
      } else {
        WidgetsUteis.exibeSnackBar(
            context, _scaffoldKey, "Não foi possível conectar", screenWidth);
      }
    } catch (e) {
      WidgetsUteis.exibeSnackBar(
          context, _scaffoldKey, "Não foi possível conectar", screenWidth);
      print(e);
    }
  }

  Future<List> _RejeitaTitulo(String _recno, String usuario, String _autcomo,
      String empresa, String motivo) async {
    Response response;
    Dio dio = new Dio();
    List dados = []; //_empresa, _recno, usuario, autcomo
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
            context, _scaffoldKey, "Não foi possível conectar", screenWidth);
      }
    } catch (e) {
      WidgetsUteis.exibeSnackBar(
          context, _scaffoldKey, "Não foi possível conectar", screenWidth);
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
          WidgetsUteis.exibeSnackBar(context, _scaffoldKey,
              'Não existe documento anexado!', screenWidth);
        }
        return dados;
      } else {
        WidgetsUteis.exibeSnackBar(
            context, _scaffoldKey, "Não foi possível conectar", screenWidth);
      }
      return dados;
    } catch (e) {
      WidgetsUteis.exibeSnackBar(
          context, _scaffoldKey, "Não foi possível conectar", screenWidth);
      print(e);
    }
  }

  Icon getInfo(String status) {
    if (status == 'GV' || status == 'SV' || status == 'DV') {
      return Icon(
        Icons.error,
        color: AppColors.orange,
      );
    }

    if (status == 'GR' || status == 'SR' || status == 'DR') {
      return Icon(
        Icons.error,
        color: AppColors.red,
      );
    }

    return Icon(
      Icons.check_circle,
      color: AppColors.darkGreen,
    );
  }
}
