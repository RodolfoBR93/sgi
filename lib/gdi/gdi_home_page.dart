import 'package:flutter/material.dart';

class Gdi extends StatefulWidget {
  static const String routeName = "/gdi";
  @override
  _GdiState createState() => _GdiState();
}

class _GdiState extends State<Gdi> {
  void abriNC() {}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        centerTitle: true,
        title: new Text(
          "Gerenciador de Demandas Internas",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Em desenvolvimento',
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: abriNC,
        tooltip: 'Abrir DI',
        child: Icon(Icons.add),
      ),
    );
  }
}
