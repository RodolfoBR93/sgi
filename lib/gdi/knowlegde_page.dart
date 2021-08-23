import 'package:flutter/material.dart';

class Knowledge extends StatefulWidget {
  static const String routeName = "/gdiKnowledge";

  @override
  _KnowledgeState createState() => _KnowledgeState();
}

class _KnowledgeState extends State<Knowledge> {
  List _departments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        centerTitle: true,
        title: new Text(
          "Ciência de Demandas Internas",
          style: TextStyle(color: Colors.white),
        ),
      ),
      backgroundColor: Colors.white,
      body: new Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: RefreshIndicator(
                child: ListView.builder(
                  padding: EdgeInsets.only(top: 10.0),
                  itemCount: _departments.length,
                  itemBuilder: buildDept,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

Widget buildDept(context, index) {
  return Expanded(
    child: InkWell(
      onTap: () {},
      child: Padding(
          padding: EdgeInsets.symmetric(vertical: 12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              CircleAvatar(),
            ],
          )),
    ),
  );
}
