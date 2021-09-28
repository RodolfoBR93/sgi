import 'package:flutter/material.dart';

class Department {
  final int id;
  final String department;
  final String description;
  final String evaluate;
  final String active;
  final int idFilial;
  final String depto;

  Department(this.id, this.department, this.description, this.evaluate,
      this.active, this.idFilial, this.depto);

  @override
  String toString() {
    return 'User{id: $id,department: $department, description: $description, evaluate: $evaluate, active: $active, idFilial: $idFilial, depto: $depto}';
  }

  String get getDepartment {
    return department;
  }

  String get getDescription {
    return description;
  }

  String get getActive {
    return active;
  }

  String get getEvaluate {
    return evaluate;
  }

  Map<String, dynamic> toMap() {
    //instanciando o mapa
    var mapa = new Map<String, dynamic>();
    // agora iremos fazer o inverso do anterior, iremos colocar o conteúdo
    // dos atributos no mapa, ficará como se fosse um json
    mapa["id"] = id;
    mapa["T04_CODIGO"] = department;
    mapa["T04_DESCRICAO"] = description;
    mapa["T04_AVALIA"] = evaluate;
    mapa["T04_ATIVO"] = active;
    mapa["T04_ID_FILIAL"] = idFilial;
    mapa["DEPTO"] = depto;
    debugPrint(mapa.toString());
    debugPrint("dentro do department.tomap");
    return mapa;
  }

  static Department fromMap(Map<String, dynamic> map) {
    return Department(
      map["id"],
      map["T04_CODIGO"],
      map["T04_DESCRICAO"],
      map["T04_AVALIA"],
      map["T04_ATIVO"],
      map["T04_ID_FILIAL"],
      map["DEPTO"],
    );
  }
}
