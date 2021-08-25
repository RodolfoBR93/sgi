import 'package:flutter/material.dart';
import 'package:sgi/gdi/knowlegde_page.dart';

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
      bottomNavigationBar: BottomAppBar(
        color: Colors.blue,
        // shape: CircularNotchedRectangle(),
        child: IconTheme(
          data: IconThemeData(color: Theme.of(context).colorScheme.onPrimary),
          child: Row(
            children: <Widget>[
              IconButton(
                tooltip: "Cadastros",
                icon: const Icon(Icons.category),
                onPressed: () {},
              ),
              IconButton(
                tooltip: "Demandas Internas",
                icon: const Icon(Icons.task),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Knowledge()));
                },
              ),
              IconButton(
                tooltip: "Relatórios",
                icon: const Icon(Icons.report),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
