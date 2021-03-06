import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:sgi/core/app_colors.dart';
import 'package:sgi/core/app_text_styles.dart';
import 'package:sgi/core/uteis.dart';
import 'view_attachment_page.dart';

class DetailedPayment extends StatefulWidget {
  final List _dadosTitulo;
  DetailedPayment(this._dadosTitulo);
  @override
  _DetailedPaymentState createState() =>
      _DetailedPaymentState(this._dadosTitulo);
}

class _DetailedPaymentState extends State<DetailedPayment> {
  final List _dadosTitulo;
  _DetailedPaymentState(this._dadosTitulo);
  final _formKey = GlobalKey<FormState>();
  List _retorno = [];
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  Endereco endereco = new Endereco();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _onBackPressed = true;
  double screenWidth;

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async {
        return _onBackPressed;
      },
      child: new Scaffold(
        key: _scaffoldKey,
        appBar: new AppBar(
          backgroundColor: Colors.blue,
          centerTitle: true,
          title: new Text(
            "Autorização de Lançamento",
            style: TextStyle(color: Colors.white),
          ),
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
          // actions: <Widget>[
          //   GestureDetector(
          //     onTap: () {
          //       visualizarAnexo(
          //           context,
          //           _dadosTitulo[1],
          //           _dadosTitulo[2][_dadosTitulo[1]][5],
          //           _dadosTitulo[2][_dadosTitulo[1]][0]);
          //     },
          //     child: Padding(
          //       padding: const EdgeInsets.only(right: 16.0),
          //       child: Icon(Icons.attach_file),
          //     ),
          //   ),
          // ],
        ),
        backgroundColor: AppColors.white, //Color.fromRGBO(235, 235, 235, 1),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: new Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child:
                      Text(_dadosTitulo[4], style: AppTextStyles.title15Black),
                ),
                Container(
                  width: double.infinity,
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: 16),
                  height: 25,
                  color: AppColors.darkGrey,
                  child: Text("Dados do Fornecedor"),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 16, right: 16, bottom: 16, top: 8),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(
                          color: Colors.grey.withOpacity(0.7), width: 1),
                      // boxShadow: <BoxShadow>[
                      //   BoxShadow(
                      //       color: Colors.grey, //.withOpacity(0.5),
                      //       offset: Offset(0.0, 7.0),
                      //       blurRadius: 1),
                      // ],
                    ),
                    //height: MediaQuery.of(context).size.height * 0.28,
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(bottom: 15.0, top: 8),
                          child: Center(
                            child: new Text(
                              _dadosTitulo[0] +
                                  ' - ' +
                                  _dadosTitulo[3][_dadosTitulo[1]][7],
                            ),
                          ),
                        ),
                        // Padding(
                        //   padding: const EdgeInsets.only(bottom: 15.0),
                        //   child: Center(
                        //     child: new Text(
                        //       _dadosTitulo[3][_dadosTitulo[1]][7],
                        //     ),
                        //   ),
                        // ),
                        // Padding(
                        //   padding:
                        //       const EdgeInsets.only(left: 8.0, bottom: 8.0),
                        //   child: new Text(
                        //     '<<Dados do Fornecedor>>',
                        //   ),
                        // ),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 16.0, bottom: 8.0),
                          child: new Text(
                            _dadosTitulo[2][_dadosTitulo[1]][1],
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 16.0, bottom: 8.0),
                          child: new Text(
                            _dadosTitulo[3][_dadosTitulo[1]][8],
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 16.0, bottom: 8.0),
                          child: new Text(
                            _dadosTitulo[3][_dadosTitulo[1]][9],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: 16),
                  height: 25,
                  color: AppColors.darkGrey,
                  child: Text("Dados do Lançamento"),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 16, right: 16, bottom: 16, top: 8),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(
                          color: Colors.grey.withOpacity(0.7), width: 1),
                      // boxShadow: <BoxShadow>[
                      //   BoxShadow(
                      //       color: Colors.grey, //.withOpacity(0.5),
                      //       offset: Offset(0.0, 7.0),
                      //       blurRadius: 1)
                      // ],
                    ),
                    //height: MediaQuery.of(context).size.height * 0.25,
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        // Padding(
                        //   padding:
                        //       const EdgeInsets.only(left: 8.0, bottom: 8.0),
                        //   child: new Text(
                        //     '<<Dados do Lançamento>>',
                        //   ),
                        // ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 16.0, bottom: 8.0, top: 8),
                          child: new Text(
                              // 'Prefixo: ' +
                              //     _dadosTitulo[3][_dadosTitulo[1]][1] +
                              //     "     " +
                              //     'Número: ' +
                              //     _dadosTitulo[3][_dadosTitulo[1]][2] +
                              //     "     " +
                              //     'Parcelas: ' +
                              //     _dadosTitulo[3][_dadosTitulo[1]][13],
                              "Título: " +
                                  _dadosTitulo[3][_dadosTitulo[1]][1] +
                                  _dadosTitulo[3][_dadosTitulo[1]][2] +
                                  _dadosTitulo[3][_dadosTitulo[1]][0] +
                                  "     " +
                                  'Parcelas: ' +
                                  _dadosTitulo[3][_dadosTitulo[1]][13]),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 16.0, bottom: 8.0),
                          child: new Text(
                            'Valor: ' +
                                _dadosTitulo[3][_dadosTitulo[1]][4] +
                                "     " +
                                // 'Tipo: ' +
                                // _dadosTitulo[3][_dadosTitulo[1]][0] +
                                // "     " +
                                (_dadosTitulo[3][_dadosTitulo[1]][14] != ''
                                    ? 'Vale: ' +
                                        _dadosTitulo[3][_dadosTitulo[1]][14]
                                    : ''),
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 16.0, bottom: 8.0),
                          child: new Text(
                            'Natureza: ' + _dadosTitulo[3][_dadosTitulo[1]][11],
                          ),
                        ),

                        Padding(
                          padding:
                              const EdgeInsets.only(left: 16.0, bottom: 8.0),
                          child: new Text(
                            'Descrição: ' +
                                _dadosTitulo[3][_dadosTitulo[1]][12],
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 16.0, bottom: 8.0),
                          child: new Text(
                            'Centro de Custo: ' +
                                _dadosTitulo[3][_dadosTitulo[1]][10],
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 16.0, bottom: 8.0),
                          child: new Text('Data de Emissão: ' +
                              _dadosTitulo[3][_dadosTitulo[1]][15]),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 16.0, bottom: 8.0),
                          child: new Text('Data de Vencimento: ' +
                              _dadosTitulo[3][_dadosTitulo[1]][5]),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 16.0, bottom: 8.0),
                          child: new Text('Data Lançamento: ' +
                              _dadosTitulo[3][_dadosTitulo[1]][17]),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 16.0, bottom: 8.0),
                          child: new Text('Usuário Lançamento: ' +
                              _dadosTitulo[3][_dadosTitulo[1]][16]),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: 16),
                  height: 25,
                  color: AppColors.darkGrey,
                  child: Text("Status Aprovação"),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 16, right: 16, bottom: 16, top: 8),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(
                          color: Colors.grey.withOpacity(0.7), width: 1),
                      // boxShadow: <BoxShadow>[
                      //   BoxShadow(
                      //       color: Colors.grey, //.withOpacity(0.5),
                      //       offset: Offset(0.0, 7.0),
                      //       blurRadius: 1)
                      // ],
                    ),
                    //height: MediaQuery.of(context).size.height * 0.27,
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Expanded(
                                  flex: 4,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Center(
                                        child: Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Text(
                                            'Gestor', //'Gerência: '+_dadosTitulo[3][_dadosTitulo[1]][18]
                                          ),
                                        ),
                                      ),
                                      Center(
                                        child: Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Text(_dadosTitulo[3]
                                              [_dadosTitulo[1]][18]),
                                        ),
                                      ),
                                      Center(
                                        child: Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Text(_dadosTitulo[3]
                                              [_dadosTitulo[1]][19]),
                                        ),
                                      ),
                                      Center(
                                        child: Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Text(_dadosTitulo[3]
                                              [_dadosTitulo[1]][20]),
                                        ),
                                      ),
                                      Center(
                                        child: Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Text(_dadosTitulo[3]
                                              [_dadosTitulo[1]][21]),
                                        ),
                                      ),
                                      Center(
                                        child: Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Text(_dadosTitulo[3]
                                              [_dadosTitulo[1]][22]),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 4,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Center(
                                        child: Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Text(
                                            'Data',
                                          ),
                                        ),
                                      ),
                                      Center(
                                        child: Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Text(_dadosTitulo[3]
                                              [_dadosTitulo[1]][23]),
                                        ),
                                      ),
                                      Center(
                                        child: Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Text(_dadosTitulo[3]
                                              [_dadosTitulo[1]][24]),
                                        ),
                                      ),
                                      Center(
                                        child: Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Text(_dadosTitulo[3]
                                              [_dadosTitulo[1]][25]),
                                        ),
                                      ),
                                      Center(
                                        child: Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Text(_dadosTitulo[3]
                                              [_dadosTitulo[1]][26]),
                                        ),
                                      ),
                                      Center(
                                        child: Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Text(_dadosTitulo[3]
                                              [_dadosTitulo[1]][27]),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Center(
                                        child: Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Text(
                                            'Qtd.',
                                          ),
                                        ),
                                      ),
                                      Center(
                                        child: Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Text(
                                            _dadosTitulo[3][_dadosTitulo[1]]
                                                [28],
                                          ),
                                        ),
                                      ),
                                      Center(
                                        child: Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Text(
                                            _dadosTitulo[3][_dadosTitulo[1]]
                                                [29],
                                          ),
                                        ),
                                      ),
                                      Center(
                                        child: Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Text(
                                            _dadosTitulo[3][_dadosTitulo[1]]
                                                [30],
                                          ),
                                        ),
                                      ),
                                      Center(
                                        child: Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Text(
                                            _dadosTitulo[3][_dadosTitulo[1]]
                                                [31],
                                          ),
                                        ),
                                      ),
                                      Center(
                                        child: Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Text(
                                            _dadosTitulo[3][_dadosTitulo[1]]
                                                [32],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ]),
                        ),
                      ],
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            right: 8.0, left: 16.0, bottom: 16.0, top: 8.0),
                        child: SizedBox(
                          height: 50, //height of button
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context, '0');
                            },
                            style: ElevatedButton.styleFrom(
                                elevation: 3,
                                primary: AppColors.red,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                )),
                            child: Text(
                              "Rejeitar",
                              style: TextStyle(
                                  color: AppColors.white, fontSize: 16.9),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            right: 16.0, left: 8.0, bottom: 16.0, top: 8.0),
                        child: SizedBox(
                          height: 50, //height of button
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context, '1');
                            },
                            style: ElevatedButton.styleFrom(
                                elevation: 3,
                                primary: AppColors.darkGreen,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                )),
                            child: Text(
                              "Aprovar",
                              style: TextStyle(
                                  color: AppColors.white, fontSize: 16.9),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        bottomNavigationBar: new BottomNavigationBar(
          fixedColor: AppColors.black,
          unselectedItemColor: AppColors.black,
          selectedFontSize: 14,
          unselectedFontSize: 14,
          selectedLabelStyle: AppTextStyles.title15Black,
          unselectedLabelStyle: AppTextStyles.title15Black,
          onTap: onTabTapped,
          items: [
            new BottomNavigationBarItem(
                icon: new Icon(
                  Icons.attach_file,
                ),
                label: "Anexos"),
            new BottomNavigationBarItem(
              icon: new Icon(Icons.attach_money),
              label: "Impostos",
            ),
            new BottomNavigationBarItem(
              icon: new Icon(Icons.donut_large),
              label: "Rateio",
            ),
          ],
        ),
      ),
    );
  }

  void onTabTapped(int index) {
    List impostos = [];
    setState(() {
      if (index == 0) {
        visualizarAnexo(
            context,
            _dadosTitulo[1],
            _dadosTitulo[2][_dadosTitulo[1]][5],
            _dadosTitulo[2][_dadosTitulo[1]][0]);
      } else if (index == 1) {
        if (!_dadosTitulo[5].isEmpty) {
          for (int i = 0; i < _dadosTitulo[5].length; i++) {
            if (_dadosTitulo[5][i][0] == _dadosTitulo[3][_dadosTitulo[1]][36]) {
              impostos.add([_dadosTitulo[5][i][1], _dadosTitulo[5][i][2]]);
            }
          }
          getImpostos(impostos);
        } else {
          WidgetsUteis.exibeSnackBar(
              context, _scaffoldKey, "Título não possui impostos", screenWidth);
        }
      } else if (index == 2) {
        if (!_dadosTitulo[3][_dadosTitulo[1]][37].isEmpty) {
          getRateio(_dadosTitulo[3][_dadosTitulo[1]][37]);
        } else {
          WidgetsUteis.exibeSnackBar(
              context, _scaffoldKey, "Título não possui rateio", screenWidth);
        }
      }
    });
  }

  void visualizarAnexo(
      BuildContext context, int index, String company, String recno) async {
    WidgetsUteis.showLoadingDialog(context, _keyLoader, "Baixando anexos...");
    _retorno = await _BuscaAnexos(recno, company);
    Navigator.of(context).pop();
    selecionaAnexo(context, index, _formKey, _retorno);
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

  buscaAnexo(String recno, String empresa, String anexo) async {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) => new ViewAttachment(
            '${endereco.getEndereco}getanexo?empresa=$empresa&anexo=$anexo&arecno=$recno')));
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
                              _dadosTitulo[2][_dadosTitulo[1]][0],
                              _dadosTitulo[2][_dadosTitulo[1]][5],
                              anexos[index]),
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

  Future getImpostos(List impostos) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return new WillPopScope(
              onWillPop: () {},
              child: AlertDialog(
                title: Text('Impostos', style: TextStyle(fontSize: 16.9)),
                content: Container(
                  //color: Colors.grey,
                  width: double.maxFinite,
                  height: 300.0,
                  child: ListView.builder(
                    padding: EdgeInsets.only(top: 10.0),
                    itemCount: impostos.length,
                    itemBuilder: (context, index) {
                      return Card(
                        color: Colors.white,
                        child: ListTile(
                          //leading: Icon(Icons.attach_file),
                          //trailing: Icon(Icons.keyboard_arrow_right),
                          title: Text(impostos[index][0]),
                          subtitle: Text(impostos[index][1]),
                          // onTap: () => buscaAnexo(
                          //     _dadosTitulo[2][_dadosTitulo[1]][0],
                          //     _dadosTitulo[2][_dadosTitulo[1]][5],
                          //     anexos[index]),
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

  Future getRateio(List rateio) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return new WillPopScope(
              onWillPop: () {},
              child: AlertDialog(
                title: Text('Rateio', style: TextStyle(fontSize: 16.9)),
                content: Container(
                  //color: Colors.grey,
                  width: double.maxFinite,
                  height: 300.0,
                  child: ListView.builder(
                    padding: EdgeInsets.only(top: 10.0),
                    itemCount: rateio.length,
                    itemBuilder: (context, index) {
                      return Card(
                        color: Colors.white,
                        child: ListTile(
                          //leading: Icon(Icons.attach_file),
                          //trailing: Icon(Icons.keyboard_arrow_right),
                          title: Text(rateio[index][0]),
                          subtitle: Text(rateio[index][2]),
                          // onTap: () => buscaAnexo(
                          //     _dadosTitulo[2][_dadosTitulo[1]][0],
                          //     _dadosTitulo[2][_dadosTitulo[1]][5],
                          //     anexos[index]),
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
}
