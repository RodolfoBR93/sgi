import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:intl/intl.dart';
import 'package:sgi/core/uteis.dart';

class InternalDemandWidget extends StatelessWidget {
  final TextEditingController _messageController = TextEditingController();
  final DateFormat _dateFormatter = DateFormat("dd/MM/yyyy");
  String _intDemandNumber;
  String _target;
  List _messages = [];
  List _cabecalho = [];
  String _actDpt;
  double _screenWidth;
  double _screenHeight;

  InternalDemandWidget(String intDemandNumber, String target, String actDpt) {
    this._intDemandNumber = intDemandNumber;
    this._target = target;
    this._actDpt = actDpt;
  }

  Future<List> getMessages() async {
    Response response;
    Dio dio = new Dio();
    EnderecoGdi endereco = new EnderecoGdi();

    if (!kIsWeb) {
      response = await dio.get(
          "${endereco.getEndereco}number/:diNumberInf/:target?diNumberInf=${_intDemandNumber}&target=${_target}");
      if (response.statusCode == 200 || response.statusCode == 201) {
        _messages = response.data.values.toList()[1];
        _cabecalho = response.data.values.toList()[0];
      }
    } else {
      response = await dio.get(
          "${endereco.getEndereco}number/:diNumberInf/:target?diNumberInf=${_intDemandNumber}&target=${_target}");
      if (response.statusCode == 200 || response.statusCode == 201) {
        _messages = response.data.values.toList()[1];
        _cabecalho = response.data.values.toList()[0];
      }
    }

    return _messages;
  }

  @override
  Widget build(BuildContext context) {
    _screenWidth = MediaQuery.of(context).size.width;
    _screenHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        appBar: new AppBar(
          centerTitle: true,
          title: SelectableText(
            _intDemandNumber + ' ' + _target,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        backgroundColor: Colors.white,
        body: new Center(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: RefreshIndicator(
                  child: FutureBuilder<List>(
                      future: getMessages(),
                      builder: (context, snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.none:
                            return Center(
                              child: SelectableText("Nenhum dado carregado!"),
                            );
                          case ConnectionState.waiting:
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          default:
                            if (snapshot.hasError) {
                              return Center(
                                child: SelectableText(
                                    "Erro ao carregar os dados."),
                              );
                            } else {
                              return Stack(
                                children: <Widget>[
                                  buildMessagesList(),
                                  buildInput()
                                ],
                              );
                            }
                        }
                      }),
                  onRefresh: _refresh,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildMessagesList() {
    return Container(
      height: _screenHeight * 0.88,
      child: ListView.builder(
        padding: EdgeInsets.all(10.0),
        shrinkWrap: true,
        itemCount: _messages.length,
        itemBuilder: buildItem,
      ),
    );
  }

  Widget buildItem(context, index) {
    return _messages[index]["T09_DPTDES"] != _actDpt
        ? Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.fromLTRB(14.0, 14.0, 10.0, 10.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    constraints: BoxConstraints(
                        minWidth: _screenWidth * 0.2,
                        maxWidth: _screenWidth * 0.5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: Colors.grey[350],
                    ),
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Align(
                              alignment: Alignment.topLeft,
                              child: SelectableText(
                                _messages[index]["T09_DPTORI"].trim() + ' ',
                                style: TextStyle(
                                    fontSize: 11,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            Align(
                              alignment: Alignment.topCenter,
                              child: SelectableText(
                                _messages[index]["DPTORI_DESCRICAO"].trim() +
                                    ' ',
                                style: TextStyle(
                                    fontSize: 11,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            Align(
                              alignment: Alignment.topCenter,
                              child: SelectableText(
                                _messages[index]["T09_DPTDES"],
                                style: TextStyle(
                                    fontSize: 11,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(top: 8.0),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: FittedBox(
                                  fit: BoxFit.contain,
                                  child: SelectableText(
                                    _messages[index]["T09_RELATO"].trim(),
                                    style: TextStyle(
                                      fontSize: 15.0,
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 5.0),
                          child: Row(
                            children: <Widget>[
                              SelectableText(
                                  _dateFormatter
                                          .format(DateTime.parse(
                                              _messages[index]["T09_DATENV"]))
                                          .toUpperCase() +
                                      ' ',
                                  style: TextStyle(
                                    fontSize: 15.0,
                                  ),
                                  textAlign: TextAlign.left),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              !_messages[index]["T09_ANEXO"].isEmpty
                  ? Material(
                      borderRadius: BorderRadius.circular(30),
                      child: InkWell(
                        splashColor: Colors.grey,
                        onTap: () {},
                        borderRadius: BorderRadius.circular(30),
                        child: SizedBox(
                          width: _screenWidth * 0.045,
                          height: _screenHeight * 0.075,
                          child: Icon(
                            Icons.attach_file,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    )
                  : SizedBox.shrink(),
            ],
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              !_messages[index]["T09_ANEXO"].isEmpty
                  ? Material(
                      borderRadius: BorderRadius.circular(30),
                      child: InkWell(
                        splashColor: Colors.grey,
                        onTap: () {},
                        borderRadius: BorderRadius.circular(30),
                        child: SizedBox(
                          width: _screenWidth * 0.045,
                          height: _screenHeight * 0.075,
                          child: Icon(
                            Icons.attach_file,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    )
                  : SizedBox.shrink(),
              Container(
                padding: EdgeInsets.fromLTRB(14.0, 14.0, 10.0, 10.0),
                child: Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    constraints: BoxConstraints(
                        minWidth: _screenWidth * 0.2,
                        maxWidth: _screenWidth * 0.5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: Colors.blue,
                    ),
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Align(
                              alignment: Alignment.topLeft,
                              child: SelectableText(
                                _messages[index]["T09_DPTORI"].trim() + ' ',
                                style: TextStyle(
                                    fontSize: 11,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            Align(
                              alignment: Alignment.topCenter,
                              child: SelectableText(
                                _messages[index]["DPTORI_DESCRICAO"].trim(),
                                style: TextStyle(
                                    fontSize: 11,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(top: 8.0),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: SelectableText(
                                  _messages[index]["T09_RELATO"].trim(),
                                  style: TextStyle(
                                    fontSize: 15.0,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
  }

  Widget buildInput() {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Container(
        height: _screenHeight * 0.075,
        width: _screenWidth,
        color: Colors.white,
        child: ButtonBar(
          mainAxisSize: MainAxisSize.max,
          alignment: MainAxisAlignment.center,
          children: <Widget>[
            Material(
              borderRadius: BorderRadius.circular(30),
              child: InkWell(
                splashColor: Colors.grey,
                onTap: () {},
                borderRadius: BorderRadius.circular(30),
                child: SizedBox(
                  width: _screenWidth * 0.045,
                  height: _screenHeight * 0.075,
                  child: Icon(
                    Icons.attach_file,
                    color: Colors.blue,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: _screenWidth * 0.88,
              height: _screenHeight * 0.075,
              child: TextField(
                controller: _messageController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Mensagem',
                ),
              ),
            ),
            Material(
              borderRadius: BorderRadius.circular(30),
              child: InkWell(
                splashColor: Colors.grey,
                onTap: () {},
                borderRadius: BorderRadius.circular(30),
                child: SizedBox(
                  width: _screenWidth * 0.045,
                  height: _screenHeight * 0.075,
                  child: Icon(
                    Icons.send,
                    color: Colors.blue,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<Null> _refresh() async {
    await Future.delayed(Duration(seconds: 1));
    return null;
  }
}
