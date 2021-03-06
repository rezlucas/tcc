import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tcc/models/tipomodel.dart';

class TipoRepository extends Disposable {
  CollectionReference _collection = Firestore.instance.collection('tipos');

  void add(TipoModel tipoModel) => _collection.add(tipoModel.toMap());

  void update(String documentId, TipoModel tipoModel) =>
      _collection.document(documentId).updateData(tipoModel.toMap());

  void delete(String documentId) => _collection.document(documentId).delete();

  Stream<List<TipoModel>> listarTipos() {
    return _collection.snapshots().map((query) => query.documents
        .map<TipoModel>((document) => TipoModel.fromMap(document))
        .toList());
  }

  Future<TipoModel> findById(String documentId) async {
    var documento = await _collection
        .document(documentId)
        .get()
        .catchError((e) => {print(e.message)});
    return TipoModel.fromMap(documento);
  }
  // void limpaBase() {
  //   var tipos = listarTipos();
  //   tipos.forEach((element) {
  //     element.forEach((x) {
  //       delete(x.documentId());
  //     });
  //   });
  // }

  @override
  void dispose() {}
}
