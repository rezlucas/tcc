import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:tcc/models/tipomodel.dart';
import 'package:tcc/repositories/tiporepository.dart';
import 'package:tcc/screens/template.dart';

class TiposPage extends StatefulWidget {
  TiposPage({Key key}) : super(key: key);

  @override
  _TiposPageState createState() => _TiposPageState();
}

class _TiposPageState extends State<TiposPage> {
  TipoRepository _tipoRepository = TipoRepository();
  TipoModel tipo = TipoModel.parametrizado("ney", "red");

  // var tipos = _tipoRepository.listarTipos();

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();
    return Template(
      titulo: "Cadastro de tipos",
      body: SingleChildScrollView(
        child: Column(
          children: [
            RaisedButton(onPressed: () => {_tipoRepository.add(tipo)}),
            StreamBuilder(
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    controller: scrollController,
                    itemCount: snapshot.data.length,
                    itemBuilder: (ctx, index) {
                      return ListTile(
                          title: Text(
                              (snapshot.data[index] as TipoModel).descricao));
                    },
                    shrinkWrap: true,
                  );
                } else {
                  return Text("carregando");
                }
              },
              stream: _tipoRepository.listarTipos(),
            ),
          ],
        ),
      ),
    );
  }
}
