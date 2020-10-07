import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tcc/models/contamodel.dart';

class ContaRepository extends Disposable {
  CollectionReference _collection = Firestore.instance.collection('contas');

  void add(ContaModel contaModel) => _collection.add(contaModel.toMap());

  void update(String documentId, ContaModel contaModel) =>
      _collection.document(documentId).updateData(contaModel.toMap());

  void delete(String documentId) => _collection.document(documentId).delete();

  Stream<List<ContaModel>> listarContas() {
    return _collection.snapshots().map((query) => query.documents
        .map<ContaModel>((document) => ContaModel.fromMap(document))
        .toList());
  }

  Future<ContaModel> findById(String documentId) async {
    var documento = await _collection.document(documentId).get();
    return ContaModel.fromMap(documento);
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
