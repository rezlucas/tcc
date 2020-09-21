import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tcc/models/basemodel.dart';

class TipoModel extends BaseModel {
  String _documentId;
  String descricao;
  String cor;

  TipoModel();
  TipoModel.parametrizado(this.descricao, this.cor);
  TipoModel.fromMap(DocumentSnapshot document) {
    _documentId = document.documentID;

    this.descricao = document.data["descricao"];
    this.cor = document.data["cor"];
  }

  String get getDescricao => this.descricao;
  String get getCor => this.cor;

  @override
  toMap() {
    var map = new Map<String, dynamic>();
    map['descricao'] = this.descricao;
    map['cor'] = this.cor;

    return map;
  }

  @override
  String documentId() => _documentId;
}
