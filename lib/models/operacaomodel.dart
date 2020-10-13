import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tcc/models/basemodel.dart';

class OperacaoModel extends BaseModel {
  String _documentId;
  String descricao;
  double saldoInicial;
  String conta;
  String categoria;
  String tipoOperacao;
  String data;
  String hora;

  OperacaoModel();
  OperacaoModel.parametrizado(
      this.descricao, this.saldoInicial, this.conta, this.categoria);
  OperacaoModel.fromMap(DocumentSnapshot document) {
    _documentId = document.documentID;

    this.descricao = document.data["descricao"];
    this.saldoInicial = document.data["saldoInicial"];
    this.conta = document.data["conta"];
    this.categoria = document.data["categoria"];
    this.tipoOperacao = document.data["tipoOperacao"];
    this.data = document.data["data"];
    this.hora = document.data["hora"];
  }

  String get getDescricao => this.descricao;
  String get getConta => this.conta;
  String get getCategoria => this.categoria;
  String get getTipoOperacao => this.tipoOperacao;
  String get getData => this.data;
  String get getHora => this.hora;

  @override
  toMap() {
    var map = new Map<String, dynamic>();
    map['descricao'] = this.descricao;
    map['saldoInicial'] = this.saldoInicial;
    map['conta'] = this.conta;
    map['contegoria'] = this.categoria;
    map['tipoOperacao'] = this.tipoOperacao;
    map['data'] = this.data;
    map['hora'] = this.hora;

    return map;
  }

  @override
  String documentId() => _documentId;
}
