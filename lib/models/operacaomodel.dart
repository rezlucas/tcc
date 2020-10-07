import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tcc/models/basemodel.dart';

class OperacaoModel extends BaseModel {
  String _documentId;
  String descricao;
  String cor;
  double saldoInicial;

  OperacaoModel();
  OperacaoModel.parametrizado(this.descricao, this.cor, this.saldoInicial);
  OperacaoModel.fromMap(DocumentSnapshot document) {
    _documentId = document.documentID;

    this.descricao = document.data["descricao"];
    this.cor = document.data["cor"];
    this.saldoInicial = document.data["saldoInicial"];
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
}
