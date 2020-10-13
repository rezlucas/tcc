import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tcc/models/basemodel.dart';

class TipoModel extends BaseModel {
  String _documentId;
  String descricao;
  int idIcon;
  String fontfamilyIcon;

  TipoModel();
  TipoModel.parametrizado(this.descricao, this.idIcon, this.fontfamilyIcon);
  TipoModel.fromMap(DocumentSnapshot document) {
    _documentId = document.documentID;

    this.descricao = document.data["descricao"];
    this.idIcon = document.data["idIcon"];
    this.fontfamilyIcon = document.data["fontfamilyIcon"];
  }

  @override
  bool operator ==(Object segunda) {
    return segunda is TipoModel && documentId() == segunda.documentId();
  }

  String get getDescricao => this.descricao;
  int get getIdIcon => this.idIcon;
  String get getfontfamilyIcon => this.fontfamilyIcon;

  @override
  toMap() {
    var map = new Map<String, dynamic>();
    map['descricao'] = this.descricao;
    map['idIcon'] = this.idIcon;
    map['fontfamily'] = this.fontfamilyIcon;

    return map;
  }

  @override
  String documentId() => _documentId;

  @override
  // TODO: implement hashCode
  int get hashCode => super.hashCode;
}
