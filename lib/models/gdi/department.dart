import 'package:flutter/material.dart';

class Department {
  final int id;
  final String department;
  final String description;
  final String active;
  final String idFilial;
  final String depto;

  Department(this.id, this.department, this.description, this.active,
      this.idFilial, this.depto);

  @override
  String toString() {
    return 'User{id: $id,department: $department, description: $description, active: $active, idFilial: $idFilial, depto: $depto}';
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

  Map<String, dynamic> toMap() {
    //instanciando o mapa
    var mapa = new Map<String, dynamic>();
    // agora iremos fazer o inverso do anterior, iremos colocar o conteúdo
    // dos atributos no mapa, ficará como se fosse um json
    mapa["id"] = id;
    mapa["department"] = department;
    mapa["description"] = description;
    mapa["active"] = active;
    mapa["idFilial"] = idFilial;
    mapa["depto"] = depto;
    debugPrint(mapa.toString());
    debugPrint("dentro do department.tomap");
    return mapa;
  }

  static Department fromMap(Map<String, dynamic> map) {
    return Department(
      map["id"],
      map["department"],
      map["description"],
      map["active"],
      map["idFilial"],
      map["depto"],
    );
  }
}
