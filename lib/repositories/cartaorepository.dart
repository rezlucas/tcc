import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tcc/models/cartaomodel.dart';
import 'package:tcc/repositories/contarepository.dart';
import 'package:rxdart/rxdart.dart';

class CartaoRepository extends Disposable {
  CollectionReference _collection = Firestore.instance.collection('operacoes');

  void add(CartaoModel operacaoModel) => _collection.add(operacaoModel.toMap());

  void update(String documentId, CartaoModel operacaoModel) =>
      _collection.document(documentId).updateData(operacaoModel.toMap());

  void delete(String documentId) => _collection.document(documentId).delete();

  Stream<List<CartaoModel>> listarOperacoes() {
    return _collection.snapshots().map((query) => query.documents
        .map<CartaoModel>((document) => CartaoModel.fromMap(document))
        .toList());
  }

  Future<CartaoModel> findById(String documentId) async {
    var documento = await _collection
        .document(documentId)
        .get()
        .catchError(() => {print("Exc")});
    return CartaoModel.fromMap(documento);
  }

  // Stream<double> somarValor({String idConta, double saldoInicial = 0}) {
  //   if (idConta == null) {
  //     ContaRepository _contaRepository = ContaRepository();

  //     var streamConta = _contaRepository.somarValor();

  //     var streamCartao = _collection.snapshots().map((query) => query
  //         .documents
  //         .map<CartaoModel>((document) => CartaoModel.fromMap(document))
  //         .fold(
  //             saldoInicial,
  //             (sum, element) =>
  //                 sum +
  //                 ((element.tipoCartao == "Despesa" ? -1 : 1) *
  //                     element.saldoInicial)));
  //     return streamConta.zipWith(streamCartao, (um, dois) => um + dois);
  //   }
  //   return _collection.snapshots().map((query) => query.documents
  //       .map<CartaoModel>((document) => CartaoModel.fromMap(document))
  //       .where((element) => idConta == null ? true : element.conta == idConta)
  //       .fold(
  //           saldoInicial,
  //           (sum, element) =>
  //               sum +
  //               ((element.tipoCartao == "Despesa" ? -1 : 1) *
  //                   element.saldoInicial)));
  // }

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
