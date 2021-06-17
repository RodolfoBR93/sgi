import 'package:flutter/material.dart';

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

  bool _onBackPressed = true;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return _onBackPressed;
      },
      child: new Scaffold(
        appBar: new AppBar(
          backgroundColor: Colors.blue,
          title: new Text(
            "Autorização de Lançamento",
            style: TextStyle(color: Colors.white),
          ),
        ),
        backgroundColor: Color.fromRGBO(235, 235, 235, 1),
        body: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: new Column(
                children: <Widget>[
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 2, right: 2, bottom: 15),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(
                              color: Colors.grey.withOpacity(0.7), width: 3),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                                color: Colors.grey, //.withOpacity(0.5),
                                offset: Offset(0.0, 7.0),
                                blurRadius: 1)
                          ]),
                      //height: MediaQuery.of(context).size.height * 0.28,
                      width: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          // Padding(
                          //   padding: const EdgeInsets.all(4.0),
                          //   child: Center(
                          //     child: new Text(
                          //       "AUTORIZAÇÃO DE LANÇAMENTO",
                          //     ),
                          //   ),
                          // ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 6.0),
                            child: Center(
                              child: new Text(
                                _dadosTitulo[0],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 15.0),
                            child: Center(
                              child: new Text(
                                _dadosTitulo[3][_dadosTitulo[1]][7],
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 8.0, bottom: 6.0),
                            child: new Text(
                              '<<Dados do Fornecedor>>',
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 8.0, bottom: 6.0),
                            child: new Text(
                              _dadosTitulo[2][_dadosTitulo[1]][1],
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 8.0, bottom: 6.0),
                            child: new Text(
                              _dadosTitulo[3][_dadosTitulo[1]][8],
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 8.0, bottom: 6.0),
                            child: new Text(
                              _dadosTitulo[3][_dadosTitulo[1]][9],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 2, right: 2, bottom: 15),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(
                              color: Colors.grey.withOpacity(0.7), width: 3),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                                color: Colors.grey, //.withOpacity(0.5),
                                offset: Offset(0.0, 7.0),
                                blurRadius: 1)
                          ]),
                      //height: MediaQuery.of(context).size.height * 0.25,
                      width: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 8.0, bottom: 6.0),
                            child: new Text(
                              '<<Dados do Lançamento>>',
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 8.0, bottom: 6.0),
                            child: new Text(
                              'Centro de Custo: ' +
                                  _dadosTitulo[3][_dadosTitulo[1]][10],
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 8.0, bottom: 6.0),
                            child: new Text(
                              'Natureza: ' +
                                  _dadosTitulo[3][_dadosTitulo[1]][11],
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 8.0, bottom: 6.0),
                            child: new Text(
                              'Descrição: ' +
                                  _dadosTitulo[3][_dadosTitulo[1]][12],
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 8.0, bottom: 6.0),
                            child: new Text(
                              'Prefixo: ' +
                                  _dadosTitulo[3][_dadosTitulo[1]][1] +
                                  "     " +
                                  'Número: ' +
                                  _dadosTitulo[3][_dadosTitulo[1]][2] +
                                  "     " +
                                  'Parcelas: ' +
                                  _dadosTitulo[3][_dadosTitulo[1]][13],
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 8.0, bottom: 6.0),
                            child: new Text(
                              'Valor: ' +
                                  _dadosTitulo[3][_dadosTitulo[1]][4] +
                                  "     " +
                                  'Tipo: ' +
                                  _dadosTitulo[3][_dadosTitulo[1]][0] +
                                  "     " +
                                  (_dadosTitulo[3][_dadosTitulo[1]][14] != ''
                                      ? 'Vale: ' +
                                          _dadosTitulo[3][_dadosTitulo[1]][14]
                                      : ''),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 8.0, bottom: 6.0),
                            child: new Text('Data de Emissão: ' +
                                _dadosTitulo[3][_dadosTitulo[1]][15]),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 8.0, bottom: 6.0),
                            child: new Text('Data de Vencimento: ' +
                                _dadosTitulo[3][_dadosTitulo[1]][5]),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 8.0, bottom: 6.0),
                            child: new Text('Usuário Lançamento: ' +
                                _dadosTitulo[3][_dadosTitulo[1]][16]),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 8.0, bottom: 6.0),
                            child: new Text('Data Lançamento: ' +
                                _dadosTitulo[3][_dadosTitulo[1]][17]),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 2, right: 2, bottom: 15),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(
                              color: Colors.grey.withOpacity(0.7), width: 3),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                                color: Colors.grey, //.withOpacity(0.5),
                                offset: Offset(0.0, 7.0),
                                blurRadius: 1)
                          ]),
                      //height: MediaQuery.of(context).size.height * 0.27,
                      width: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 8.0, bottom: 6.0),
                            child: new Text(
                              '<<Status Aprovação>>',
                            ),
                          ),
                          Row(
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
                        ],
                      ),
                    ),
                  )
                ],
              )),
        ),
      ),
    );
  }
}
