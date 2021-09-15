import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:sgi/core/uteis.dart';

class InternalDemandWidget extends StatelessWidget {
  final TextEditingController _messageController = TextEditingController();
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
          "${endereco.getEndereco}getByNumber/:diNumberInf/:target?diNumberInf=${_intDemandNumber}&target=${_target}");
      if (response.statusCode == 200 || response.statusCode == 201) {
        _messages = response.data.values.toList()[1];
        _cabecalho = response.data.values.toList()[0];
      }
    } else {
      response = await dio.get(
          "${endereco.getEndereco}getByNumber/:diNumberInf/:target?diNumberInf=${_intDemandNumber}&target=${_target}");
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
    return Scaffold(
      appBar: new AppBar(
        centerTitle: true,
        title: Text(
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
                            child: Text("Nenhum dado carregado!"),
                          );
                        case ConnectionState.waiting:
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        default:
                          if (snapshot.hasError) {
                            return Center(
                              child: Text("Erro ao carregar os dados."),
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
    );
  }

  Widget buildMessagesList() {
    return ListView.builder(
      padding: EdgeInsets.all(10.0),
      shrinkWrap: true,
      itemCount: _messages.length,
      itemBuilder: buildItem,
    );
  }

  Widget buildItem(context, index) {
    return Container(
      padding: EdgeInsets.fromLTRB(14.0, 14.0, 10.0, 10.0),
      child: Align(
        alignment: _messages[index]["T09_DPTDES"] == _actDpt
            ? Alignment.topRight
            : Alignment.topLeft,
        child: Container(
            constraints: BoxConstraints(
                minWidth: _screenWidth * 0.2, maxWidth: _screenWidth * 0.5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: _messages[index]["T09_DPTDES"] == _actDpt
                  ? Colors.blue
                  : Colors.grey[350],
            ),
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(
                      _messages[index]["T09_DPTORI"],
                      style: TextStyle(
                          fontSize: 11,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.left,
                    )
                  ],
                ),
                Text(
                  _messages[index]["T09_RELATO"],
                  style: TextStyle(fontSize: 15.0),
                )
              ],
            )),
      ),
    );
  }

  Widget buildInput() {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Container(
        height: _screenHeight * 0.09,
        width: _screenWidth,
        color: Colors.white,
        child: ButtonBar(
          mainAxisSize: MainAxisSize.max,
          alignment: MainAxisAlignment.center,
          children: <Widget>[
            Material(
              borderRadius: BorderRadius.circular(25),
              child: InkWell(
                splashColor: Colors.grey,
                onTap: () {},
                borderRadius: BorderRadius.circular(25),
                child: SizedBox(
                    width: _screenWidth * 0.03,
                    height: _screenHeight * 0.09,
                    child: Icon(
                      Icons.attach_file,
                      color: Colors.blue,
                    )),
              ),
            ),
            SizedBox(
              width: _screenWidth * 0.85,
              height: _screenHeight * 0.09,
              child: TextField(
                controller: _messageController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Mensagem',
                ),
              ),
            ),
            Material(
              borderRadius: BorderRadius.circular(25),
              child: InkWell(
                splashColor: Colors.grey,
                onTap: () {},
                borderRadius: BorderRadius.circular(25),
                child: SizedBox(
                    width: _screenWidth * 0.03,
                    height: _screenHeight * 0.09,
                    child: Icon(
                      Icons.send,
                      color: Colors.blue,
                    )),
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
