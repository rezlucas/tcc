import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tcc/models/basemodel.dart';

class ContaModel extends BaseModel {
  String _documentId;
  String descricao;
  String cor;
  double saldoInicial;

  ContaModel();
  ContaModel.parametrizado(this.descricao, this.cor, this.saldoInicial);
  ContaModel.fromMap(DocumentSnapshot document) {
    _documentId = document.documentID;

    this.descricao = document.data["descricao"];
    this.cor = document.data["cor"];
    this.saldoInicial = document.data["saldoInicial"];
  }
  @override
  bool operator ==(Object segunda) {
    return segunda is ContaModel && documentId() == segunda.documentId();
  }

  String get getDescricao => this.descricao;
  String get getCor => this.cor;

  @override
  toMap() {
    var map = new Map<String, dynamic>();
    map['descricao'] = this.descricao;
    map['cor'] = this.cor;
    map['saldoInicial'] = this.saldoInicial;

    return map;
  }

  @override
  String documentId() => _documentId;

  @override
  // TODO: implement hashCode
  int get hashCode => super.hashCode;
}
