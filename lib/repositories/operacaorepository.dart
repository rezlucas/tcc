import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tcc/models/operacaomodel.dart';

class OperacaoRepository extends Disposable {
  CollectionReference _collection = Firestore.instance.collection('operacoes');

  void add(OperacaoModel operacaoModel) =>
      _collection.add(operacaoModel.toMap());

  void update(String documentId, OperacaoModel operacaoModel) =>
      _collection.document(documentId).updateData(operacaoModel.toMap());

  void delete(String documentId) => _collection.document(documentId).delete();

  Stream<List<OperacaoModel>> listarOperacoes() {
    return _collection.snapshots().map((query) => query.documents
        .map<OperacaoModel>((document) => OperacaoModel.fromMap(document))
        .toList());
  }

  // void limpaBase() {
  //   var tipos = listarContas();
  //   tipos.forEach((element) {
  //     element.forEach((x) {
  //       delete(x.documentId());
  //     });
  //   });
  // }

  @override
  void dispose() {}
}
