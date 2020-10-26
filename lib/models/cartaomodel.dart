import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tcc/models/basemodel.dart';

class CartaoModel extends BaseModel {
  String _documentId;
  String descricao;
  String data;

  CartaoModel();
  CartaoModel.parametrizado(this.descricao);
  CartaoModel.fromMap(DocumentSnapshot document) {
    _documentId = document.documentID;

    this.descricao = document.data["descricao"];
    this.data = document.data["data"];
  }

  String get getDescricao => this.descricao;
  String get getData => this.data;

  @override
  toMap() {
    var map = new Map<String, dynamic>();
    map['descricao'] = this.descricao;
    map['data'] = this.data;

    return map;
  }

  @override
  String documentId() => _documentId;
}
