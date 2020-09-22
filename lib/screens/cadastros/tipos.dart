import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tcc/models/tipomodel.dart';
import 'package:tcc/repositories/tiporepository.dart';
import 'package:tcc/screens/cadastros/tiposform.dart';
import 'package:tcc/screens/template.dart';

class TiposPage extends StatefulWidget {
  TiposPage({Key key}) : super(key: key);

  @override
  _TiposPageState createState() => _TiposPageState();
}

class _TiposPageState extends State<TiposPage> {
  TipoRepository _tipoRepository = TipoRepository();
  TipoModel tipo = TipoModel.parametrizado("descrição-teste", "cor-teste");

  // var tipos = _tipoRepository.listarTipos();

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();
    return Template(
      titulo: "Categorias",
      body: StreamBuilder(
        stream: _tipoRepository.listarTipos(),
        builder: (context, snapshot) => !snapshot.hasData
            ? Text("Carregando")
            : ListView(
                scrollDirection: Axis.vertical,
                children: <Widget>[
                  RaisedButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CadastrarCategoria()),
                    ),
                    child: Text("Incluir nova Categoria"),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * .85,
                    child: ListView.builder(
                      itemCount: snapshot.data.length,
                      shrinkWrap: true,
                      itemBuilder: (ctx, index) {
                        return Card(
                          color: Color(0xFFDDDDDD),
                          child: Container(
                            padding: EdgeInsets.all(0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * .95,
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          (snapshot.data[index] as TipoModel)
                                              .descricao,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        ),
                                        ButtonBarTheme(
                                            data: ButtonBarThemeData(),
                                            child: ButtonBar(
                                              children: <Widget>[
                                                FlatButton(
                                                  child: const Text('LIMPAR'),
                                                  onPressed: () => {},
                                                ),
                                              ],
                                            ))
                                      ]),
                                ),
                                Container(
                                  height: 90,
                                  width: 10,
                                  color: Colors.red,
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
