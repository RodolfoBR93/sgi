import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class InternalDemandWidget extends StatelessWidget {
  final TextEditingController _messageController = TextEditingController();
  String _intDemandNumber;
  String _target;
  List _messages = [];
  double _screenWidth;
  double _screenHeight;

  InternalDemandWidget(String intDemandNumber, String target) {
    this._intDemandNumber = intDemandNumber;
    this._target = target;
  }

  Future<List> getMessages() async {
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
                                buildMessagesList(_messages),
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

  Widget buildMessagesList(List messages) {
    return ListView.builder(
      padding: EdgeInsets.only(top: 10.0),
      itemCount: _messages.length,
      itemBuilder: buildItem,
    );
  }

  Widget buildItem(context, index) {
    return Stack(
      children: <Widget>[],
    );
  }

  Widget buildInput() {
    return Stack(
      fit: StackFit.loose,
      alignment: AlignmentDirectional.bottomEnd,
      children: <Widget>[
        ButtonBar(
          mainAxisSize: MainAxisSize.max,
          alignment: MainAxisAlignment.center,
          children: <Widget>[
            ClipOval(
              child: Material(
                child: InkWell(
                  splashColor: Colors.grey,
                  onTap: () {},
                  child: SizedBox(
                      width: _screenWidth * 0.03,
                      height: _screenHeight * 0.03,
                      child: Icon(
                        Icons.attach_file,
                      )),
                ),
              ),
            ),
            SizedBox(
              width: _screenWidth * 0.72,
              height: _screenHeight * 0.03,
              child: TextField(
                controller: _messageController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Mensagem',
                ),
              ),
            ),
            ClipOval(
              child: Material(
                child: InkWell(
                  splashColor: Colors.grey,
                  onTap: () {},
                  child: SizedBox(
                      width: _screenWidth * 0.03,
                      height: _screenHeight * 0.03,
                      child: Icon(
                        Icons.attach_file,
                      )),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }

  Future<Null> _refresh() async {
    await Future.delayed(Duration(seconds: 1));
    return null;
  }
}
